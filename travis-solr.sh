#!/usr/bin/env bash

download() {
    echo "Downloading solr from $1..."
    curl -s $1 | tar xz
    echo "Downloaded"
}

is_solr_up(){
    http_code=`echo $(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8983/solr/admin/ping")`
    return `test $http_code = "200"`
}

wait_for_solr(){
    while ! is_solr_up; do
        sleep 3
    done
}

run() {
    echo "Starting solr ..."
    cd $1/example
    java -jar start.jar  > /dev/null 2>&1 &
    wait_for_solr
    echo "Started"
}

post_some_documents() {
    cd exampledocs
    java -Dtype=application/json -Durl=http://localhost:8983/solr/update/json -jar post.jar books.json
}


download_and_run() {
    case $1 in
        3.6.0)
            url="http://apache.rediris.es/lucene/solr/3.6.0/apache-solr-3.6.0.tgz"
            dir_name="apache-solr-3.6.0"
            ;;
        3.6.1)
            url="http://www.us.apache.org/dist/lucene/solr/3.6.1/apache-solr-3.6.1.tgz"
            dir_name="apache-solr-3.6.1"
            ;;
        4.0.0)
            url="http://www.us.apache.org/dist/lucene/solr/4.0.0/apache-solr-4.0.0.tgz"
            dir_name="apache-solr-4.0.0"
            ;;
    esac

    download $url
    run $dir_name
    post_some_documents
}

check_version() {
    case $1 in
        3.6.0|3.6.1|4.0.0);;
        *)
            echo "Sorry, $1 is not supported or not valid version."
            exit 1;
            ;;
    esac
}


check_version $SOLR_VERSION
# check java,curl,tar

download_and_run $SOLR_VERSION