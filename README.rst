travis-solr.sh
==============

Get a Solr instance running with a one-liner and use it in your tests.


Usage
-----

::

  curl -sSL https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 SOLR_CONFS="schema.xml solrconfig.xml" SOLR_DOCS=custom_docs.json bash

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
- 4.3.1
- 4.4.0
- 4.5.0
- 4.5.1
- 4.6.0
- 4.6.1
- 4.7.0
- 4.7.1
- 4.7.2
- 4.8.0

SOLR_CONFS:
...........

If you need to use some custom configuration you can specify one or more files
in this variable and the script will copy it in the solr conf folder.

Be sure to surround multiple values with quotes.

Don't use it if you need the default solr settings.

SOLR_DOCS:
..........

By default the script will not index any documents. You can point
this variable to a json file that contains your custom documents for indexing.

SOLR_PORT:
..........

If you want your Solr instance to run on a different TCP port, define this variable;
Solr will run on the default port 8983 if left blank.

Travis-ci
---------

Edit your .travis.yml and use travis-solr as a *before_script* script.
For example if you want to use solr 3.6.1 with the default settings you can add this
line to your .travis.yml: ::

  before_script: curl https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 bash
