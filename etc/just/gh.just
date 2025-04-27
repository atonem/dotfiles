set export


[no-cd]
releases filter="":
  gh release list \
    --limit 15 \
    --json createdAt,name,tagName,publishedAt \
    --jq '[ \
        .[] \
        | select(.tagName \
        | contains("{{filter}}")) \
        | .service += (.tagName | split("/")[0]) \
        | .version += (.tagName | split("/")[1]) \
      ] \
      | unique_by(.service) \
      | sort_by(.service)'
