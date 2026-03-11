#!/bin/bash

# process-monitor
# Monitor system processes

# -----------------------------
# Check required commands
# -----------------------------

check_dependencies() {

    for cmd in ps awk sort head clear sleep; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "ERROR: required command '$cmd' not found"
            exit 1
        fi
    done

}

# -----------------------------
# Validate arguments
# -----------------------------

validate_arguments() {

    if [ "$#" -lt 1 ]; then
        echo "Usage:"
        echo "process-monitor --cpu <percent>"
        echo "process-monitor --mem <percent>"
        echo "process-monitor --top <number>"
        echo "process-monitor --top-mem <number>"
        echo "process-monitor --cpu-critical"
        echo "process-monitor --top <number> --watch"
        exit 1
    fi

}

# -----------------------------
# Get process data
# -----------------------------

get_process_data() {

    ps -eo pid,comm,%cpu,%mem --no-headers

}

# -----------------------------
# Print header
# -----------------------------

print_header() {

    printf "%-8s %-20s %-8s %-8s\n" \
    "PID" "PROCESS" "CPU%" "MEM%"

}

# -----------------------------
# Print formatted rows
# -----------------------------

format_output() {

    awk '{printf "%-8s %-20s %-8s %-8s\n",$1,$2,$3,$4}'

}

# -----------------------------
# Filter by CPU
# -----------------------------

filter_cpu() {

    threshold=$1

    get_process_data | awk -v limit="$threshold" '$3 > limit' | format_output

}

# -----------------------------
# Filter by memory
# -----------------------------

filter_memory() {

    threshold=$1

    get_process_data | awk -v limit="$threshold" '$4 > limit' | format_output

}

# -----------------------------
# CPU critical (>90)
# -----------------------------

cpu_critical() {

    get_process_data | awk '$3 > 90' | format_output

}

# -----------------------------
# Top by CPU
# -----------------------------

show_top_cpu() {

    limit=$1

    get_process_data | sort -k3 -nr | head -n "$limit" | format_output

}

# -----------------------------
# Top by Memory
# -----------------------------

show_top_mem() {

    limit=$1

    get_process_data | sort -k4 -nr | head -n "$limit" | format_output

}

# -----------------------------
# Watch mode
# -----------------------------

watch_mode() {

    while true; do

        clear
        print_header

        case "$option" in

            --top)
                show_top_cpu "$value"
                ;;

            --top-mem)
                show_top_mem "$value"
                ;;

        esac

        sleep 2

    done

}

# -----------------------------
# Main
# -----------------------------

main() {

    check_dependencies
    validate_arguments "$@"

    option=$1
    value=$2
    watch_flag=$3

    if [ "$watch_flag" = "--watch" ]; then
        watch_mode
        exit 0
    fi

    print_header

    case "$option" in

        --cpu)
            filter_cpu "$value"
            ;;

        --mem)
            filter_memory "$value"
            ;;

        --top)
            show_top_cpu "$value"
            ;;

        --top-mem)
            show_top_mem "$value"
            ;;

        --cpu-critical)
            cpu_critical
            ;;

        *)
            echo "Invalid option"
            exit 1
            ;;

    esac

}

main "$@"
