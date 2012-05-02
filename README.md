# Loot

A (very) simple Flowdock hook for Amiando.

## Development

For development create a `.env` file (see `dot.env` for an example).

Start the server with `foreman start`

## Deployment (to Heroku)

### First time deploy

Create the heroku app if you haven't already done so:

    heroku create --stack cedar amiando-hook-for-fakegrimlock

Configure the necessary environment variables (see `dot.env`) with

    heroku config:add MY_VARIABLE=foo

Push the code to Heroku:

    git push heroku master

### nth time deploy

    git push heroku

## Amiando integration

In you event settings, under "Integration", set the `Server call` to:

    https://<heroku-app-name>.herokuapp.com/amiando/<secret>

## Airbrake support

Add your Airbrake API key to Heroku:

    heroku config:add AIRBRAKE=nnn

## License and copyright

Copyright (c) 2012 [Matias Korhonen](http://matiaskorhonen.fi)

Licensed under the MIT license, see the LICENSE file for details.
