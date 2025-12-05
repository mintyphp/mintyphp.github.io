---
layout: page
title: Router
permalink: /docs/router/
---

The "Router" class handles URL routing in MintyPHP, mapping incoming requests to views, actions, and templates based on defined routes and file structure. Supports redirection, JSON responses, and file downloads.

## Redirect

```
Router::redirect(string $url, bool $permanent = false): void
```

Redirect to a URL. Set `$permanent` to true for a 301 redirect.

Example:

```
if (!Auth::login($username, $password)) {
  Router::redirect('login');
}
```

## JSON

```
Router::json(mixed $object): void
```

Output a JSON response and terminate execution.

Example:

```
$data = ['status' => 'success', 'users' => $users];
Router::json($data);
```

## Download

```
Router::download(string $filename, string $data): void
```

Initiate file download with provided data and terminate execution.

Example:

```
$csv = "Name,Email\nJohn,john@example.com";
Router::download('users.csv', $csv);
```

## File

```
Router::file(string $filename, string $filepath): void
```

Initiate file download from filesystem and terminate execution.

Example:

```
Router::file('report.pdf', '/tmp/reports/report_2025.pdf');
```

## Get URL

```
Router::getUrl(): string
```

Get the matched URL path (view or action name with directory). This does not contain parameters or trailing slashes.

Example:

```
$url = Router::getUrl(); // 'docs/router'
```

## Get Canonical

```
Router::getCanonical(): string
```

Get the canonical URL with parameters appended. Removes trailing 'index' from the URL if present.

Example:

```
$canonical = Router::getCanonical();
```

## Get Request

```
Router::getRequest(): string
```

Get the current request URI. Normally this is the same as `$_SERVER['REQUEST_URI']`.

Example:

```
$request = Router::getRequest(); // '/docs/router'
```

## Get Base URL

```
Router::getBaseUrl(): string
```

Get the base URL with protocol and host. When not loaded in a subdirectory this returns the site root URL.

Example:

```
$base = Router::getBaseUrl(); // 'https://example.com/'
```

## Get View

```
Router::getView(): string
```

Get the matched view file path, or empty string if none.

Example:

```
$view = Router::getView(); // 'pages/docs/router.phtml'
```

## Get Action

```
Router::getAction(): string
```

Get the matched action file path, or empty string if none.

Example:

```
$action = Router::getAction(); // 'pages/docs/router.php'
```

## Get Template View

```
Router::getTemplateView(): string
```

Get the template view file path if it exists, or empty string if none.

Example:

```
$template = Router::getTemplateView(); // 'templates/docs.phtml'
```

## Get Template Action

```
Router::getTemplateAction(): string
```

Get the template action file path if it exists, or empty string if none.

Example:

```
$templateAction = Router::getTemplateAction(); // 'templates/docs.php'
```

## Get Parameters

```
Router::getParameters(): array
```

Get parameters extracted from the URL.

Example:

```
$params = Router::getParameters();
echo $params['id']; // '123'
```

## Get Redirect

```
Router::getRedirect(): ?string
```

Get the redirect URL if one was set during routing, or null if no redirect.

Example:

```
$redirect = Router::getRedirect();
```
