#!/bin/bash

function deploy() {
  if [ ! -d backups/apealive_hugo_$(date "+%Y-%m-%d") ]; then
    rsync -avh epcim@apealive.net:/home/epcim/webapps/apealive_hugo backups/apealive_hugo_$(date "+%Y-%m-%d") &&\
    rsync -avh public/ epcim@apealive.net:/home/epcim/webapps/apealive_hugo/
  else
    rsync -avh public/ epcim@apealive.net:/home/epcim/webapps/apealive_hugo/
  fi
}

rm -rf ./public
hugo --theme=hugo-minimalist-theme &&\
chmod o+rx -R static/* public/* && deploy

