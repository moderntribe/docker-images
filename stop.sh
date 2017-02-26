#!/bin/bash

REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$REPODIR/global"

echo "Stopping docker-compose project: global"
docker-compose --project-name=global down