#!/bin/bash

QUERY=$1

curl -s -XGET 'localhost:9200/task1a/_search?pretty' -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "must_not": {"match": {"sections": "'$QUERY'"}},
      "must": [
        { 
            "match": { 
                "title": {
                    "query": "'$QUERY'",
                    "boost": 10
                }
            }
        },
        {
            "match": { 
                "abstract": "'$QUERY'"
            }
        }
      ]
    }
  }
}
'
