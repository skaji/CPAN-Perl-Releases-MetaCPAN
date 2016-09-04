package CPAN::Perl::Releases::MetaCPAN;
use strict;
use warnings;

our $VERSION = '0.001';
use HTTP::Tinyish;
use JSON::PP ();

use Exporter 'import';
our @EXPORT_OK = qw(perl_tarballs perl_versions perl_pumbkins);

sub new {
    my ($class, $uri) = @_;
    $uri ||= "http://api.metacpan.org/v0";
    $uri =~ s{/$}{};
    bless { uri => $uri, _cache => undef }, $class;
}

sub get {
    my $self = shift;
    return $self->{_cache} if $self->{_cache};

    my $uri = "$self->{uri}/release/_search?source=";
    my $dist = "perl";
    # copy from https://github.com/metacpan/metacpan-web/blob/master/lib/MetaCPAN/Web/Model/API/Release.pm
    my $query = {
        query => {
            filtered => {
                query  => { match_all => {} },
                filter => { term => { distribution => $dist } }
            }
        },
        size => 250,
        sort => [ { date => 'desc' } ],
        fields => [qw( name date author version status authorized download_url )],
    };
    $uri .= $self->_encode_json($query);
    my $res = HTTP::Tinyish->new->get($uri);
    die "Failed to get $uri: $res->{status} $res->{reason}\n" unless $res->{success};
    my $hash = JSON::PP->new->decode($res->{content});
    $self->{_cache} = [
        grep { ($_->{authorized} || "") eq "true" }
        map { $_->{fields} }
        @{$hash->{hits}{hits}}
    ];
}

sub _encode_json {
    (undef, my $data) = @_;
    my $json = JSON::PP->new->canonical(1)->encode($data);
    $json =~ s/([^a-zA-Z0-9_\-.])/uc sprintf("%%%02x",ord($1))/eg;
    $json;
}

sub _self {
    my $self = eval { $_[0]->isa(__PACKAGE__) } ? shift : __PACKAGE__->new;
    ($self, @_);
}

sub perl_tarballs {
    my ($self, $arg) = _self @_;
    my $releases = $self->get;
    my %tarballs =
        map {
            my $url = $_->{download_url};
            $url =~ s{.*authors/id/}{};
            $url =~ /\.(tar\.\S+)$/;
            ($1 => $url);
        }
        grep { my $name = $_->{name}; $name =~ s/^perl-?//; $name eq $arg }
        grep { $_->{status} eq "cpan" }
        @$releases;
    \%tarballs;
}

sub perl_versions {
    my ($self) = _self @_;
    my $releases = $self->get;
    my @versions =
        map { my $name = $_->{name}; $name =~ s/^perl-?//; $name }
        grep { $_->{status} eq "cpan" }
        @$releases;
    @versions;
}

sub perl_pumpkins {
    my ($self) = _self @_;
    my $releases = $self->get;
    my %author =
        map { $_->{author} => 1 }
        grep { $_->{status} eq "cpan" }
        @$releases;
    sort keys %author;
}

1;
__END__

=encoding utf-8

=head1 NAME

CPAN::Perl::Releases::MetaCPAN - Mapping Perl releases on CPAN to the location of the tarballs via MetaCPAN API

=head1 SYNOPSIS

  use CPAN::Perl::Releases::MetaCPAN;

  # OO
  my $cpan = CPAN::Perl::Releases::MetaCPAN->new;
  my $releases = $cpan->get;

  # Functions
  use CPAN::Perl::Releases::MetaCPAN qw/perl_tarballs/;

  my $hash = perl_tarballs('5.14.0');
  # {
  #   'tar.bz2' => 'J/JE/JESSE/perl-5.14.0.tar.bz2'
  # }

=head1 DESCRIPTION

CPAN::Perl::Releases::MetaCPAN is just like L<CPAN::Perl::Releases>,
but it gets the release information via MetaCPAN API.

In fact, it gets the release information from

L<http://api.metacpan.org/v0/release/_search?source=%7B%22sort%22%3A%5B%7B%22date%22%3A%22desc%22%7D%5D%2C%22query%22%3A%7B%22filtered%22%3A%7B%22query%22%3A%7B%22match_all%22%3A%7B%7D%7D%2C%22filter%22%3A%7B%22term%22%3A%7B%22distribution%22%3A%22perl%22%7D%7D%7D%7D%2C%22size%22%3A250%2C%22fields%22%3A%5B%22name%22%2C%22date%22%2C%22author%22%2C%22version%22%2C%22status%22%2C%22authorized%22%2C%22download_url%22%5D%7D|http://api.metacpan.org/v0/release/_search?source=%7B%22sort%22%3A%5B%7B%22date%22%3A%22desc%22%7D%5D%2C%22query%22%3A%7B%22filtered%22%3A%7B%22query%22%3A%7B%22match_all%22%3A%7B%7D%7D%2C%22filter%22%3A%7B%22term%22%3A%7B%22distribution%22%3A%22perl%22%7D%7D%7D%7D%2C%22size%22%3A250%2C%22fields%22%3A%5B%22name%22%2C%22date%22%2C%22author%22%2C%22version%22%2C%22status%22%2C%22authorized%22%2C%22download_url%22%5D%7D>

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
