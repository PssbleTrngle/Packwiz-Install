#!/bin/bash

set -e -o pipefail

# Taken from https://github.com/itzg/docker-minecraft-server/blob/a7ecd92244455ed8cc5347b076944ade86a14b56/scripts/start-setupModpack#L30

function log() {
   echo $*
}

if [[ "${PACKWIZ_URL:-}" ]]; then
   if ! packwizInstaller=$(mc-image-helper maven-download \
                        --maven-repo=https://maven.packwiz.infra.link/repository/release/ \
                        --group=link.infra.packwiz --artifact=packwiz-installer --classifier=dist \
                        --skip-existing); then
   log "ERROR: failed to get packwiz installer"
   exit 1
   fi

   log "Running packwiz installer against URL: ${PACKWIZ_URL}"
   if ! java -cp "${packwizInstaller}" link.infra.packwiz.installer.Main -pack-folder /data -s ${PATHWIZ_SIDE} "${PACKWIZ_URL}"; then
   log "ERROR failed to run packwiz installer"
   exit 1
   fi
fi
