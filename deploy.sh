#!/bin/sh
rm -rf public
hugo --theme=hugo-minimalist-theme
chmod o+rx -R static/*
rsync -avh public/ epcim@apealive.net:/home/epcim/webapps/apealive_hugo/
