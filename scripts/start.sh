#!/bin/bash

mix deps.get
mix ecto.setup
mix phx.server
