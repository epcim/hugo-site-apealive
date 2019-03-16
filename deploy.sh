#!/bin/bash

function deploy() {
  echo -e "\033[0;32mDeploying updates to GitHub...\033[0mlding site `date`"
  cd public
    is_repo_clean || commit $@
    git push origin master
  cd ..
}

function commit() {
  if [ $# -eq 1 ]
    then msg="$@"
  fi
  git add .
  git commit -m "$msg"
}

repo_is_clean() {
  git diff-index --quiet HEAD --
}

pipenv install --system --skip-lock &&\
pipenv shell

hugo --theme=hugo-minimalist-theme &&\
chmod -R o+rx static/* public/* && deploy $@

