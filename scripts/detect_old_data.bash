#!/bin/bash

# Detect and warn if old data mounts are present

DIR=${DIR:-.}

# shellcheck source=continueYN.bash
. "$DIR/scripts/continueYN.bash"

old_data=( tor_data tor_config bitcoin_data electrs_data joinmarket_bech32_data \
           joinmarket_data lnd_data lnd-personal_data specter_data node_data nginx_keys)


pWARNING() { echo "WARNING: $1"; }
pINFO()    { echo "         $1"; }

detected_problem=

for d in "${old_data[@]}"; do
    if [ -d "$d" ]; then
        detected_problem=t

        pWARNING "Old data directory '$d' exists! Make sure data has been \
migrated to '.data' before continuing."

        case "$d" in
            "tor_data")
                pINFO "Suggestion: \`mv $d .data/tor/data\`"
                ;;
            "tor_config")
                pINFO "Suggestion: \`mv $d .data/tor/config\`"
                ;;
            "electrs_data")
                pINFO "Suggestion: \`mv $d .data/electrs/electrs\`"
                ;;
            "nginx_keys")
                pINFO "Suggestion: \`mv $d .data/electrs/nginx\`"
                ;;
            *)
                pINFO "Suggestion: \`mv $d .data/${d%_*}\`"
                ;;
        esac
    fi

    if compgen -G "${DIR}/overrides/*.yml" > /dev/null; then
        config_changes_needed=$(grep "$d" "$DIR"/overrides/*.yml "$DIR"/*.yml)
    else
        config_changes_needed=$(grep "$d" "$DIR"/*.yml)
    fi

    if [ -n "$config_changes_needed" ]; then
        detected_problem=t
        pWARNING "Old data configuration detected! Update yml files below:"
        echo "$config_changes_needed"
    fi
done

if [ -n "$detected_problem" ]; then continueYN; fi
