#!/bin/bash
# Show unique app_ids for the focused workspace
swaymsg -t get_tree | jq -r '
  .. | select(.type? == "workspace" and .focused == false and (.nodes // [] | .. | .focused? == true)) // (.. | select(.type? == "workspace" and .focused == true)) |
  .. | select(.type? == "con" or .type? == "floating_con") | select(.app_id != null or .window_properties != null) |
  if .app_id != null then .app_id else .window_properties.class end
' 2>/dev/null | sort -u | tr '\n' '  ' | sed 's/  $//'
