---
layout: page
title: Cache
permalink: /docs/cache/
---

The "Cache" class provides caching operations using Memcached with support for debugging and monitoring.

## Get

```
Cache::get(string $key): mixed
```

Retrieve a value from the cache. Returns the cached value, or false if not found.

Example:

```
$user = Cache::get('user_123');
if ($user !== false) {
  // User data found in cache
  echo "Welcome " . $user['name'];
} else {
  // Fetch from database and cache it
  $user = DB::selectOne('users', 'id', 123);
  Cache::set('user_123', $user, 3600);
}
```

## Set

```
Cache::set(string $key, mixed $var, int $expire = 0): bool
```

Store a value in the cache (creates or updates). The expire parameter is the expiration time in seconds. If it's 0, the item never expires (but memcached server doesn't guarantee this item to be stored all the time, it could be deleted from the cache to make place for other items).

Returns true on success or false on failure.

Example:

```
$success = Cache::set('user_123', $userData, 3600);
if ($success) {
  // Data cached for 1 hour
}
```

## Delete

```
Cache::delete(string $key): bool
```

Delete a value from the cache. Returns true on success or false on failure.

Example:

```
$success = Cache::delete('user_123');
if ($success) {
  // Cache entry removed
}
```

## Add

```
Cache::add(string $key, mixed $var, int $expire = 0): bool
```

Add a value to the cache only if it doesn't already exist. Returns true on success, false on failure. Returns false if such key already exists.

Example:

```
$success = Cache::add('user_lock_123', true, 60);
if ($success) {
  // Lock acquired
  processUser(123);
  Cache::delete('user_lock_123');
} else {
  // Another process is working on this user
}
```

## Replace

```
Cache::replace(string $key, mixed $var, int $expire = 0): bool
```

Replace a value in the cache only if it already exists. Returns false if an item with such key doesn't exist. Returns true on success or false on failure.

Example:

```
$success = Cache::replace('user_123', $updatedUser, 3600);
if ($success) {
  // Cache updated
} else {
  // Key didn't exist, use set() instead
  Cache::set('user_123', $updatedUser, 3600);
}
```

## Increment

```
Cache::increment(string $key, int $value = 1): int|false
```

Increment a numeric value in the cache by the specified value. If the item specified by key was not numeric and cannot be converted to a number, it will change its value to the specified value. This method does not create an item if it doesn't already exist.

Returns the new value on success or false on failure.

Example:

```
$views = Cache::increment('page_views_home', 1);
if ($views !== false) {
  echo "Page viewed " . $views . " times";
}
```

## Decrement

```
Cache::decrement(string $key, int $value = 1): int|false
```

Decrement a numeric value in the cache by the specified value. Similarly to increment(), the current value of the item is converted to numerical and after that value is subtracted. This method does not create an item if it didn't exist.

Returns the new value on success or false on failure.

Example:

```
$remaining = Cache::decrement('api_limit_user_123', 1);
if ($remaining !== false && $remaining > 0) {
  // Process API request
} else {
  // Rate limit exceeded
}
```
