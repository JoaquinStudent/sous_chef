#!/usr/bin/env bash
# Sous Chef timer — checks active-timers.json for expired timers and announces via voice
TIMERS_FILE="$HOME/.openbase/sous-chef/active-timers.json"

[ -f "$TIMERS_FILE" ] || exit 0
[ -s "$TIMERS_FILE" ] || exit 0

NOW=$(date +%s)
REMAINING=""

while IFS= read -r line; do
  expires_at=$(echo "$line" | python3 -c "import sys,json; print(json.loads(sys.stdin.read())['expires_at'])" 2>/dev/null)
  [ -z "$expires_at" ] && continue

  if [ "$NOW" -ge "$expires_at" ]; then
    message=$(echo "$line" | python3 -c "import sys,json; print(json.loads(sys.stdin.read())['message'])" 2>/dev/null)
    next_step=$(echo "$line" | python3 -c "import sys,json; d=json.loads(sys.stdin.read()); print(d.get('next_step',''))" 2>/dev/null)
    full_msg="$message"
    [ -n "$next_step" ] && full_msg="$message $next_step"
    openbase-coder user say "Sous Chef" "$full_msg" 2>/dev/null
  else
    [ -n "$REMAINING" ] && REMAINING="$REMAINING"$'\n'
    REMAINING="$REMAINING$line"
  fi
done < "$TIMERS_FILE"

printf '%s' "$REMAINING" > "$TIMERS_FILE"
