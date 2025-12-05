---
layout: page
title: Database
permalink: /docs/database/
---

The "DB" class provides a secure interface for database operations using mysqli with prepared statements. Supports debugging, query logging, and automatic parameter binding.

## Select

```
DB::select(string $query, mixed ...$params): array
```

Execute a SELECT query and return all rows. SQL queries use `?` placeholders that are automatically bound to the provided parameters.

Example:

```
$users = DB::select('SELECT * FROM users WHERE username LIKE ?', 'M%');
foreach ($users as $user) {
  echo $user['username'];
}
```

## Select One

```
DB::selectOne(string $query, mixed ...$params): array|false
```

Execute a SELECT query and return the first row, or false if no result.

Example:

```
$user = DB::selectOne('SELECT * FROM users WHERE username = ? LIMIT 1', $username);
if ($user) {
  echo "User ID: " . $user['id'];
}
```

## Select Value

```
DB::selectValue(string $query, mixed ...$params): mixed
```

Execute a SELECT query and return a single value from the first column of the first row, or false if no result.

Example:

```
$count = DB::selectValue('SELECT COUNT(*) FROM users WHERE active = ?', 1);
echo "Active users: " . $count;
```

## Select Values

```
DB::selectValues(string $query, mixed ...$params): array
```

Execute a SELECT query and return an array of values from the first column.

Example:

```
$usernames = DB::selectValues('SELECT username FROM users WHERE active = ?', 1);
print_r($usernames); // ['john', 'jane', 'bob']
```

## Select Pairs

```
DB::selectPairs(string $query, mixed ...$params): array
```

Execute a SELECT query and return key-value pairs using the first column as keys and the second column as values.

Example:

```
$userEmails = DB::selectPairs('SELECT id, email FROM users');
echo $userEmails[123]; // 'user@example.com'
```

## Insert

```
DB::insert(string $query, mixed ...$params): int
```

Execute an INSERT query and return the last insert ID.

Example:

```
$userId = DB::insert(
  'INSERT INTO users (username, password, created) VALUES (?, ?, NOW())',
  $username,
  password_hash($password, PASSWORD_DEFAULT)
);
echo "New user ID: " . $userId;
```

## Update

```
DB::update(string $query, mixed ...$params): int
```

Execute an UPDATE query and return the number of affected rows.

Example:

```
$affectedRows = DB::update(
  'UPDATE users SET username = ? WHERE id = ?',
  $newUsername,
  $userId
);
echo "Updated " . $affectedRows . " rows";
```

## Delete

```
DB::delete(string $query, mixed ...$params): int
```

Execute a DELETE query and return the number of affected rows.

Example:

```
$affectedRows = DB::delete('DELETE FROM users WHERE username = ?', $username);
echo "Deleted " . $affectedRows . " rows";
```

## Query

```
DB::query(string $query, mixed ...$params): mixed
```

Execute a query with optional debugging. Returns query result (array for SELECT, int for INSERT/UPDATE/DELETE).

Example:

```
$result = DB::query('CREATE TABLE logs (id INT PRIMARY KEY, message TEXT)');
```

## Close

```
DB::close(): void
```

Close the database connection.

Example:

```
DB::close();
```