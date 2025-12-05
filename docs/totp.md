---
layout: page
title: Totp
permalink: /docs/totp/
---

The "Totp" class provides Time-based One-Time Password (TOTP) functionality for two-factor authentication (2FA) according to RFC 6238. It generates and verifies OTP codes that change every 30 seconds.

## Generate Secret

```
Totp::generateSecret(): string
```

Generate a random base32-encoded secret key for TOTP authentication. This secret should be stored securely for each user enabling 2FA.

Returns a base32-encoded string (default 16 characters).

Example:

```
$secret = Totp::generateSecret();
// Store this secret for the user
Auth::updateTotpSecret($username, $secret);
```

## Generate URI

```
Totp::generateURI(string $company, string $username, string $secret): string
```

Generate a TOTP URI that can be used to create a QR code for authenticator apps like Google Authenticator, Authy, or Microsoft Authenticator.

Parameters:
- `$company` - Company/application name shown in the authenticator app
- `$username` - User identifier (typically email or username)
- `$secret` - The base32-encoded secret key

Returns an `otpauth://` URI string.

Example:

```
$secret = Totp::generateSecret();
$uri = Totp::generateURI('MyCompany', 'user@example.com', $secret);
// $uri = 'otpauth://totp/MyCompany:user@example.com?issuer=MyCompany&secret=JDDK4U6G3BJLEZ7Y'

// Generate QR code from URI (using a QR code library)
$qrCodeUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" . urlencode($uri);
```

Display the QR code to the user so they can scan it with their authenticator app:

```
<img src="<?php e($qrCodeUrl); ?>" alt="Scan with authenticator app">
<p>Secret: <?php e($secret); ?></p>
```

## Verify

```
Totp::verify(string $secret, string $otp): bool
```

Verify a TOTP code against a secret. Returns true if the OTP is valid for the current time period.

Parameters:
- `$secret` - The base32-encoded secret key (empty string returns true)
- `$otp` - The 6-digit OTP code to verify

Returns true if the code is valid, false otherwise.

Example:

```
$user = DB::selectOne('SELECT * FROM users WHERE username = ?', $username);
$secret = $user['totp_secret'];
$otp = $_POST['totp_code'];

if (Totp::verify($secret, $otp)) {
  // TOTP code is valid
  Auth::login($username, $password, $otp);
} else {
  // TOTP code is invalid
  $error = "Invalid two-factor authentication code";
}
```

## Configuration

The Totp class can be configured by setting static properties in `config/config.php`:

```
Totp::$period = 30;           // Time period in seconds (default: 30)
Totp::$algorithm = 'sha1';    // Hash algorithm: sha1, sha256, sha512
Totp::$digits = 6;            // Number of digits in OTP code
Totp::$secretLength = 10;     // Length of generated secret (bytes)
```

### Period

The time period in seconds for TOTP generation. Standard is 30 seconds.

```
Totp::$period = 60; // Generate codes valid for 60 seconds
```

### Algorithm

The hash algorithm used for TOTP generation. Supported values: 'sha1', 'sha256', 'sha512'. Default is 'sha1'.

```
Totp::$algorithm = 'sha256'; // Use SHA-256 instead of SHA-1
```

### Digits

The number of digits in the generated OTP code. Standard is 6 digits.

```
Totp::$digits = 8; // Generate 8-digit codes instead of 6
```

### Secret Length

The length in bytes of generated secrets. Default is 10 bytes (16 characters in base32).

```
Totp::$secretLength = 20; // Generate longer secrets
```

## Complete 2FA Setup Example

Here's a complete example of setting up two-factor authentication:

```
// 1. Generate secret when user enables 2FA
$secret = Totp::generateSecret();
Auth::updateTotpSecret($username, $secret);

// 2. Show QR code to user
$uri = Totp::generateURI('MyApp', $username, $secret);
$qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" . urlencode($uri);
?>
<h2>Enable Two-Factor Authentication</h2>
<p>Scan this QR code with your authenticator app:</p>
<img src="<?php e($qrUrl); ?>" alt="QR Code">
<p>Or enter this code manually: <code><?php e($secret); ?></code></p>

<?php
// 3. Verify setup with a test code
if (isset($_POST['verify_code'])) {
  if (Totp::verify($secret, $_POST['verify_code'])) {
    echo "Two-factor authentication successfully enabled!";
  } else {
    echo "Invalid code. Please try again.";
  }
}
?>

<form method="post">
  <input type="text" name="verify_code" placeholder="Enter 6-digit code">
  <button type="submit">Verify</button>
</form>

<?php
// 4. During login, verify TOTP code
$user = Auth::login($username, $password, $_POST['totp_code']);
if ($user) {
  // Login successful with valid TOTP
} else {
  // Login failed - wrong password or TOTP code
}
```

## Security Notes

- Store TOTP secrets securely in your database
- Never expose secrets to users after initial setup
- TOTP codes are valid for 30 seconds by default (±1 period for clock skew)
- Empty secrets (`''`) will always verify as true, so check for non-empty secrets
- Use HTTPS to protect codes in transit
- Implement backup codes in case users lose access to their authenticator device
