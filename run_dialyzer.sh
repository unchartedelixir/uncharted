#! /bin/sh

cd uncharted && mix dialyzer && cd ../uncharted_phoenix && mix dialyzer
