[![Build Status](https://travis-ci.org/skaji/CPAN-Perl-Releases-MetaCPAN.svg?branch=master)](https://travis-ci.org/skaji/CPAN-Perl-Releases-MetaCPAN)

# NAME

CPAN::Perl::Releases::MetaCPAN - Mapping Perl releases on CPAN to the location of the tarballs via MetaCPAN API

# SYNOPSIS

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

# DESCRIPTION

CPAN::Perl::Releases::MetaCPAN is just like [CPAN::Perl::Releases](https://metacpan.org/pod/CPAN::Perl::Releases),
but it gets the release information via MetaCPAN API.

In fact, it gets the release information from

[http://api.metacpan.org/v0/release/\_search?source=%7B%22sort%22%3A%5B%7B%22date%22%3A%22desc%22%7D%5D%2C%22query%22%3A%7B%22filtered%22%3A%7B%22query%22%3A%7B%22match\_all%22%3A%7B%7D%7D%2C%22filter%22%3A%7B%22term%22%3A%7B%22distribution%22%3A%22perl%22%7D%7D%7D%7D%2C%22size%22%3A250%2C%22fields%22%3A%5B%22name%22%2C%22date%22%2C%22author%22%2C%22version%22%2C%22status%22%2C%22authorized%22%2C%22download\_url%22%5D%7D](http://api.metacpan.org/v0/release/_search?source=%7B%22sort%22%3A%5B%7B%22date%22%3A%22desc%22%7D%5D%2C%22query%22%3A%7B%22filtered%22%3A%7B%22query%22%3A%7B%22match_all%22%3A%7B%7D%7D%2C%22filter%22%3A%7B%22term%22%3A%7B%22distribution%22%3A%22perl%22%7D%7D%7D%7D%2C%22size%22%3A250%2C%22fields%22%3A%5B%22name%22%2C%22date%22%2C%22author%22%2C%22version%22%2C%22status%22%2C%22authorized%22%2C%22download_url%22%5D%7D)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
