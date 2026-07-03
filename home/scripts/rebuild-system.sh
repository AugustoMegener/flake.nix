MSG=""
MODE=${1:-test}

shift || true

while getopts "m:" opt; do
  case "$opt" in
    m)
      MSG=$(printf '%s' "$OPTARG" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
      ;;
    *)
      exit 1
      ;;
  esac
done

if [ "$MODE" = "switch" ] && [ -z "$MSG" ]; then
    echo -e "\033[1;31mError: Can not build in $MODE mode without a commit message. Try -m \"<commit msg>\"\033[0m"
    exit 1
fi

cd ~/System/ || exit 1

git add .

sudo nixos-rebuild "$MODE" --flake ~/System#PrimaryOS

if [ $? -eq 0 ] && [ "$MODE" = "switch" ]; then
  git commit -m "$MSG" && git push
fi

if [ "$MODE" != "switch" ]; then
    echo -e "\033[1;33mBuilded in $MODE mode. Do not forget switch to persist changes\033[0m"
fi
