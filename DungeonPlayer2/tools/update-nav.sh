#!/usr/bin/env bash
# Re-injects assets/_nav.html into every page.
# Run this after editing assets/_nav.html:   bash tools/update-nav.sh
set -euo pipefail
cd "$(dirname "$0")/.."
NAV=$(tr -d '\r' < assets/_nav.html)

for f in index.html dp2_information.html dp2_gamesystem.html dp2_ein.html dp2_lana.html \
         dp2_billy.html dp2_eone.html dp2_adel.html dp2_town_anshet.html \
         dp2_dungeon_esmiliagrassfield.html dp2_items.html dp2_param_core.html \
         dp2_param_battle.html dp2_spell_fire.html dp2_spell_ice.html dp2_spell_light.html \
         dp2_spell_shadow.html dp2_skill_warrior.html dp2_skill_guardian.html \
         dp2_skill_martialarts.html dp2_skill_archery.html diary.html; do
  [ -f "$f" ] || continue
  nav=$(printf '%s\n' "$NAV" | sed "/<li>/s|href=\"$f\"|href=\"$f\" class=\"active\"|")
  printf '%s\n' "$nav" > /tmp/_nav_active.$$
  tr -d '\r' < "$f" | awk -v navfile="/tmp/_nav_active.$$" '
    /^<aside class="sidebar" id="sidebar">$/ { while ((getline l < navfile) > 0) print l; close(navfile); skip=1; next }
    skip && /^<div class="overlay" id="overlay"><\/div>$/ { skip=0; next }
    !skip { print }
  ' | sed 's/$/\r/' > "$f.tmp"
  mv "$f.tmp" "$f"
  rm -f /tmp/_nav_active.$$
  echo "nav updated: $f"
done
