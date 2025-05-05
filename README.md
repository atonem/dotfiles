# dotfiles
This is my current working dotfiles management setup using [chezmoi](https://github.com/twpayne/chezmoi).

## init
Run the following command in a terminal to provision a new a machine:

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/atonem/dotfiles/refs/heads/master/install.sh)"
```

To do a dry-run (or to pass other args), simply append send them to the evaluated expression:

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/atonem/dotfiles/refs/heads/master/install.sh)" \
  --dry-run
```

