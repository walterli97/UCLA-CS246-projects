#!/bin/bash

# Uncomment the following two commands to compile and execute your modified ParseJSON code in this script.

javac ParseJSON.java
java ParseJSON

# TASK 2A:
# Create and index the documents using the default standard analyzer
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2a/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"



# TASK 2B:
# Create and index with a whitespace analyzer
curl -XPUT 'http://localhost:9200/task2b/' -d '
{
    "mappings": {
        "wikipage": {
            "_all":{"type":"string", "index":"analyzed", "analyzer":"whitespace"},
            "properties":{
                "title":{"type":"string", "index":"analyzed", "analyzer":"whitespace"},
                "abstract":{"type":"string", "index":"analyzed", "analyzer":"whitespace"},
                "URL":{"type":"string", "index":"analyzed", "analyzer":"whitespace"},
                "sections":{"type": "string", "index":"analyzed", "analyzer":"whitespace"}
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2b/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"



# TASK 2C:
# Create and index with a custom analyzer as specified in Task 2C
curl -XPUT 'http://localhost:9200/task2c/' -d '
{
    "settings": {
        "analysis": {
            "analyzer": {
                "walter_analyzer": {
                    "type": "custom",
                    "char_filter": ["html_strip"],
                    "tokenizer": "standard",
                    "filter": ["asciifolding", "lowercase", "stop", "snowball"]
                }
            }
        }
    },
    "mappings": {
        "wikipage": {
            "_all":{"type":"string", "index":"analyzed", "analyzer":"walter_analyzer"},
            "properties":{
                "title":{"type":"string", "index":"analyzed", "analyzer":"walter_analyzer"},
                "abstract":{"type":"string", "index":"analyzed", "analyzer":"walter_analyzer"},
                "URL":{"type":"string", "index":"analyzed", "analyzer":"walter_analyzer"},
                "sections":{"type": "string", "index":"analyzed", "analyzer":"walter_analyzer"}
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2c/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"


