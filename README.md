[![CircleCI](https://circleci.com/gh/adriancarayol/crimemap/tree/master.svg?style=svg&circle-token=7c8f43de1064fd97deb42e2c9dc1aba8d66cf8d1)](https://circleci.com/gh/adriancarayol/crimemap/tree/master)

# Crimemap 💰

Web application created with Phoenix to create and visualize crimes 🚨 committed around the world 🌎.

## Getting started.
* docker-compose up
* mix deps.get
* mix ecto.create
* mix ecto.migration
* mix phx.server

## Enable Google Maps API
In crimemap/lib/crimemap_web/templates/crime/form.html.eex and crimemap/lib/crimemap_web/templates/crime/index.html.eex, you have to put your TOKEN: ?key=TOKEN.

(Yes, it's crap, I hope to replace this operation to read it from an environment variable)
