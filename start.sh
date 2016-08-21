#!/bin/bash

REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$REPODIR/global"

echo "Starting docker-compose project: global"
docker-compose --project-name=global up -d