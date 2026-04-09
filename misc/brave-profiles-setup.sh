#!/usr/bin/env bash
# Sets up Brave profiles: EdgeLimits (private) and Healper (corporate)
# Run this with Brave CLOSED

BRAVE_CONFIG="$HOME/.config/BraveSoftware/Brave-Browser"
LOCAL_STATE="$BRAVE_CONFIG/Local State"

if pgrep -x brave &>/dev/null; then
  echo "ERROR: Brave is running. Close it first, then re-run this script."
  exit 1
fi

# Create profile directories
mkdir -p "$BRAVE_CONFIG/EdgeLimits"
mkdir -p "$BRAVE_CONFIG/Healper"

# Register profiles in Local State
python3 - <<'EOF'
import json, os, time

state_path = os.path.expanduser("~/.config/BraveSoftware/Brave-Browser/Local State")

with open(state_path, "r") as f:
    state = json.load(f)

profile_cache = state.setdefault("profile", {}).setdefault("info_cache", {})

now = time.time()

profile_cache["EdgeLimits"] = {
    "active_time": now,
    "avatar_icon": "chrome://theme/IDR_PROFILE_AVATAR_26",
    "background_apps": False,
    "default_avatar_fill_color": -14737629,
    "default_avatar_stroke_color": -920588,
    "enterprise_label": "",
    "force_signin_profile_locked": False,
    "gaia_id": "",
    "is_consented_primary_account": False,
    "is_ephemeral": False,
    "is_using_default_avatar": False,
    "is_using_default_name": False,
    "managed_user_id": "",
    "metrics_bucket_index": 2,
    "name": "EdgeLimits",
    "profile_color_seed": -4078337,
    "profile_highlight_color": -14737629,
    "signin.with_credential_provider": False,
    "user_name": ""
}

profile_cache["Healper"] = {
    "active_time": now,
    "avatar_icon": "chrome://theme/IDR_PROFILE_AVATAR_16",
    "background_apps": False,
    "default_avatar_fill_color": -11534337,
    "default_avatar_stroke_color": -16777088,
    "enterprise_label": "",
    "force_signin_profile_locked": False,
    "gaia_id": "",
    "is_consented_primary_account": False,
    "is_ephemeral": False,
    "is_using_default_avatar": False,
    "is_using_default_name": False,
    "managed_user_id": "",
    "metrics_bucket_index": 3,
    "name": "Healper",
    "profile_color_seed": -11534337,
    "profile_highlight_color": -11534337,
    "signin.with_credential_provider": False,
    "user_name": ""
}

# Also add to profile.last_used list if it exists
state["profile"]["last_used"] = state["profile"].get("last_used", "Default")

with open(state_path, "w") as f:
    json.dump(state, f, separators=(",", ":"))

print("Profiles registered: EdgeLimits, Healper")
EOF

echo "Done. You can now launch Brave — both profiles will appear in the profile switcher."
