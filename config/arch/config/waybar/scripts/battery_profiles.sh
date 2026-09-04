#!/usr/bin/env bash
set -euo pipefail

PP="/sys/firmware/acpi/platform_profile"
TEE="/run/current-system/sw/bin/tee" # Verify with: command -v tee

get() {
  if [[ -r "$PP" ]]; then
    tr -d '\n' < "$PP"
  else
    echo -n "unknown"
  fi
}

setp() {
  # Requires sudoers rule for tee to this exact file
  echo "$1" | sudo "$TEE" "$PP" >/dev/null
}

if [[ "${1:-}" == "toggle" ]]; then
  cur="$(get)"
  case "$cur" in
    performance) next="balanced" ;;
    balanced)    next="low-power" ;;
    low-power|low_power|power-saver|powersave) next="performance" ;;
    *)           next="balanced" ;;
  esac
  setp "$next" || exit 1
fi

cur="$(get)"
case "$cur" in
  performance) icon="󰓅 " ; klass="performance" ; name="Performance" ;;
  balanced)    icon="󰾅 "  ; klass="balanced"    ; name="Balanced" ;;
  low-power|low_power|power-saver|powersave)
               icon="󰾆 " ; klass="power-saver" ; name="Power Saver" ;;
  *)           icon=" "  ; klass="unknown"     ; name="Unknown" ;;
esac

# Output JSON: text is the icon; tooltip shows current mode
printf '{ "text": "%s", "class": "%s", "tooltip": "Current mode: %s" }\n' \
  "$icon" "$klass" "$name"
