#!/bin/bash
ansible node1 -m hostname -a 'name=lt-2021-095-webserver1'
ansible node2 -m hostname -a 'name=lt-2021-095-webserver2'

