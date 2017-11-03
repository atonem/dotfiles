handle_failure() {
  # TODO: How to handle faiure?
  #local install_path="$1"
  #rm -rf "$install_path"
  #exit 1
  echo "Failure"
}

handle_cancel() {
  # TODO: How to handle cancel?
  #local install_path="$1"
  #echo -e "\nreceived sigint, cleaning up"
  #handle_failure "$install_path"
  echo "Cancel"
}

local_callback_args="${@:3}"

vim_command() {
  case $1 in

    "add")
      vim_add_plugin $local_callback_args;;

    *)
      help_command
      exit 1;;
  esac

}

vim_add_plugin() {

  local git_url=$1

  while getopts ":t:n:" arg; do
    case $arg in
      t) plugin_type="${OPTARG}"
        ;;
      n) plugin_name="${OPTARG}"
        ;;
      \?) echo "Invalid option -$OPTARG" >&2
        ;;
    esac
  done
  # TODO: Fix args

  # If no plugin name set, use repo name
  if [ -z $plugin_name ]; then
    basename=$(basename $git_url) 
    plugin_name=${basename%.*}
  fi

  # TODO: Allow adding plugin as opt instead of satrt
  git submodule add $git_url "vim/.vim/pack/${plugin_type:-plugins}/start/${plugin_name}"

  echo $git_url
  echo $plugin_type
  echo $plugin_name
  echo "${plugin_type:-plugins}"
}
