relink:
  ./submodules/dotbot/bin/dotbot -v -c default.yaml --only link

shell:
  ./submodules/dotbot/bin/dotbot -v -c default.yaml --only shell


format-sh:
  shfmt -w -l bin

format-python:
  rg -l python bin | xargs ruff check --select=I --fix
  rg -l python bin | xargs ruff format


format-lua:
  stylua -v etc/nvim

format: format-lua
