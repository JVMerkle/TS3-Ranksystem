# TS3 Ranksystem
System that automatically grants ranks in the form of server groups for online time or online activity to users, using the given server groups of the TS3 server.

This is a modified fork of the TSN-Ranksystem which is updated irregularly to a stable version.

## Docker
Please note that the container **MUST BE accessed via a trusted proxy server only** (e.g. nginx).
Make sure to set `BASE_HREF` to the relative URL path of the rank system (e.g. `https://foobar.com/frank/ranksystem` => `BASE_HREF=/frank/ranksystem/`) in the `docker-compose.yml`

### First time setup
Enable the `INSTALL_MODE=1` in the file `docker-compose.yml` by uncommenting the line. Then start the rank system with:
```sh
docker-compose up
```
Navigate to [http://localhost:8080/install.php](http://localhost:8080/install.php) and set up the rank system. 
After performing the first time setup re-edit the `docker-compose.yml` by commenting or removing the `INSTALL_MODE`. 
Then start the docker containers in daemon mode:
```sh
docker-compose up -d
```

### Existing installation
Import your database into the `ranksystem-db` container and update the `DB_NAME` of the docker compose file if required.

### Accessing the host
If you want to connect to your host teamspeak, use the IP `172.17.0.1` (see [this StackOverflow answer](https://stackoverflow.com/a/48547074/5582419)).

## Differences
Additions and (security) improvements to [Newcomer1989/TSN-Ranksystem](https://github.com/Newcomer1989/TSN-Ranksystem)

- Disabled self-updating process, which __exposes information__ to *ts-n.net* such as
  - TeamSpeak Statistics (e.g. users per day/week/month/quarter)
  - Teamspeak hostname and port (e.g. localhost / abc.xyz)
  - ...
  - The update __check__ does __not__ enforce SSL peer verification and is therefore insecure
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
