# TS3 Ranksystem
![compat](https://jvmerkle.de/badges/latest-tsn-rs-compat.svg) ![build](https://img.shields.io/docker/cloud/build/jvmerkle/ts3-ranksystem.svg) ![auto](https://img.shields.io/docker/cloud/automated/jvmerkle/ts3-ranksystem.svg) ![pulls](https://img.shields.io/docker/pulls/jvmerkle/ts3-ranksystem.svg)

System that automatically grants ranks in the form of server groups for online time or online activity to users, using the given server groups of the TS3 server.

This is a modified fork of the TSN-Ranksystem which is updated irregularly to a stable version. It is intended to be **fully compatible to TSN-Ranksystem at all times**. The changeset on branch `develop` is always rebased onto TSN-Ranksystem and later on merged into `master`.

Please make sure that your TSN-Ranksystem (database) version is not above the (database) version of this fork (downgrade) or that the badge "Compatible to latest TSN-Ranksystem" above states "yes".

## Docker
You can find the docker images on docker hub as [jvmerkle/ts3-ranksystem](https://hub.docker.com/r/jvmerkle/ts3-ranksystem).
Please note that the container **MUST BE accessed via a trusted proxy server only** (e.g. nginx).
Make sure to set `BASE_HREF` to the absolute URL path of the rank system (e.g. `https://foobar.com/frank/ranksystem` => `BASE_HREF=/frank/ranksystem/`) in the `docker-compose.yml`

### First time setup
Enable the `INSTALL_MODE=1` in the file `docker-compose.yml` by uncommenting the line. Then start the rank system with:
```sh
docker-compose up -d
```
Navigate to the `install.php` with your browser and set up the rank system.
After performing the first time setup re-edit the `docker-compose.yml` by commenting or removing the `INSTALL_MODE`.
Then start the docker containers in daemon mode:
```sh
docker-compose up -d
```

### Existing installation
Import your database into the `ranksystem-db` container and update the `DB_NAME` of the docker compose file if required.

## Modifications
Additions and (security) improvements to [Newcomer1989/TSN-Ranksystem](https://github.com/Newcomer1989/TSN-Ranksystem)

- Disabled self-updating process, which __exposes information__ to *ts-n.net* such as
  - TeamSpeak Statistics (e.g. users per day/week/month/quarter)
  - Teamspeak hostname and port (e.g. localhost / abc.xyz)
  - ...
  - The update __check__ does __not__ enforce SSL peer verification and is therefore insecure
- Secure api key comparison
- No unnecessary webinterface HTTPS warning for rank systems behind a proxy
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
