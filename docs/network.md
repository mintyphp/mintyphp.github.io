---
layout: page
title: Network
permalink: /docs/network/
---

The "Network" class provides network-related utility functions for working with IP addresses, including checking local IPs and matching IP addresses against CIDR ranges for both IPv4 and IPv6.

## isLocalIP

```
Network::isLocalIP(string $ipAddress): bool
```

Check if the given IP address is assigned to a local network interface on the server.

This method executes the `ip a` command to retrieve all network interfaces and their assigned IP addresses, then checks if the provided IP address matches any of them.

Parameters:
- `$ipAddress` - The IP address to check (can be IPv4 or IPv6)

Returns:
- `true` if the IP address is assigned to a local interface
- `false` otherwise

Example:

```
if (Network::isLocalIP('127.0.0.1')) {
    echo "This is a local IP address";
}

if (Network::isLocalIP('::1')) {
    echo "This is a local IPv6 loopback address";
}
```

This is useful for determining if a request is coming from the local machine or for security checks.

## ipv4Match

```
Network::ipv4Match(string $ip4, string $range): bool
```

Check if an IPv4 address is within a given CIDR range.

This method validates both the IP address and the range, then performs bitwise comparison to determine if the IP falls within the specified subnet.

Parameters:
- `$ip4` - The IPv4 address to check
- `$range` - The CIDR range (e.g., "192.168.1.0/24" or "10.0.0.1" for single IP)

Returns:
- `true` if the IP address is within the range
- `false` if the IP is outside the range or if inputs are invalid

Example:

```
// Check if IP is in a specific subnet
if (Network::ipv4Match('192.168.1.50', '192.168.1.0/24')) {
    echo "IP is in the 192.168.1.0/24 subnet";
}

// Check against a single IP (implicitly /32)
if (Network::ipv4Match('10.0.0.1', '10.0.0.1')) {
    echo "IP matches exactly";
}

// Check if IP is in a larger range
if (Network::ipv4Match('172.16.50.10', '172.16.0.0/12')) {
    echo "IP is in the 172.16.0.0/12 range";
}
```

Common use cases:
- Restricting access to specific IP ranges
- Implementing IP-based whitelists or blacklists
- Network security filtering
- Geographic or organizational IP range checks

## ipv6Match

```
Network::ipv6Match(string $ip6, string $range): bool
```

Check if an IPv6 address is within a given CIDR range.

This method validates both the IPv6 address and the range, converts them to binary representation, and compares the prefix bits to determine if the IP falls within the specified subnet.

Parameters:
- `$ip6` - The IPv6 address to check
- `$range` - The CIDR range (e.g., "2001:db8::/32" or "::1" for single IP)

Returns:
- `true` if the IP address is within the range
- `false` if the IP is outside the range or if inputs are invalid

Example:

```
// Check if IPv6 is in a specific subnet
if (Network::ipv6Match('2001:db8::1', '2001:db8::/32')) {
    echo "IP is in the 2001:db8::/32 subnet";
}

// Check against IPv6 loopback
if (Network::ipv6Match('::1', '::1')) {
    echo "This is the IPv6 loopback address";
}

// Check if IP is in a larger range
if (Network::ipv6Match('2001:0db8:85a3::8a2e:0370:7334', '2001:db8::/32')) {
    echo "IP is in the documentation range";
}
```

The method handles IPv6 address normalization internally, so various representations of the same address will be matched correctly.

## Practical Examples

### IP Whitelisting

```
$allowedRanges = [
    '192.168.1.0/24',    // Local network
    '10.0.0.0/8',        // Private network
    '2001:db8::/32',     // IPv6 range
];

$clientIP = $_SERVER['REMOTE_ADDR'];

$isAllowed = false;
foreach ($allowedRanges as $range) {
    if (filter_var($clientIP, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
        if (Network::ipv4Match($clientIP, $range)) {
            $isAllowed = true;
            break;
        }
    } elseif (filter_var($clientIP, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6)) {
        if (Network::ipv6Match($clientIP, $range)) {
            $isAllowed = true;
            break;
        }
    }
}

if (!$isAllowed) {
    http_response_code(403);
    die('Access denied');
}
```

### Local Request Detection

```
$clientIP = $_SERVER['REMOTE_ADDR'];

if (Network::isLocalIP($clientIP)) {
    // Enable debug mode for local requests
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    // Hide errors for external requests
    ini_set('display_errors', '0');
}
```

### Network-Based Feature Flags

```
function isInternalNetwork(string $ip): bool {
    $internalRanges = [
        '10.0.0.0/8',
        '172.16.0.0/12',
        '192.168.0.0/16',
    ];
    
    foreach ($internalRanges as $range) {
        if (Network::ipv4Match($ip, $range)) {
            return true;
        }
    }
    return false;
}

$clientIP = $_SERVER['REMOTE_ADDR'];
if (isInternalNetwork($clientIP)) {
    // Show admin features for internal users
    $showAdminPanel = true;
}
```
