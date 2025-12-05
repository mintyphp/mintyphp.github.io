---
layout: page
title: Curl
permalink: /docs/curl/
---

The "Curl" class provides methods for making HTTP requests with support for caching, redirects, cookies, and various HTTP methods.

## Call

```
Curl::call(string $method, string $url, $data = '', array $headers = [], array $options = []): array
```

Make an HTTP request. The `$data` parameter can be either an array (for form data) or a string (for raw POST). 

Returns an array with `status`, `headers`, `data`, and `url`.

Example:

```
$result = Curl::call('GET', 'http://www.bing.com/search', ['q' => $query]);
echo "Status: " . $result['status'];
echo "Body: " . $result['data'];
print_r($result['headers']);
```

POST request example:

```
$result = Curl::call('POST', 'https://api.example.com/users', [
  'name' => 'John Doe',
  'email' => 'john@example.com'
], [
  'Authorization' => 'Bearer token123'
]);
```

## Navigate

```
Curl::navigate(string $method, string $url, $data = '', array $headers = [], array $options = []): array
```

Make an HTTP request with automatic redirects. Follows redirects and returns the final URL in the response.

Returns an array with `status`, `headers`, `data`, and `url`.

Example:

```
$result = Curl::navigate('GET', 'http://www.bing.com/search', ['q' => $query]);
echo "Final URL: " . $result['url'];
echo "Content: " . $result['data'];
```

## Call Cached

```
Curl::callCached(int $expire, string $method, string $url, mixed $data, array $headers = [], array $options = []): array
```

Make a cached HTTP request. The response is cached for the specified number of seconds.

Example:

```
// Cache for 1 hour
$result = Curl::callCached(3600, 'GET', 'https://api.example.com/data', ['id' => 123]);
```

## Navigate Cached

```
Curl::navigateCached(int $expire, string $method, string $url, mixed $data, array $headers = [], array $options = []): array
```

Make a cached HTTP request with automatic redirects. The response is cached for the specified number of seconds.

Example:

```
// Cache for 30 minutes
$result = Curl::navigateCached(1800, 'GET', 'https://example.com/redirect', []);
echo "Final URL: " . $result['url'];
```