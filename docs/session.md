---
layout: page
title: Session
permalink: /docs/session/
---

The "Session" class handles PHP sessions with security features, providing session initialization, CSRF token management, and secure session configuration with support for debugging mode.

## Get CSRF Input

```
Session::getCsrfInput(): void
```

Output a hidden input field with the CSRF token. This should be added to all POST forms to prevent Cross-Site Request Forgery (CSRF) attacks.

Example:

```
<form method="post" action="/login">
  <?php Session::getCsrfInput(); ?>
  <input type="text" name="username" />
  <input type="password" name="password" />
  <button type="submit">Login</button>
</form>
```

## Check CSRF Token

```
Session::checkCsrfToken(): bool
```

Check the CSRF token from the POST data against the session. Returns true if the token is valid, false otherwise.

Example:

```
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  if (!Session::checkCsrfToken()) {
    die('Invalid CSRF token');
  }
  // Process form data
}
```

## Start

```
Session::start(): void
```

Start the session. This is typically called automatically by the framework.

Example:

```
Session::start();
$_SESSION['user_id'] = 123;
```

## End

```
Session::end(): void
```

End the session and destroy all session data.

Example:

```
Session::end();
Router::redirect('login');
```

## Regenerate

```
Session::regenerate(): void
```

Regenerate the session ID and CSRF token. This should be called after login or privilege escalation to prevent session fixation attacks.

Example:

```
if (Auth::login($username, $password)) {
  Session::regenerate();
  Router::redirect('dashboard');
}
```