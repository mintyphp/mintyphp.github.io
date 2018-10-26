# Database

This class provides 8 public methods and the parameters are:

These functions can be statically accessed from the global "DB" class.

## Select

```
DB::select($sql,$arg1,$arg2,...)
```

Executes SQL containing "?" symbols. Every questionmark must be matched by an extra argument. The following query retrieves all users that have an username starting with a 'M':

```
$users = DB::select('select * from users where username LIKE ?','M%');
```

In the view (.phtml) file we can iterate over records and print the usernames in a HTML list using:

```
<?php foreach ($users as $user): ?>
<li><?php e($user['username']);?></li>
<?php endforeach;?>
```

## Select one

```
DB::selectOne($sql,$arg1,$arg2,...)
```

Same as "records", but only returns the first record or false. Example:

```
$query = 'select * from users where username = ? limit 1';
$user = DB::selectOne($query,$username);
```

## Insert

```
DB::insert()
```

Executes SQL "INSERT" statement and returns the "insert id" from the last executed SQL query. Example:

```
$query = 'insert into users (username,password,created) values (?,?,NOW())';
$userId = DB::insert($query,$username,$password);
```

## Update

```
DB::update()
```

Executes SQL "UPDATE" statement and returns the "affected rows" from the last executed SQL query. Example:

```
$query = 'update users set username = ? where id = ?';
$affectedRows = DB::update($query,$username,$userId);
```

## Delete

```
DB::delete()
```

Executes SQL "DELETE" statement and returns the "affected rows" from the last executed SQL query. Example:

```
$query = 'delete from users where username = ?';
$affectedRows = DB::delete($query,$username);
```

## Query

```
DB::query()
```

Executes other SQL statements and returns a boolean indicating success (true) or failure (false). Example:

```
$query = 'drop table users';
$success = DB::query($query);
```