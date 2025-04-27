set export

default:
  @just -f {{source_file()}} --list

status issue:
  jira issue view {{issue}} --raw | jq .fields.status.name
