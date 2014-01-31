#!/usr/bin/env bash

SOLR_PORT=${SOLR_PORT:-8983}

download() {
    echo "Downloading solr from $1..."
    curl -s $1 | tar xz
    echo "Downloaded"
}

is_solr_up(){
    http_code=`echo $(curl -s -o /dev/null -w "%{http_code}" "http://localhost:$SOLR_PORT/solr/admin/ping")`
    return `test $http_code = "200"`
}

wait_for_solr(){
    while ! is_solr_up; do
        sleep 3
    done
}

run() {
    echo "Starting solr on port ${SOLR_PORT}..."

    cd $1/example
    if [ $DEBUG ]
    then
        java -Djetty.port=$SOLR_PORT -jar start.jar &
    else
        java -Djetty.port=$SOLR_PORT -jar start.jar > /dev/null 2>&1 &
    fi
    wait_for_solr
    cd ../../
    echo "Started"
}

post_some_documents() {
    java -Dtype=application/json -Durl=http://localhost:$SOLR_PORT/solr/update/json -jar $1/example/exampledocs/post.jar $2
}


download_and_run() {
    case $1 in
        3.5.0)
            url="http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz"
            dir_name="apache-solr-3.5.0"
            dir_conf="conf/"
            ;;
        3.6.0)
            url="http://archive.apache.org/dist/lucene/solr/3.6.0/apache-solr-3.6.0.tgz"
            dir_name="apache-solr-3.6.0"
            dir_conf="conf/"
            ;;
        3.6.1)
            url="http://archive.apache.org/dist/lucene/solr/3.6.1/apache-solr-3.6.1.tgz"
            dir_name="apache-solr-3.6.1"
            dir_conf="conf/"
            ;;
        3.6.2)
            url="http://archive.apache.org/dist/lucene/solr/3.6.2/apache-solr-3.6.2.tgz"
            dir_name="apache-solr-3.6.2"
            dir_conf="conf/"
            ;;
        4.0.0)
            url="http://archive.apache.org/dist/lucene/solr/4.0.0/apache-solr-4.0.0.tgz"
            dir_name="apache-solr-4.0.0"
            dir_conf="collection1/conf/"
            ;;
        4.1.0)
            url="http://archive.apache.org/dist/lucene/solr/4.1.0/solr-4.1.0.tgz"
            dir_name="solr-4.1.0"
            dir_conf="collection1/conf/"
            ;;
        4.2.0)
            url="http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz"
            dir_name="solr-4.2.0"
            dir_conf="collection1/conf/"
            ;;
        4.2.1)
            url="http://archive.apache.org/dist/lucene/solr/4.2.1/solr-4.2.1.tgz"
            dir_name="solr-4.2.1"
            dir_conf="collection1/conf/"
            ;;
        4.3.1)
            url="http://archive.apache.org/dist/lucene/solr/4.3.1/solr-4.3.1.tgz"
            dir_name="solr-4.3.1"
            dir_conf="collection1/conf/"
            ;;
        4.4.0)
            url="http://archive.apache.org/dist/lucene/solr/4.4.0/solr-4.4.0.tgz"
            dir_name="solr-4.4.0"
            dir_conf="collection1/conf/"
            ;;
        4.5.0)
            url="http://archive.apache.org/dist/lucene/solr/4.5.0/solr-4.5.0.tgz"
            dir_name="solr-4.5.0"
            dir_conf="collection1/conf/"
            ;;
        4.5.1)
            url="http://archive.apache.org/dist/lucene/solr/4.5.1/solr-4.5.1.tgz"
            dir_name="solr-4.5.1"
            dir_conf="collection1/conf/"
            ;;
        4.6.0)
            url="http://archive.apache.org/dist/lucene/solr/4.6.0/solr-4.6.0.tgz"
            dir_name="solr-4.6.0"
            dir_conf="collection1/conf/"
            ;;
        4.6.1)
            url="http://archive.apache.org/dist/lucene/solr/4.6.1/solr-4.6.1.tgz"
            dir_name="solr-4.6.1"
            dir_conf="collection1/conf/"
            ;;
    esac

    download $url

    # copies custom configurations
    for file in $SOLR_CONFS
    do
        if [ -f $file ]
        then
            cp $file $dir_name/example/solr/$dir_conf
            echo "Copied $file into solr conf directory."
        fi
    done

    # Run solr
    run $dir_name $SOLR_PORT

    # Post documents
    if [ -z "$SOLR_DOCS" ]
    then
        echo "$SOLR_DOCS not defined, skipping initial indexing"
    else
        echo "Indexing $SOLR_DOCS"
        post_some_documents $dir_name $SOLR_DOCS
    fi
}

check_version() {
    case $1 in
        3.5.0|3.6.0|3.6.1|3.6.2|4.0.0|4.1.0|4.2.0|4.2.1|4.3.1|4.4.0|4.5.0|4.5.1|4.6.0|4.6.1);;
        *)
            echo "Sorry, $1 is not supported or not valid version."
            exit 1
            ;;
    esac
}


check_version $SOLR_VERSION
download_and_run $SOLR_VERSION
