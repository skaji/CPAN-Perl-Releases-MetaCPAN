use strict;
use warnings;
use Test::More;
use CPAN::Perl::Releases::MetaCPAN;

my $cpan = CPAN::Perl::Releases::MetaCPAN->new;

my $releases = $cpan->get;

my ($one) = grep { $_->{name} eq "perl5.005_62" }  @$releases;

is_deeply $one, {
    'author' => 'GSAR',
    'authorized' => 'true',
    'date' => '1999-10-15T10:36:17.000Z',
    'download_url' => 'http://cpan.metacpan.org/authors/id/G/GS/GSAR/perl5.005_62.tar.gz',
    'name' => 'perl5.005_62',
    'status' => 'backpan',
    'version' => '5.0050062',
};

my $tarballs = CPAN::Perl::Releases::MetaCPAN::perl_tarballs('5.14.0');
is_deeply $tarballs, {
    'tar.bz2' => 'J/JE/JESSE/perl-5.14.0.tar.bz2'
};

my @versions = CPAN::Perl::Releases::MetaCPAN::perl_versions;
my @pumpkins = CPAN::Perl::Releases::MetaCPAN::perl_pumpkins;
note explain \@versions;
note explain \@pumpkins;


done_testing;
