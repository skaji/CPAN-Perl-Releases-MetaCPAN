[![Actions Status](https://github.com/skaji/CPAN-Perl-Releases-MetaCPAN/actions/workflows/test.yml/badge.svg)](https://github.com/skaji/CPAN-Perl-Releases-MetaCPAN/actions)

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

CPAN::Perl::Releases::MetaCPAN is just like [CPAN::Perl::Releases](https://metacpan.org/pod/CPAN%3A%3APerl%3A%3AReleases),
but it gets the release information via MetaCPAN API `https://fastapi.metacpan.org/v1/release`.

# SEE ALSO

[CPAN::Perl::Releases](https://metacpan.org/pod/CPAN%3A%3APerl%3A%3AReleases)

[metacpan-api](https://github.com/metacpan/metacpan-api)

[metacpan-web](https://github.com/metacpan/metacpan-web)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
