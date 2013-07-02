qlite> SELECT DISTINCT u.name, d.* FROM drinks_today d LEFT JOIN users u ON u.user_id = d.user_id;
armesau|1|0.5|
wichtel|2|0.5|
hugo|3|0.5|
bernd|4|0.5|
bernd|4|4.5|
armesau|1|4.5|
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum FROM drinks_today d JOIN users u ON d.user_id = u.user_id GROUP BY d.user_id ) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: u.name
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT DISTINCT u.name, d.* FROM drinks_today d LEFT JOIN users u ON u.user_id = d.user_id;
armesau|1|0.5|
wichtel|2|0.5|
hugo|3|0.5|
bernd|4|0.5|
bernd|4|4.5|
armesau|1|4.5|
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT DISTINCT u.name,SUM(amount), d.* FROM drinks_today d LEFT JOIN users u ON u.user_id = d.user_id;
armesau|28.5|1|4.5|
sqlite> SELECT DISTINCT u.name, d.* FROM drinks_today d LEFT JOIN users u ON u.user_id = d.user_id;
armesau|1|0.5|
wichtel|2|0.5|
hugo|3|0.5|
bernd|4|0.5|
bernd|4|4.5|
armesau|1|4.5|
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT u.name,drinks_sum FROM drinks_today d LEFT JOIN users u ON u.user_id = d.user_id;
Error: no such column: drinks_sum
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT [],drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: 
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT [SELECT DISTINCT users.name FROM users WHERE users.user_id = user_id],drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: SELECT DISTINCT users.name FROM users WHERE users.user_id = user_id
sqlite> SELECT [SELECT users.name FROM users WHERE users.user_id = user_id],drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: SELECT users.name FROM users WHERE users.user_id = user_id
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) INNER JOIN users AS u ON user_id=u.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: ambiguous column name: user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) INNER JOIN users AS u ON drinks_today.user_id=u.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) INNER JOIN users AS u ON u.user_id=drinks_today.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) LEFT JOIN users AS u ON u.user_id=drinks_today.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) JOIN users AS u ON u.user_id=drinks_today.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.user_id
sqlite> SELECT user_id from drinks_today;
1
2
3
4
3
3
3
3
3
3
3
3
3
3
3
2
2
2
2
2
2
2
1
1
1
1
1
1
1
4
4
4
4
4
4
4
1
2
2
4
1
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) JOIN users AS u ON u.user_id=drinks_today.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: ambiguous column name: user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=d.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: d.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=d.user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: d.user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
armesau|9.0
wichtel|9.0
hugo|9.0
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
armesau|9.0
wichtel|9.0
hugo|9.0
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(drinks_today.amount) AS drinks_sum FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: drinks_today.amount
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d GROUP BY user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
armesau|9.0
wichtel|9.0
hugo|9.0
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d GROUP BY d.user_id) JOIN users AS u ON u.user_id=user_id ORDER BY drinks_sum DESC LIMIT 3;
armesau|9.0
wichtel|9.0
hugo|9.0
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d JOIN users AS u ON u.user_id=user_id GROUP BY d.user_id) ORDER BY drinks_sum DESC LIMIT 3;
Error: ambiguous column name: user_id
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d JOIN users AS u ON u.user_id=d.user_id GROUP BY d.user_id) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: u.name
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d JOIN users AS u ON d.user_id=u.user_id GROUP BY d.user_id) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: u.name
sqlite> SELECT u.name,drinks_sum FROM ( SELECT SUM(d.amount) AS drinks_sum FROM drinks_today d JOIN users u ON u.user_id=d.user_id GROUP BY d.user_id) ORDER BY drinks_sum DESC LIMIT 3;
Error: no such column: u.name
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
1|9.0
4|8.5
3|6.0
sqlite> SELECT user_id,drinks_sum FROM ( SELECT SUM(amount) AS drinks_sum,user_id FROM drinks_today GROUP BY user_id ) ORDER BY drinks_sum DESC LIMIT 3;
