drinkbot
========

A phenny module to keep track of the channels drinking habits

SETUP
=======

move drink.py to your modules directory and whitleist it in your ~/.phenny/defaults.py if neccessary.

In your phenny base dir:
`sqlite3 drink.db`
In the sql shell:
`.read drink.sql`
`.exit`

Now add

`@daily /path/to/dailyReset.py`

to your crontab using `crontab -e` and you're done
