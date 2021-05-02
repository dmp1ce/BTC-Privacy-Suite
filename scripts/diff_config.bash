#!/bin/bash

# Diff all generated files used for configuration with templates to see changes
# or updates which are needed

DIR=${DIR:-.}

# shellcheck source=continueYN.bash
. "$DIR/scripts/continueYN.bash"

set -x; diff --color "$DIR/.env" "$DIR/.env.tpl"; set +x
continueYN

# Modified continueYN to skip prompt if nothing changed
diff_result_continue() {
    case "$1" in
        "1") continueYN ;;
        "2") echo "WARNING: missing file for diff"
             continueYN
             ;;
    esac
}

for e in "$DIR/env"/*.env; do
    set -x;
    diff --color "$e" "$e.tpl";
    r="$?"
    set +x
    diff_result_continue "$r"
done

for o in "$DIR/"overrides/*.yml; do
    set -x;
    diff --color "$o" "$o.tpl";
    r="$?"
    set +x
    diff_result_continue "$r"
done
