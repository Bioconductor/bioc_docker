#!/bin/bash
# ============================================================================
# Start a virtual X server on Linux and Mac OS X
# ----------------------------------------------------------------------------
#
# A virtual X server is needed to non-interactively run:
#   1) 'R CMD build' on some BioC packages like
#        - cellHTS
#        - OrderedList
#        - pcot2
#        - twilight
#      and may be more...
#   2) 'R CMD check' on some other BioC packages like
#        - adSplit
#        - BeadExplorer
#        - gff3Plotter
#        - limma
#
# Typical use:
#   . $BBS_HOME/utils/start-virtual-X.sh
#   $BBS_HOME/BBS-run.py no-bin
#   . $BBS_HOME/utils/stop-virtual-X.sh
#
# IMPORTANT: start-virtual-X.sh and stop-virtual-X.sh _must_ be sourced!
# Using them like this
#   $BBS_HOME/utils/start-virtual-X.sh
#   $BBS_HOME/utils/stop-virtual-X.sh
# will start 2 child shells and then shell #2 (stop-virtual-X.sh) will not see
# the xvfb_pid variable defined by shell #1 (start-virtual-X.sh).
#
# ----------------------------------------------------------------------------

XVFB_CMD="Xvfb"

# First, check to see if Xvfb is already running. If so, display
# information about the running processes, and kill them.

kill_Xvfb_processes()
{
    Xvfb_processes=`ps aux | grep -v grep | grep $XVFB_CMD`
    if [ "$Xvfb_processes" != "" ]; then
        echo ""
        echo "========================================================"
        date
        echo "Found one or more Xvfb processes already running!"
        echo "Output of 'ps aux | grep -v grep | grep Xvfb':"
        echo $Xvfb_processes
        echo "Killing all running Xvfb processes owned by this user..."
        killall -u `whoami` $XVFB_CMD
        echo "--------------------------------------------------------"
    fi
}

if [ "$VIRTUALX_OUTPUT_FILE" == "" ]; then
    kill_Xvfb_processes
else
    kill_Xvfb_processes >>"$VIRTUALX_OUTPUT_FILE" 2>&1
fi

# The Xvfb executable should be located in /usr/X11R6/bin/ (on SuSE <= 10.1
# and Mac OS X 10.4.*) and in /usr/bin/ (on SuSE > 10.1)
if [ `uname -s` == "Darwin" ]; then
    XVFB_CMD="/usr/X11R6/bin/$XVFB_CMD"
fi

PID=$$

if [ "$VIRTUALX_OUTPUT_FILE" == "" ]; then
    $XVFB_CMD :1 -screen 0 800x600x16 &
    xvfb_pid=$!
else
    print_startup_msg()
    {
        echo ""
        echo "========================================================"
        echo "STARTING a virtual X server"
        echo "---------------------------"
        date
    }
    print_startup_msg >>"$VIRTUALX_OUTPUT_FILE" 2>&1
    $XVFB_CMD :1 -screen 0 800x600x16 >>"$VIRTUALX_OUTPUT_FILE" 2>&1 &
    xvfb_pid=$!
    print_post_startup_msg()
    {
        echo "xvfb_pid=$xvfb_pid"
        echo "--------------------------------------------------------"
    }
    print_post_startup_msg >>"$VIRTUALX_OUTPUT_FILE" 2>&1
fi

export DISPLAY=:1.0

