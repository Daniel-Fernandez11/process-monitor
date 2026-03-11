# Process Monitor

A Linux CLI tool to monitor system processes by CPU and memory usage.

This tool helps identify resource-heavy processes quickly from the terminal.

# Features

- Filter processes by CPU usage
- Filter processes by memory usage
- Show top CPU-consuming processes
- Show top memory-consuming processes
- Detect critical CPU usage (>90%)
- Watch mode (auto refresh like top)
- Clean formatted output

## Requirements

Linux system with the following commands available:

ps, awk, sort, head, clear, sleep.

These are included by default on most Linux distributions.

## Installation

Clone the repository:

- git clone https://github.com/Daniel-Fernandez11/process-monitor
- cd process-monitor

Make the script executable:

chmod +x process-monitor.sh

# Usage

## Show top CPU processes

./process-monitor.sh --top 10

## Show top memory processes

./process-monitor.sh --top-mem 10

## Filter by CPU usage

./process-monitor.sh --cpu 50

Shows processes using more than *50% CPU*.

## Filter by memory usage

./process-monitor.sh --mem 10

Shows processes using more than *10% memory*.

## Detect critical CPU usage

./process-monitor.sh --cpu-critical

Shows processes using *more than 90% CPU*.

## Watch mode (live monitoring)

./process-monitor.sh --top 10 --watch

Refreshes every *2 seconds* similar to top.

Stop with:

CTRL + C

# Author

Jose Daniel Fernández - GitHub: https://github.com/Daniel-Fernandez11
