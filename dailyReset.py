#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3

#open connection
con = sqlite3.connect('drink.db')
cur = con.cursor()

#get all entered userIDs and cumulated drinks from the past day
cur.execute('SELECT user_id, drink_sum FROM (SELECT sum(amount) AS drink_sum, user_id FROM drinks_today GROUP BY user_id) ORDER BY drink_sum DESC')
daily_totals = cur.fetchall()

#for every user: increment active days, add to total drinks
for user in daily_totals:
    cur.execute('UPDATE users SET active_days = active_days + 1, drinks_total = drinks_total + ? WHERE user_id = ?',(user[1],user[0]))

#move drinks_today to drinks_archive
cur.execute('SELECT * INTO drinks_archive FROM drinks_today')
cur.execute('DELETE FROM drinks_today')

#aaaand bye
con.commit()
con.close()
