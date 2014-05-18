SETUP
=====

```
$ bundle
$ bundle exec rake db:setup

```

SQL
===

```
$ rails db
```

```sql
mysql> select * FROM exercises;
+----+------+----------+---------------------+---------------------+
| id | type | duration | created_at          | updated_at          |
+----+------+----------+---------------------+---------------------+
|  1 | Run  |     1200 | 2012-02-27 00:00:00 | 2014-05-18 04:57:39 |
|  2 | Run  |     2400 | 2012-02-27 00:00:00 | 2014-05-18 04:57:39 |
|  3 | Run  |     3600 | 2012-02-28 00:00:00 | 2014-05-18 04:57:39 |
|  4 | Swim |     1800 | 2012-02-28 00:00:00 | 2014-05-18 04:57:39 |
|  5 | Swim |     3600 | 2012-02-28 00:00:00 | 2014-05-18 04:57:39 |
+----+------+----------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> SELECT e1.id, e1.type, e1.duration, e1.created_at
    -> FROM exercises e1
    -> INNER JOIN(
    ->   SELECT created_at,
    ->          MAX(duration) AS duration,
    ->          type
    ->   FROM exercises
    ->   GROUP BY created_at,
    ->            type
    -> ) e2
    -> ON e1.type = e2.type
    -> AND e1.duration = e2.duration
    -> AND e1.created_at = e2.created_at;
+----+------+----------+---------------------+
| id | type | duration | created_at          |
+----+------+----------+---------------------+
|  2 | Run  |     2400 | 2012-02-27 00:00:00 |
|  3 | Run  |     3600 | 2012-02-28 00:00:00 |
|  5 | Swim |     3600 | 2012-02-28 00:00:00 |
+----+------+----------+---------------------+
3 rows in set (0.00 sec)
```

Ruby
====

```
$ rails c
```

```ruby
irb(main):001:0> Exercise.all
=> [#<Run id: 1, type: "Run", duration: 1200, created_at: "2012-02-27 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Run id: 2, type: "Run", duration: 2400, created_at: "2012-02-27 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Run id: 3, type: "Run", duration: 3600, created_at: "2012-02-28 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Swim id: 4, type: "Swim", duration: 1800, created_at: "2012-02-28 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Swim id: 5, type: "Swim", duration: 3600, created_at: "2012-02-28 00:00:00", updated_at: "2014-05-18 04:57:39">]

irb(main):002:0> Exercise.joins("
  INNER JOIN(
    SELECT created_at,
           MAX(duration) AS duration,
           type
    FROM exercises
    GROUP BY created_at,
             type
  ) e2
  ON exercises.type = e2.type
  AND exercises.duration = e2.duration
  AND exercises.created_at = e2.created_at
")
=> [#<Run id: 2, type: "Run", duration: 2400, created_at: "2012-02-27 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Run id: 3, type: "Run", duration: 3600, created_at: "2012-02-28 00:00:00", updated_at: "2014-05-18 04:57:39">,
#<Swim id: 5, type: "Swim", duration: 3600, created_at: "2012-02-28 00:00:00", updated_at: "2014-05-18 04:57:39">]

```
