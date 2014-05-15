#!/bin/bash

sudo -u jenkins ./install.sh && sudo /etc/init.d/jenkins stop && sudo /etc/init.d/jenkins start

