package RT::Extension::FastGroupRights;

use warnings;
use strict;
our $VERSION = '0.01';

1;

__END__

=head1 NAME

RT::Extension::FastGroupRights - Replaces global GroupRights.html

=head1 SYNOPSIS

This Plugin replaces the following pages:

- Queue/GroupRights.html
- Group/GroupRights.html
- CustomField/GroupRights.html
- Global/GroupRights.html
- RTFM/Global/GroupRights.html
- RTFM/Class/GroupRights.html
- AssetTracker/Global/GroupRights.html
- AssetTracker/Types/GroupRights.html

to get a faster GroupRights Page display. It will only display Groups
with already granted rights and a searchbox.

=over 2

=back

=head1 INSTALLATION

Installation Instructions for RT-Extension-FastGroupRights:

	1. perl Makefile.PL
	2. make
	3. make install
	4. Add 'RT::Extension::FastGroupRights' to 
		@Plugins in /opt/rt3/etc/RT_SiteConfig.pm
	5. Clear mason cache: rm -rf /opt/rt3/var/mason_data/obj
	6. Restart webserver

=head1 AUTHOR

Torsten Brumm <tbrumm@mac.com>

=head1 COPYRIGHT AND LICENCE
 
Copyright (C) 2010, Torsten Brumm.
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
