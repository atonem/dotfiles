#!/usr/bin/env python3

import json
import os
import re

import .utils

def current():
    cmd = os.popen('timew get dom.active.json')
    line = cmd.readline()
    status = cmd.close()
    if not status:
        data = json.loads(line)
        return data

def current_ticket():
    data = current()
    if 'tags' in data:
        tag = next(x for x in data.get('tags') if get_ticket(x))
        ticket = get_ticket(tag)
        if ticket:
            return ticket
