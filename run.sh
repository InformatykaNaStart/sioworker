#!/bin/bash
source $WORKER_HOME/venv/bin/activate
supervisord -n -c $WORKER_HOME/sioworkers/config/supervisord.conf

