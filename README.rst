travis-solr.sh
==============

Get a Solr instance running with a one-liner and use it in your tests.


Usage
-----

::

  curl https://raw.github.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 bash

Supported versions:

- 3.6.1


Travis-ci
---------

Add this line to your .travis.yml: ::

  before_script: curl https://raw.github.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 bash
