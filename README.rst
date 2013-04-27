travis-solr.sh
==============

Get a Solr instance running with a one-liner and use it in your tests.


Usage
-----

::

  curl https://raw.github.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 SOLR_CONFS=schema.xml solrconfig.xml SOLR_DOCS=custom_docs.json bash

SOLR_VERSION:
.............

You have to specify one of these versions:

- 3.5.0
- 3.6.0
- 3.6.1
- 3.6.2
- 4.0.0
- 4.1.0
- 4.2.0
- 4.2.1

SOLR_CONFS:
...........

If you need to use some custom configuration you can specify one or more files 
in this variable and the script will copy it in the solr conf folder.

Don't use it if you need the default solr settings.

SOLR_DOCS:
..........

By default the script will index exampledocs/books.json documents. You can point
this variable to a json file that contains your custom documents.


Travis-ci
---------

Edit your .travis.yml and use travis-solr as a *before_script* script. 
For example if you want to use solr 3.6.1 with the default settings you can add this
line to your .travis.yml: ::

  before_script: curl https://raw.github.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 bash
