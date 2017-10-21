#!/bin/bash

REPO="${1}"
REF="${2}"
BRANCH="$(basename ${REF})"
ROOT="/services/projects"
REPOLIST="${ROOT}/repos"
REPODIR="${ROOT}/${REPO}"
BRANCHDIR="${REPODIR}/${BRANCH}"

. "${ROOT}/deploy.env"

if [ ! -e "${ROOT}/repos" ]; then
  echo "The file ${REPOLIST} must exist"
  exit 1
fi

if [ -z "${NAMESPACE}" ]; then
  echo "Please set NAMESPACE in ${ROOT}/deploy.env"
  exit 1
fi

grep -q "^${REPO}$" "${REPOLIST}" || exit 0

mkdir -p "${ROOT}/${REPO}"

if [ ! -d "${BRANCHDIR}" ]; then
  git clone -b "${BRANCH}" "https://github.com/${NAMESPACE}/${REPO}.git" "${BRANCHDIR}"
fi

cd "${BRANCHDIR}"
git reset --hard
git checkout "${BRANCH}"
git pull -f origin "${BRANCH}"
[ -x "./prod.sh" ] && ./prod.sh "${BRANCH}"
docker system prune -a -f
