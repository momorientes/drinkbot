#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3

con = sqlite3.connect('drink.db')
cur = con.cursor()
cur.execute('DROP TABLE Daily')
con.commit()
con.close()
