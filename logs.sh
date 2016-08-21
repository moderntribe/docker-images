#!/bin/bash

REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

cd "$REPODIR/global"

docker-compose --project-name=global logs