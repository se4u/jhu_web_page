#!/usr/bin/env python
'''
| Filename    : org2html.py
| Description : Receive a file containing an org mode style table and print an html
| Author      : Pushpendre Rastogi
| Created     : Wed Aug  5 18:24:42 2015 (-0400)
| Last-Updated:
|           By:
|     Update #: 11

Example
-------
./org2html.py tmp
P:red Q:blue R:green
  | P | Q | R |
P |   | P |   |
Q |   | R | R |
R |   |   |   |
'''
import sys
input_string = open(sys.argv[1], "rb").read().strip()
lines = input_string.split('\n')
color_code = dict(tuple(e.split(':')) for e in lines[0].split())
rows = [line.strip().split('|')[:-1]
        for line
        in lines[1:]]


def special_attribute(color_code, e):
    try:
        return "bgcolor=\"%s\"" % color_code[e]
    except KeyError:
        return ""


def render_row(row):
    return " ".join("<td %s>%s</td>" % (special_attribute(color_code, e.strip()), e) for e in row)

content = "\n".join("<tr>%s</tr>" % render_row(row) for row in rows)
print "<table>%s</table>" % content
