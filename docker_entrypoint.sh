#!/bin/sh
set -ea

_term() { 
  echo "Caught TERM signal!" 
  kill -TERM "$sshwifty_process" 2>/dev/null
}

echo "$(ip -4 route list match 0/0 | awk '{print $3}') startos.internal" >> /etc/hosts

S9CONF="/root/start9/config.yaml"
SSHWIFTY_SHAREDKEY=$(yq '.password' "$S9CONF")

hacker_mode=$(yq '.hackerMode' "$S9CONF")

if [ "$hacker_mode" = "true" ]; then
    export SSHWIFTY_SERVERMESSAGE="⚠️ 🧅 🌍 Hacker Mode Enabled: All traffic will now be routed through the Tor network for enhanced security."
    export SSHWIFTY_SOCKS5="startos.internal:9050"
else
    export SSHWIFTY_SERVERMESSAGE=""
fi

cat >/root/start9/stats.yaml <<EOF
version: 2
data:
  Default Password:
    type: string
    value: "$SSHWIFTY_SHAREDKEY"
    description: Enter this passphrase to log in to the Sshwifty service.
    copyable: true
    masked: true
    qr: false
EOF

printf "\n\n [i] Starting Sshwifty ...\n\n"
/sshwifty.sh &
sshwifty_process=$!

trap _term TERM
wait $sshwifty_process
