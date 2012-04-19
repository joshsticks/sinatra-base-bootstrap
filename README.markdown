# Sinatra Base App - Bootstrap

A basic starter project for personal reference, using Twitter Bootstrap. Forked from subblue's subblue/SinatraBaseApp 


## Setup

    git clone git@github.com:subblue/SinatraBaseApp.git
    bundle install


## Local dev

    shotgun

and check that the Procfile will work when deployed on the Cedar stack:

    foreman start


## Auto-compile Coffeescripts

    cake watch



## Heroku setup

For the new Cedar stack

    heroku create NAME --stack cedar --addons memcache

else rename/delete Procfile and

    heroku create NAME --stack bamboo



## Deploy

    git push heroku master
    heroku open


## Scale

    heroku scale web=2


## Introspect

    heroku ps
    heroku info
    heroku releases
    heroku logs --tail -s app


## Manage

    heroku config:add ENV_VAR=value
    heroku run bundle exec rake task:name
    heroku run bash

