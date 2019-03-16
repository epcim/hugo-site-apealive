#!/bin/bash

pipenv install --skip-lock &&\
pipenv shell

hugo --system --theme=hugo-minimalist-theme serve
