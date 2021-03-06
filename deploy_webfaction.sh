#!/bin/bash

function deploy() {

  # exclude media - default
  excludes='--exclude apealive_hugo/media/'

  if [ ! -d backups/apealive_hugo_$(date "+%Y-%m-%d") ]; then
    rsync -avh epcim@apealive.net:/home/epcim/webapps/apealive_hugo backups/apealive_hugo_$(date "+%Y-%m-%d") &&\
    rsync -avh $excludes public/ epcim@apealive.net:/home/epcim/webapps/apealive_hugo/
  else
    rsync -avh $excludes public/ epcim@apealive.net:/home/epcim/webapps/apealive_hugo/
  fi
}

pipenv install --skip-lock &&\
pipenv shell

rm -rf ./public/*
hugo --theme=hugo-minimalist-theme &&\
chmod -R o+rx static/* public/* && deploy

