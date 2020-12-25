#!/bin/sh
set -e

if [ ! "$(whoami)" = "www-data" ]; then
        echo Script must be run as user www-data
        exit 1
fi

worker() {
        cd /var/www/html/ranksystem
        while true; do
                php worker.php check
                sleep $(( 10 * 60 )) # Every 10 minutes
        done
}

worker &
apache2-foreground
