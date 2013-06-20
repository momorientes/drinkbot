#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3
import sys
import re
import time

def drink(phenny, input):
    #connect to the database
    con = sqlite3.connect('drink.db')
    #create the tables
    cur = con.cursor()
    cur.execute('CREATE TABLE IF NOT EXISTS AllTime(username TEXT PRIMARY KEY, total FLOAT)')
    #this will be deleted at 00:00 everyday by cron
    cur.execute('CREATE TABLE IF NOT EXISTS Daily(username TEXT PRIMARY KEY, total FLOAT)')
    con.commit()

    #get phenny data
    username = input.nick
    #match irc user names to prevent SQLI
    if not re.match(r"^[A-Za-z0-9_|-]+$", username):
        phenny.say("Something is wrong with your username, please contact momorientes")
    if not input.group(2):
        phenny.say("usage: .drink [0-9]\.[0-9] or .drink top or .drink reset")    
    #only allow floats < 10 
    elif re.match(r'^\d\.\d$', input.group(2)):
        value = input.group(2)
        updateDB(username, value, con, phenny)
        log(username, value)
    elif input.group(2) == "top":
        top(con, phenny)
    elif input.group(2) == "reset":
        phenny.say("Okay " + input.nick + ", I'm resetting your scores")
        reset(con, input.nick)
        log(input.nick, "reset")
    else:
        phenny.say("usage: .drink [0-9]\.[0-9] or .drink top or .drink reset")    

    con.close()

def reset(con, username):
    cur = con.cursor()
    cur.execute('DELETE FROM Daily WHERE username=?', (username,))
    cur.execute('DELETE FROM AllTime WHERE username=?', (username,))
    con.commit()

def top(con, phenny):
    cur = con.cursor()
    cur.execute('SELECT * FROM Daily ORDER BY total desc LIMIT 3')
    daily = cur.fetchall()
    dailyTop = "Daily: "
    for i in range(0,len(daily)):
        #username
        dailyTop += daily[i][0] + ": "
        #value
        dailyTop += str(daily[i][1]) + ", "
    phenny.say(dailyTop)
    cur.execute('SELECT * FROM AllTime ORDER BY total desc LIMIT 5')
    allTime = cur.fetchall()
    allTimeTop = "All Time: "
    for i in range(0,len(allTime)):
        #username
        allTimeTop += allTime[i][0] + ": "
        #value
        allTimeTop += str(allTime[i][1]) + ", "
    phenny.say(allTimeTop)

def updateDB(username, value, con, phenny):
    cur = con.cursor()

    #Daily Database
    cur.execute('INSERT OR IGNORE INTO Daily(username, total)  VALUES (?, ?)', (username,0.0))
    cur.execute('UPDATE Daily SET total = total + ? WHERE username=?', (value,username))
    #AllTime Database
    cur.execute('INSERT OR IGNORE INTO AllTime(username, total)  VALUES (?, ?)', (username,0.0))
    cur.execute('UPDATE AllTime SET total = total + ? WHERE username=?', (value,username))
    con.commit()
    #Get current liter count
    cur.execute('SELECT * FROM Daily WHERE username=?',(username,))
    daily = cur.fetchone()
    cur.execute('SELECT * FROM AllTime WHERE username=?', (username,))
    allTime = cur.fetchone()
    con.commit()
    phenny.say(username + ": Daily: " + str(daily[1]) + " Total: " + str(allTime[1]))

def log(username, message):
    f = open('drink.log', 'a')
    f.write(str(time.time()) + " " + username + " " + str(value) +"\n")
    f.close()

#phenny shit
drink.commands = ["drink"]
drink.priority = "high"

#drink("0.2")
