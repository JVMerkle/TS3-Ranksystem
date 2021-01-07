#!/bin/sh
set -e

if [ ! "$(whoami)" = "www-data" ]; then
  echo Script must be run as user www-data
  exit 1
fi

# Remove the old instance (if existing)
rm -rf "/var/www/html/"

# Setup base href
BASE_HREF="${BASE_HREF}/"
RS_ROOT="/var/www/html/${BASE_HREF}"

# Copy the RS to the base href
mkdir -p "$RS_ROOT"
cp -r "/var/www/ranksystem/." "$RS_ROOT"

# Copy repository tsicons to the volume
cp -r "${RS_ROOT}tsicons/." /var/www/tsicons/

# Delete the repository tsicons
rm -rf "${RS_ROOT}tsicons"

# Create the link for the tsicons
ln -s /var/www/tsicons/ "${RS_ROOT}tsicons"

cat >"${RS_ROOT}other/dbconfig.php" <<EOF
<?php
\$db['type']="$DB_TYPE";
\$db['host']="$DB_HOST";
\$db['user']="$DB_USERNAME";
\$db['pass']="$DB_PASSWORD";
\$db['dbname']="$DB_NAME";
?>
EOF

worker() {
  cd "${RS_ROOT}"
  while true; do
    php worker.php check
    sleep $(( 10 * 60 )) # Every 10 minutes
  done
}

if [ -z "$INSTALL_MODE" ] || [ "$INSTALL_MODE" = "0" ]; then
  rm -rf "${RS_ROOT}install.php"
  worker &
else
  rm -rf "${RS_ROOT}stats" \
         "${RS_ROOT}webinterface" \
         "${RS_ROOT}index.php" \
         "${RS_ROOT}worker.php"
fi

apache2-foreground
