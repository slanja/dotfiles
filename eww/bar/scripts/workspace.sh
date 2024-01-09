#!/bin/bash

workspaces() {
    num_workspaces=9

    current_active_tag=$(wmctrl -d | awk '/ \*/ {print $1}')
    current_state=()

    for ((i = 0; i < num_workspaces; i++)); do
        if [ "$current_active_tag" -eq "$i" ]; then
            current_state+=("actual-tag")
        else
            current_state+=("")
        fi
    done

    if [[ "${current_state[*]}" != "${previous_state[*]}" ]]; then
        for ((i = 0; i < num_workspaces; i++)); do
            echo "    (button :class \"works-button ${current_state[i]}\" :onclick \"wmctrl -s $i\" \"◯\")"
        done
        previous_state=("${current_state[@]}")
    fi
}

previous_state=()
previous_active_tag=$(wmctrl -d | awk '/ \*/ {print $1}')
while true; do
    current_active_tag=$(wmctrl -d | awk '/ \*/ {print $1}')
    if [ "$current_active_tag" -ne "$previous_active_tag" ]; then
        workspaces
        echo ""
        previous_active_tag="$current_active_tag"
    fi
done