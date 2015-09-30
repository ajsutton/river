River
=====

[![Build Status](https://travis-ci.org/ajsutton/river.svg?branch=master)](https://travis-ci.org/ajsutton/river)

River is a combination of experimenting with ruby and experimenting with software needed for running a church.

Requirements
------------

Apart from ruby and the gems listed in Gemfile, the database must be postgresql 9.4 (required for the jsonb support).

Running Tests
-------------

Acceptance tests are written using RSpec and can be run with:

	./bin/rake spec