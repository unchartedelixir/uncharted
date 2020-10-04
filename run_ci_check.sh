#! /bin/sh

cd uncharted && MIX_ENV=test mix do format --check-formatted, test, credo --strict && cd ../uncharted_phoenix && MIX_ENV=test mix do format --check-formatted, test, credo --strict
