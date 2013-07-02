#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3
import sys
import re
import time

def drink(phenny, input):
    #connect to the database
    con = sqlite3.connect('drink.db')

    #get phenny data
    username = input.nick
    #what happens when called without parameters
    if not input.group(2):
        phenny.say("usage: .drink [0-9]\.[0-9] or .drink top or .drink reset")    

    #only allow floats < 10 
    #TODO: allow decimals without preceding 0
    elif re.match(r'\d(?:\.\d{1,2})?$', input.group(2)):
        value = input.group(2)

        updateDB(username, value, con, phenny)
    elif input.group(2) == "top":
        top(con, phenny)
    elif input.group(2) == "reset":
        #OPTION: Hard reset
        reset(con, username, phenny)
    else:
        phenny.say("usage: .drink [0-9]\.[0-9] or .drink top or .drink reset")    

    con.close()

def reset(con, username, phenny):
    cur = con.cursor()
    cur.execute('DELETE FROM drinks_today JOIN users \
            ON users.user_id = drinks_today.user_id\
            WHERE users.username=?', (username,))
    phenny.say("Okay " + username + ", I'm resetting todays scores")
    con.commit()

def top(con, phenny):
    cur = con.cursor()
    cur.execute('SELECT u.name, SUM(t.amount) AS amount  FROM users u\
                JOIN drinks_today t ON (u.user_id = t.user_id)\
                GROUP BY (u.name) ORDER BY amount DESC LIMIT 3')
    top_amount = cur.fetchall()
    amount_today = "Today: "
    for i in range (0,len(top_amount)):
        #username
        amount_today += top_amont[i][0] + ": "
        #amount
        amount_today += top_amount[i][1] + ", "
    phenny.say(amount_today)
    
    cur.execute('SELECT name, (CASE active_days WHEN 0 THEN 0 ELSE (drinks_total / active_days) END) AS statistic FROM users ORDER BY statistic DESC LIMIT 3')
    top_avg = cur.fetchall()
    top = "Top average: " 
    for i in range(0, len(top_avg):
            top += top_avg[i][0] + ": "
            top += top_avg[i][1] + ", "
    phenny.say(top)

def updateDB(username, value, con, phenny):
    cur = con.cursor()
    cur.execute('SELECT COUNT * FROM users WHERE username=?', (username,))
    exists = cur.fetchone()
    if not exists:
        #create user
        cur.execute('INSERT INTO users(name) VALUES (?)', (username,)) 
        con.commit()
    cur.execute('SELECT user_id FROm users WHERE username=?', (username,))
    user_id = cur.fetchone()
    timestamp = time.time()
    cur.execute('INSERT INTO drinks_today(user_id, amount, timestamp) VALUES (?,?,?)', (user_id, value, timestamp))
    con.commit()
    cur.execute('SELECT SUM(amount) FROM drinks_daily WHERE user_id=?', (user_id,))
    todays_amount = cur.fetchone()
    phenny.say("Okay " + username + ", you drank " + todays_amount + "l today, keep on drinking!")

#phenny shit
drink.commands = ["drink"]
drink.priority = "high"
