travis-solr.sh
==============

Get a Solr instance running with a one-liner and use it in your tests.


Usage
-----

Solr 3.x and 4.x:

::

  curl -sSL https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 SOLR_CONFS="schema.xml solrconfig.xml" SOLR_DOCS=custom_docs.json bash

Solr 5.X:

::

  curl -sSL https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=5.3.1 SOLR_COLLECTION=collection_name SOLR_COLLECTION_CONF=path/to/your/custom/conf SOLR_DOCS=custom_docs.json bash

Sorl 5.X schemaless example

::

  curl -sSL https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=5.3.1 SOLR_DOCS=custom_docs.json bash

SOLR_VERSION:
.............

You have to specify a valid version of Solr. See http://archive.apache.org/dist/lucene/solr/ for available releases.

*Note*: At this time Solr 6 is not supported.

SOLR 3.X and 4.X variables
..........................


SOLR_CONFS:
:::::::::::

If you need to use some custom configuration you can specify one or more files
in this variable and the script will copy it in the solr conf folder.

Be sure to surround multiple values with quotes.

Don't use it if you need the default solr settings.

SOLR_DOCS:
::::::::::

By default the script will not index any documents. You can point
this variable to a json file that contains your custom documents for indexing.

SOLR_PORT:
::::::::::

If you want your Solr instance to run on a different TCP port, define this variable;
Solr will run on the default port 8983 if left blank.

SOLR_CORE:
::::::::::

Select the core, by default core0

DEBUG
:::::

If 'true' prints solr logs

SOLR 5.X variables
..................

SOLR_DOCS:
::::::::::

By default the script will not index any documents. You can point
this variable to a json file that contains your custom documents for indexing.

SOLR_COLLECTION
:::::::::::::::

Collection name to be created. If this variable is not set "gettingstarted" will be the name of the collection

SOLR_COLLECTION_CONF
::::::::::::::::::::

Path to the collection configuration. If not set the schemaless example that comes with solr 5.X will be used


Travis-ci
---------

Edit your .travis.yml and use travis-solr as a *before_script* script.
For example if you want to use solr 3.6.1 with the default settings you can add this
line to your .travis.yml: ::

  before_script: curl -sSL https://raw.githubusercontent.com/moliware/travis-solr/master/travis-solr.sh | SOLR_VERSION=3.6.1 bash
