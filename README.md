# Level 5 Scripts
Various scripts used on Harvard level 5 workstations.

###### ironkey

Perl script that provides a wrapper for mounting and unmounting IronKey data partitions. CentOS 7 improved UX for mounting thumb drives, so the need for this script is technically deprecated.

Usually installed to `/usr/bin`.

###### aide_check.sh

Dumps the aide.log into a local mail message to root user.

Usually installed to `/usr/local/bin`.

###### notify.sh

User accounts must be renewed annually; this script parses `/etc/shadow` to find user expirations and emails the admin and user a notification.

Usually installed to `/usr/local/bin`.

###### make__log__archives.sh

Creates directories based on YYYY-MM format used for archiving logs.

Usually installed to `/usr/local/sbin`.