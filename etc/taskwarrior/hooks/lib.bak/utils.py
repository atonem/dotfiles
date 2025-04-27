#!/usr/bin/env python3

TICKET_MATCHER = re.compile(r'\w+-\d+')

def get_ticket(value: str):
    if TICKET_MATCHER.match(value):
        return value.upper()

