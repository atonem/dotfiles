set export

APM_QUERY_STRING := "fromUser=false&historicalData=true&paused=false&spanType=all&view=spans"

default:
  @just -f {{source_file()}} --list

_export_times before="-1w":
  @echo "export NOW_MS=$(date +%s)000 export BEFORE_MS=$(date -v {{before}} +%s)000"

_select_project:
  cat {{ source_directory() / 'lib' / 'gcp-projects.txt' }} | fzf

error uuid:
  open https://app.datadoghq.eu/rum/sessions?query=%40type%3Aerror%20%28{{uuid}}%20OR%20%40context.error.uuid%3A{{uuid}}%29

session id:
  open https://app.datadoghq.eu/rum/sessions?query=%40type%3Asession%20%40session.id%3A{{id}}

player id:
  open https://app.datadoghq.eu/rum/sessions?query=%40type%3Asession%20%40usr.id%3A{{id}}

username username:
  open https://app.datadoghq.eu/rum/sessions?query=%40type%3Asession%20%40usr.username%3A{{username}}

query query_name:
  eval "$(just -f {{source_file()}} _export_times)"; \
  open "https://app.datadoghq.eu/apm/traces?query={{ encode_uri_component('service:bol-*-frontend-service operation_name:graphql.execute resource_name:"query ' + query_name +'"') }}&{{APM_QUERY_STRING}}&start=$BEFORE_MS&end=$NOW_MS"

mutation mutation_name:
  eval "$(just -f {{source_file()}} _export_times)"; \
  open "https://app.datadoghq.eu/apm/traces?query={{ encode_uri_component('service:bol-*-frontend-service operation_name:graphql.execute resource_name:"mutation ' + mutation_name +'"') }}&{{APM_QUERY_STRING}}&start=$BEFORE_MS&end=$NOW_MS"

loki filter="":
  eval "$(just -f {{source_file()}} _export_times -15M)"; \
  PROJECT_ID="$(just -f {{source_file()}} _select_project)"; \
  open "https://grafana.leo-dev-common.lvg-tech.net/explore?schemaVersion=1&query={{ encode_uri_component('') }}
  # echo "project id: $PROJECT_ID" \
# 'schemaVersion=1&panes={"ax5":{"datasource":"BqbUBsCVk","queries":[{"refId":"A","expr":"{namespace=\\"stage-brazil\\"}+|=+`3FE9CB50F09199C1`","queryType":"range","datasource":{"type":"loki","uid":"BqbUBsCVk"},"editorMode":"builder"}],"range":{"from":"1723704345409","to":"1723707945409"},"panelsState":{"logs":{"id":"A_1723706511024457340_7a3e0cd1","visualisationType":"logs"}}}}&orgId=1'

# https://grafana.leo-dev-common.lvg-tech.net/explore?schemaVersion=1&panes=%7B%22ax5%22%3A%7B%22datasource%22%3A%22BqbUBsCVk%22%2C%22queries%22%3A%5B%7B%22refId%22%3A%22A%22%2C%22expr%22%3A%22%7Bnamespace%3D%5C%22stage-brazil%5C%22%7D+%7C%3D+%603FE9CB50F09199C1%60%22%2C%22queryType%22%3A%22range%22%2C%22datasource%22%3A%7B%22type%22%3A%22loki%22%2C%22uid%22%3A%22BqbUBsCVk%22%7D%2C%22editorMode%22%3A%22builder%22%7D%5D%2C%22range%22%3A%7B%22from%22%3A%221723704345409%22%2C%22to%22%3A%221723707945409%22%7D%2C%22panelsState%22%3A%7B%22logs%22%3A%7B%22id%22%3A%22A_1723706511024457340_7a3e0cd1%22%2C%22visualisationType%22%3A%22logs%22%7D%7D%7D%7D&orgId=1
