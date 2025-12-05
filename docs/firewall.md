---
layout: page
title: Firewall
permalink: /docs/firewall/
---

The "Firewall" class provides rate limiting and request concurrency control to protect your application from abuse by limiting the number of concurrent requests from the same IP address.

## Start

```
Firewall::start(): void
```

Start the firewall to protect against concurrent request floods. This uses a spin-lock mechanism with Memcached to ensure requests wait rather than fail immediately.

The firewall counts concurrent requests per IP address and enforces a configurable limit. When the limit is reached, additional requests are delayed using a spin-lock.

Example:

```
Firewall::start();
// Application continues only after acquiring a slot
```

This is typically called at the beginning of your application, right before starting the session:

```
// Start the firewall
Firewall::start();

// Start the session
Session::start();
```

## Configuration

The Firewall can be configured by setting static properties in `config/config.php`:

```
Firewall::$concurrency = 10;           // Max concurrent requests per IP
Firewall::$spinLockSeconds = 0.15;     // Time to wait between retry attempts
Firewall::$intervalSeconds = 300;      // Time window for rate limiting
Firewall::$cachePrefix = 'fw_concurrency_'; // Cache key prefix
Firewall::$reverseProxy = false;       // Set true if behind reverse proxy
```

### Concurrency

The maximum number of concurrent requests allowed from a single IP address. Default is 10.

```
Firewall::$concurrency = 5; // Only allow 5 concurrent requests
```

### Spin Lock Seconds

The time in seconds to wait between retry attempts when the concurrency limit is reached. Default is 0.15 seconds (150ms).

```
Firewall::$spinLockSeconds = 0.2; // Wait 200ms between retries
```

### Interval Seconds

The time window in seconds for tracking concurrent requests. Default is 300 seconds (5 minutes).

```
Firewall::$intervalSeconds = 600; // Track over 10 minute window
```

### Cache Prefix

The prefix used for cache keys to avoid collisions. Default is 'fw_concurrency_'.

```
Firewall::$cachePrefix = 'my_firewall_';
```

### Reverse Proxy

Set to true if your application is behind a reverse proxy (like nginx or Apache) to correctly identify client IP addresses. Default is false.

```
Firewall::$reverseProxy = true; // Trust X-Forwarded-For header
```

## How It Works

1. When a request arrives, the firewall checks how many concurrent requests are currently being processed from that IP
2. If below the limit, the request proceeds and a counter is incremented
3. If at the limit, the firewall enters a spin-lock, waiting briefly and checking again
4. Once the request completes, the counter is decremented
5. IP addresses are identified using `REMOTE_ADDR` or `HTTP_X_FORWARDED_FOR` (if `$reverseProxy` is enabled)

This prevents denial-of-service attacks where many requests flood the server simultaneously, while still allowing legitimate concurrent requests within reasonable limits.
