# Create a new directory and enter it
function create-new-directory-and-enter-it() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function get-file-or-folder-size() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
}

# Start an HTTP server from a directory, optionally specifying the port
function start-python-server-on-port-8000() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	python3 -m http.server --cgi 8000
}

# Ip address
function get-ip-address() {
  local ip
  ip="$(dig +short myip.opendns.com @resolver1.opendns.com | tail -n 1)"
  [[ -z "$ip" ]] && ip="$(curl -fsS https://api.ipify.org)"
  [[ -z "$ip" ]] && ip="(unavailable)"
  echo "Your ip is: $ip"
}

function list-ssh-public-keys() {
  local p
  for p in "$HOME/.ssh/"*.pub(N); do
    echo "-- $p"
    cat "$p"
    echo
  done
}

function get-ssh-public-keys() {
  local cfg="${1:-$HOME/.ssh/config}"

  echo "== ssh-agent keys (ssh-add -L) =="
  if command -v ssh-add >/dev/null 2>&1; then
    ssh-add -L 2>/dev/null || echo "(no agent keys loaded)"
  else
    echo "(ssh-add not found)"
  fi
  echo

  echo "== Public key files referenced by config: $cfg =="
  if [[ -f "$cfg" ]]; then
    local f
    while IFS= read -r f; do
      f="${f/#\~/$HOME}"
      [[ "$f" != *.pub && -f "${f}.pub" ]] && f="${f}.pub"
      [[ -f "$f" ]] && { echo "-- $f"; cat "$f"; echo; }
    done < <(awk 'tolower($1)=="identityfile"{print $2}' "$cfg" | sort -u)
  else
    echo "(config not found)"
  fi
  echo

  echo "== All ~/.ssh/*.pub =="
  local p
  for p in "$HOME/.ssh/"*.pub(N); do
    echo "-- $p"
    cat "$p"
    echo
  done
}

# usage: `show-private-key <filename>`, for example: `show-private-key id_ed25519`
function show-private-key() {
  local f="$1"
  [[ -z "$f" ]] && { echo "usage: show_privkey <filename>"; return 2; }

  [[ "$f" != /* ]] && f="$HOME/.ssh/$f"
  [[ "$f" == *.pub ]] && { echo "Refusing: looks like a public key (.pub)"; return 2; }
  [[ -f "$f" ]] || { echo "Not found: $f"; return 1; }

  # Prefer less to avoid dumping into scrollback
  less -F -X "$f"
}
