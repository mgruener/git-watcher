#!/bin/bash

REPO="${1}"
REF="${2}"
BRANCH="$(basename ${REF})"

function apply-stageing {
  cd /root/apply-dev/
  git reset --hard
  ln -s docker-compose.stage.yml docker-compose.override.yml
}

function apply-production {
  cd /root/apply-prod/
  git reset --hard
  ln -s docker-compose.prod.yml docker-compose.override.yml
}

function deploy {
  git checkout "${1}"
  git pull -f origin "${1}"
  if [ -e docker-compose.yml ]; then
    docker-compose down
    docker-compose up -d --build
  fi
  docker system prune -a -f
}

if [ "${REPO}" != "application-manager" ]; then
  exit 0
fi

case "${BRANCH}" in
  master)
    apply-production
    ;;
  *)
    apply-stageing
    ;;
esac

deploy "${BRANCH}"
root@vs ~/watch # 
