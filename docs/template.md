---
layout: page
title: Template
permalink: /docs/template/
---

The "Template" class provides a simple template rendering engine with variable substitution and custom functions. While MintyPHP primarily uses PHP as its templating language, the Template class can be used for rendering email templates, text snippets, or simple string-based templates.

## Render

```
Template::render(string $template, array $data, array $functions = []): string
```

Render a template string with data substitution and optional custom functions.

Parameters:
- `$template` - Template string with `{{variable}}` placeholders
- `$data` - Associative array of variables to substitute
- `$functions` - Optional array of custom functions for processing variables

Returns the rendered string with all variables substituted.

Example:

```
$template = "Hello {{name}}, you have {{count}} new messages.";
$data = ['name' => 'John', 'count' => 5];
$result = Template::render($template, $data);
// Result: "Hello John, you have 5 new messages."
```

## Variable Substitution

Variables are marked with double curly braces `{{variable}}`:

```
$template = "Welcome {{username}}! Your email is {{email}}.";
$data = [
    'username' => 'Alice',
    'email' => 'alice@example.com'
];
$output = Template::render($template, $data);
// Output: "Welcome Alice! Your email is alice@example.com."
```

## HTML Escaping

By default, variables are HTML-escaped for security (preventing XSS attacks):

```
$template = "Comment: {{comment}}";
$data = ['comment' => '<script>alert("XSS")</script>'];
$output = Template::render($template, $data);
// Output: "Comment: &lt;script&gt;alert(&quot;XSS&quot;)&lt;/script&gt;"
```

## Custom Functions

You can apply custom functions to variables using the pipe `|` syntax:

```
$template = "Hello {{name|capitalize}}!";
$data = ['name' => 'john'];
$functions = ['capitalize' => 'ucfirst'];
$output = Template::render($template, $data, $functions);
// Output: "Hello John!"
```

### Multiple Functions

Chain multiple functions together:

```
$template = "{{text|strtoupper|substr:0:10}}";
$data = ['text' => 'hello world from template'];
$functions = [
    'strtoupper' => 'strtoupper',
    'substr' => function($str, $start, $length) {
        return substr($str, $start, $length);
    }
];
$output = Template::render($template, $data, $functions);
// Output: "HELLO WORL"
```

### Custom Function Syntax

Functions can accept arguments separated by colons:

```
{{variable|function:arg1:arg2}}
```

Example with padding:

```
$template = "Order #{{id|str_pad:8:0:STR_PAD_LEFT}}";
$data = ['id' => 42];
$functions = [
    'str_pad' => function($str, $length, $pad, $type) {
        return str_pad($str, $length, $pad, constant($type));
    }
];
$output = Template::render($template, $data, $functions);
// Output: "Order #00000042"
```

## Email Templates

A common use case is rendering email templates:

```
$emailTemplate = <<<'EOT'
Dear {{name}},

Your account has been activated!

Username: {{username}}
Activation date: {{date}}

Thank you for joining {{siteName}}.

Best regards,
The {{siteName}} Team
EOT;

$data = [
    'name' => 'John Doe',
    'username' => 'johndoe',
    'date' => date('Y-m-d H:i:s'),
    'siteName' => 'MyWebsite'
];

$emailBody = Template::render($emailTemplate, $data);
mail($email, 'Account Activated', $emailBody);
```

## Common Use Cases

### Password Reset Email

```
$template = <<<'EOT'
Hi {{username}},

You requested a password reset. Click the link below:

{{resetLink}}

This link expires in {{expiryHours}} hours.

If you didn't request this, please ignore this email.
EOT;

$data = [
    'username' => $user['username'],
    'resetLink' => Router::getBaseUrl() . 'reset/' . $token,
    'expiryHours' => 24
];

$body = Template::render($template, $data);
mail($user['email'], 'Password Reset', $body);
```

### Notification Messages

```
$template = "{{user|capitalize}} {{action}} {{count}} {{item|pluralize:count}}.";
$data = [
    'user' => 'admin',
    'action' => 'deleted',
    'count' => 3,
    'item' => 'file'
];
$functions = [
    'capitalize' => 'ucfirst',
    'pluralize' => function($word, $count) {
        return $count == 1 ? $word : $word . 's';
    }
];
$message = Template::render($template, $data, $functions);
// Output: "Admin deleted 3 files."
```

## Error Handling

If a custom function is not found, an error message is included in the output:

```
$template = "Hello {{name|missing}}";
$data = ['name' => 'John'];
$output = Template::render($template, $data, []);
// Output: "Hello {{name|missing!!function `missing` not found}}"
```

If a variable is missing, it's left as-is:

```
$template = "Hello {{name}}, your score is {{score}}";
$data = ['name' => 'John'];
$output = Template::render($template, $data);
// Output: "Hello John, your score is {{score}}"
```

## Best Practices

1. **Use for Simple Templates**: The Template class is best for simple text substitution, especially emails and text files.

2. **Use PHP Templates for HTML**: For HTML views, MintyPHP's standard PHP templating (*.phtml files) is more powerful and flexible.

3. **Always Escape User Input**: Variables are auto-escaped, but be careful with custom functions that bypass escaping.

4. **Keep Functions Pure**: Custom functions should be stateless and not have side effects.

## Configuration

The Template class is configured for HTML output by default. You can customize the output type:

```
use MintyPHP\Template;

// For HTML output (default)
$htmlTemplate = Template::getInstance(); // Uses 'html' output type

// The output type affects how variables are escaped
```

## When Not to Use

Don't use the Template class for:

- **Complex HTML views**: Use PHP templates (*.phtml files) instead
- **Logic-heavy templates**: MintyPHP actions and views are better
- **Performance-critical rendering**: PHP templates are faster
- **Templates with conditionals/loops**: PHP syntax is more natural

The Template class is a lightweight tool for simple string substitution, not a full-featured template engine.
