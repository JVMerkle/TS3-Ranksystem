# TS3 Ranksystem
System that automatically grants ranks in the form of server groups for online time or online activity to users, using the given server groups of the TS3 server.

This is a modified fork of the TSN-Ranksystem which is updated irregularly to a stable version.

## Differences
Additions and (security) improvements to [Newcomer1989/TSN-Ranksystem](https://github.com/Newcomer1989/TSN-Ranksystem)

- Disabled __INSECURE__ self-updating process, which __exposes information__ to *ts-n.net* such as
  - TeamSpeak Statistics (e.g. users per day/week/month/quarter)
  - Teamspeak hostname and port (e.g. localhost / abc.xyz)
  - ...
  - The update check does __not__ enforce SSL peer verification and is therefore insecure
- Docker-Ready
- Aesthetics:
  - Website title is set to "TS3 Ranksystem"
  - The favicon link is removed from the page head
  - "Ranksystem info" is moved from the navbar to the footer

## History
The following patches are no longer applied (no longer required):

- Removal of base64 encoded "copyright checks" which reported the violation to the *ts-n.net* server:
  - For `info.php` page modifications
  - For removal of the `info.php` hyperlink from the sidebar
- Removal of an April fool
- CSRF protection fix

## License
This project is licensed under the terms of the GNU General Public License v3.0.
