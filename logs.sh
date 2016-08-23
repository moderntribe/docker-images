#!/bin/bash

REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$REPODIR/global"

docker-compose --project-name=global logs --follow