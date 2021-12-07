#!/usr/bin/env bash

if [ 'vagrant' != `whoami` ]; then
  echo -e "${FAIL}Current user `whoami`${WHITE}, please execute script with ${GOOD}vagrant${WHITE} user."
  exit 1
fi

git clone git@bitbucket.org:shopadvizor/ms-devops-helmchart-gcp.git

git clone git@bitbucket.org:shopadvizor/catalog-service-gcp.git

git clone git@bitbucket.org:shopadvizor/review-service.git

exit 0