use strict;
use warnings;
use Test::More;
use CPAN::Perl::Releases::MetaCPAN;

my $cpan = CPAN::Perl::Releases::MetaCPAN->new;

my $releases = $cpan->get;

my ($one) = grep { $_->{name} eq "perl5.005_62" }  @$releases;

is_deeply $one, {
    'author' => 'GSAR',
    'date' => '1999-10-15T10:36:17.000Z',
    'download_url' => 'https://cpan.metacpan.org/authors/id/G/GS/GSAR/perl5.005_62.tar.gz',
    'name' => 'perl5.005_62',
    'status' => 'backpan',
    'version' => '5.005_62',
    'maturity' => 'developer',
    'checksum_sha256' => '67d46acb54ccb215e9646a42a3687695802d4a0e0139902ff3d77b6eaf935229',
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
