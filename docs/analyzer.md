---
layout: page
title: Analyzer
permalink: /docs/analyzer/
---

The "Analyzer" class checks PHP files for disallowed output functions to ensure proper separation between logic (actions) and presentation (views), maintaining clean MVC architecture.

## Execute

```
Analyzer::execute(): void
```

Execute the analyzer to check all action and view files in the current request. This is automatically called by the framework when debug mode is enabled.

The analyzer checks:
- Template actions
- Page actions  
- Views
- Template views

For disallowed functions that could break the MVC pattern.

Example:

```
if (Debugger::$enabled) {
    Analyzer::execute();
}
```

## What It Checks

The Analyzer looks for these disallowed functions in your code:

### In Actions (*.php files)

Actions should not directly output content. These functions are not allowed:
- `echo` - Use variables instead
- `print` - Use variables instead
- `exit` - Use `Router::redirect()` instead
- `die` - Use `Router::redirect()` instead
- `var_dump` - Use `d()` function instead
- `eval` - Security risk, avoid entirely

### In Views (*.phtml files)

Views should use the `e()` function for safe output. These are not allowed:
- `echo` - Use `e()` function instead
- `print` - Use `e()` function instead
- `<?= ?>` short tags - Use `<?php e($var); ?>` instead
- `exit`, `die` - Should not be in views
- `var_dump` - Use `d()` function instead
- `eval` - Security risk, avoid entirely

## Why This Matters

The analyzer enforces MintyPHP's clean separation of concerns:

**Actions (*.php)** handle logic:
```php
<?php
// Good: Store data in variables
$users = DB::select('SELECT * FROM users');
$total = count($users);

// Bad: Direct output in action
echo "Total users: " . $total;  // Will trigger warning
```

**Views (*.phtml)** handle presentation:
```php
<?php
// Good: Use e() function for safe output
<h1>Users</h1>
<p>Total: <?php e($total); ?></p>

// Bad: Use of echo
<p>Total: <?php echo $total; ?></p>  // Will trigger warning
```

## Example Warnings

When the analyzer detects violations, it triggers warnings like:

```
Warning: MintyPHP action "pages/users/list().php" should not use "echo". Error raised in...
```

```
Warning: MintyPHP view "pages/users/list(default).phtml" should not use "echo". Error raised in...
```

## Best Practices

### In Actions

✅ **Good:**
```php
<?php
use MintyPHP\DB;
use MintyPHP\Router;

// Fetch data
$users = DB::select('SELECT * FROM users');

// Process data
$activeUsers = array_filter($users, fn($u) => $u['active']);

// Handle redirects properly
if (empty($activeUsers)) {
    Router::redirect('error/not_found');
}
```

❌ **Bad:**
```php
<?php
// Don't output directly
echo "<h1>Users</h1>";
print_r($users);

// Don't use exit/die
if (empty($users)) {
    die('No users found');
}

// Don't use var_dump
var_dump($users);
```

### In Views

✅ **Good:**
```php
<?php
use MintyPHP\Session;

<form method="post">
    <input name="username" />
    <button type="submit">Login</button>
    <?php Session::getCsrfInput(); ?>
</form>

<?php foreach ($users as $user): ?>
    <p><?php e($user['name']); ?></p>
<?php endforeach; ?>
```

❌ **Bad:**
```php
<!-- Don't use short echo tags -->
<p><?= $user['name'] ?></p>

<!-- Don't use echo directly -->
<p><?php echo $user['name']; ?></p>

<!-- Don't use print -->
<?php print $message; ?>
```

## Debugging Output

Instead of `var_dump()` or `print_r()`, use the `d()` function which integrates with the debugger:

```php
<?php
// In actions
$user = DB::selectOne('SELECT * FROM users WHERE id = ?', $userId);
d($user); // Outputs to debugger panel, not page

// Multiple values
d($user, $permissions, $settings);
```

The `d()` function:
- Only works when debugger is enabled
- Logs to the "Logging" panel in the debugger
- Includes file and line number information
- Limits output to prevent memory issues

## Configuration

The Analyzer runs automatically when the debugger is enabled. Enable it in `config/config.php`:

```php
use MintyPHP\Debugger;

Debugger::$enabled = true; // Analyzer runs automatically
```

## When It Runs

The Analyzer is executed automatically:
1. After routing is complete
2. Before actions and views are loaded
3. Only when `Debugger::$enabled` is true

This means violations are caught during development but don't affect production performance.

