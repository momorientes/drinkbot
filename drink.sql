CREATE TABLE users(user_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, active_days INTEGER, drinks_total FLOAT) 
CREATE TABLE drinks_today(user_id INTEGER, FOREIGN KEY(user_id) REFERENCES users(user_id), amount FLOAT, timestamp INTEGER)
CREATE TABLE drinks_archive(user_id INTEGER, FOREIGN KEY(user_id) REFERENCES users(user_id), amount FLOAT, timestamp INTEGER)
