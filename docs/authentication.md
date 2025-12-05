---
layout: page
title: Authentication
permalink: /docs/authentication/
---

The "Auth" class provides user authentication, registration, and password management with support for password hashing and two-factor authentication (TOTP).

## Login

```
Auth::login(string $username, string $password, string $totp = ''): array
```

Authenticate a user with username, password, and optional TOTP code. Verifies the username and password, checks TOTP if configured, regenerates the session, and stores user data in the session.

Returns user data on success, empty array on failure.

Example:

```
$user = Auth::login($username, $password);
if ($user) {
  Router::redirect("admin");
} else {
  $error = "Username/password not valid";
}
```

For two-factor authentication:

```
$user = Auth::login($username, $password, $totpCode);
if ($user) {
  Router::redirect("admin");
} else {
  $error = "Invalid credentials or TOTP code";
}
```

## Logout

```
Auth::logout(): bool
```

Log out the current user. Removes user data from the session and regenerates the session ID for security. Always returns true.

Example:

```
Auth::logout();
Router::redirect("login");
```

## Register

```
Auth::register(string $username, string $password): int
```

Register a new user with username and password. Hashes the password using PASSWORD_DEFAULT algorithm and stores the user record with the current timestamp.

Returns the ID of the newly created user.

Example:

```
$userId = Auth::register($username, $password);
if ($userId) {
  Auth::login($username, $password);
  Router::redirect("admin");
} else {
  $error = "User can not be registered";
}
```

## Update

```
Auth::update(string $username, string $password): int
```

Update a user's password. Hashes the new password using PASSWORD_DEFAULT algorithm and updates the user's record.

Returns the number of rows affected (typically 1 on success, 0 if user not found).

Example:

```
$result = Auth::update($username, $newPassword);
if ($result) {
  $message = "Password updated successfully";
} else {
  $error = "User not found";
}
```

## Update TOTP Secret

```
Auth::updateTotpSecret(string $username, string $secret): int
```

Update a user's TOTP secret for two-factor authentication. Sets or updates the TOTP secret (base32-encoded).

Returns the number of rows affected (typically 1 on success, 0 if user not found).

Example:

```
$secret = Totp::generateSecret();
$result = Auth::updateTotpSecret($username, $secret);
if ($result) {
  $message = "TOTP enabled successfully";
}
```

## Exists

```
Auth::exists(string $username): bool
```

Check if a user exists. Queries the database to determine if a user with the given username exists.

Returns true if user exists, false otherwise.

Example:

```
if (Auth::exists($username)) {
  $error = "Username already taken";
} else {
  Auth::register($username, $password);
}
```

# Passwordless

The "NoPassAuth" class provides passwordless user authentication using time-based tokens, with support for remember-me functionality and optional TOTP two-factor authentication.

## Token

```
NoPassAuth::token(string $username): string
```

Generate a token for the given username. Creates a JWT token containing the username and IP address, using the user's password hash as the secret.

Returns the generated token, or empty string if user not found.

Example:

```
$token = NoPassAuth::token($username);
if ($token) {
  mail($username, 'Login Token', Router::getBaseUrl() . 'login/' . $token);
  $message = "Login token sent to your email";
} else {
  $error = "Username not valid";
}
```

## Remember

```
NoPassAuth::remember(): bool
```

Attempt to restore a user session from a remember-me cookie. Checks for a valid remember-me cookie, verifies the token, and restores the user session if valid.

Returns true if session was restored, false otherwise.

Example:

```
// Typically called at application startup
if (NoPassAuth::remember()) {
  // User session restored from cookie
  Router::redirect("dashboard");
}
```

## Login

```
NoPassAuth::login(string $token, bool $rememberMe = false, ?string $totp = null): array
```

Authenticate a user with a token and optional TOTP code. Verifies the JWT token signature and claims, checks TOTP if configured, regenerates the session, and stores user data in the session.

Returns user data on success, empty array on failure.

Example:

```
$user = NoPassAuth::login($token);
if ($user) {
  Router::redirect("admin");
} else {
  $error = "Token not valid";
}
```

With remember-me functionality:

```
$user = NoPassAuth::login($token, true);
if ($user) {
  // User logged in and remember-me cookie set
  Router::redirect("admin");
}
```

With two-factor authentication:

```
$user = NoPassAuth::login($token, false, $totpCode);
if ($user) {
  Router::redirect("admin");
} else {
  $error = "Invalid token or TOTP code";
}
```

## Logout

```
NoPassAuth::logout(): bool
```

Log out the current user. Clears all session variables except debugger data, regenerates the session ID, and removes the remember-me cookie. Always returns true.

Example:

```
NoPassAuth::logout();
Router::redirect("login");
```

## Register

```
NoPassAuth::register(string $username): int
```

Register a new user with the given username. Creates a new user record with a random hashed password.

Returns the ID of the newly created user.

Example:

```
$userId = NoPassAuth::register($username);
if ($userId) {
  $token = NoPassAuth::token($username);
  mail($username, 'Welcome', Router::getBaseUrl() . 'login/' . $token);
  $message = "Registration successful, check your email";
} else {
  $error = "User can not be registered";
}
```

## Update

```
NoPassAuth::update(string $username): int
```

Update the password for an existing user. Generates a new random hashed password for the user.

Returns the number of affected rows.

Example:

```
$result = NoPassAuth::update($username);
if ($result) {
  $token = NoPassAuth::token($username);
  mail($username, 'Password Reset', Router::getBaseUrl() . 'login/' . $token);
  $message = "Password reset, new login token sent";
}
```

## Update TOTP Secret

```
NoPassAuth::updateTotpSecret(string $username, string $secret): int
```

Update the TOTP secret for a user to enable two-factor authentication.

Returns the number of affected rows.

Example:

```
$secret = Totp::generateSecret();
$result = NoPassAuth::updateTotpSecret($username, $secret);
if ($result) {
  $qrCode = Totp::getQrCodeUrl($username, $secret);
  $message = "TOTP enabled, scan QR code: " . $qrCode;
}
```