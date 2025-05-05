shell_files := `echo "$(shfmt -f .) $(rg --files home/.chezmoiscripts)" | tr '\n' ' '`
toml_files := `rg --files | rg .toml | tr '\n' ' '`


init:
  mise trust
  mise install
  pre-commit install

format:
  shfmt -w {{ shell_files }}
  yamlfmt .
  taplo format

check:
  shfmt -d {{ shell_files }}
  yamlfmt -lint .
  taplo format --check

lint: check
  shellcheck {{ shell_files }}
  taplo lint
