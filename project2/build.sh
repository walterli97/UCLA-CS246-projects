#!/bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset, 
# uncomment the following two commands to compile and execute your modified code in this script.
#
javac ParseJSON.java
java ParseJSON

# TASK 1A:
# Create index "task1a" with "wikipage" type using BM25Similarity 
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task1a/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"


# TASK 1B:
# Create index "task1b" with "wikipage" type using ClassicSimilarity (Lucene's version of TFIDF implementation)
curl -XPUT 'http://localhost:9200/task1b/' -d '
{
    "settings": {
        "index": {
            "similarity": {
                "default": {
                    "type": "classic"
                }
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task1b/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"


# TASK 2:
# Creale index "task2" with "wikipage" type using BM25Similarity with the best k1 and b values that you found
curl -XPUT 'http://localhost:9200/task2/' -d '
{
    "settings": {
        "index": {
            "similarity": {
                "default": {
                    "type": "BM25",
                    "k1": 0.80,
                    "b": 0.50
                }
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"


# Task 3:
# Create index "task3" with "wikipage"
curl -XPUT 'http://localhost:9200/task3b/' -d '
{
    "mappings": {
        "wikipage": {
            "properties": {
                "clicks": {
                    "type": "long",
                    "index": "not_analyzed",
                    "doc_values": true
                },
                "abstract": {
                    "type": "text",
                    "index": "analyzed"
                },
                "title": {
                    "type": "text",
                    "index": "analyzed"
                },
                "url": {
                    "type": "text",
                    "index": "analyzed"
                },
                "sections": {
                    "type": "text",
                    "index": "analyzed"
                }
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task3b/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"
curl -XDELETE "localhost:9200/task3b"
curl -XPUT 'http://localhost:9200/task3b/' -d '
{
    "settings": {
        "index": {
            "similarity": {
                "default": {"type": "cs246-similarity"}
            }
        }
    }
}'
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task3b/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"
