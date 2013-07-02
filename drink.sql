CREATE TABLE users(user_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, active_days INTEGER DEFAULT NULL, drinks_total FLOAT DEFAULT NULL); 
CREATE TABLE drinks_today(user_id INTEGER, amount FLOAT, timestamp INTEGER, FOREIGN KEY(user_id) REFERENCES users(user_id));
CREATE TABLE drinks_archive(user_id INTEGER, amount FLOAT, timestamp INTEGER, FOREIGN KEY(user_id) REFERENCES users(user_id));
