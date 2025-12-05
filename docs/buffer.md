---
layout: page
title: Buffer
permalink: /docs/buffer/
---

The "Buffer" class provides functionality for managing named output buffers using PHP's output buffering system. Buffers are tracked in a stack to ensure proper nesting and can be stored, retrieved, and set by name.

## Start

```
Buffer::start(string $name): void
```

Start a named output buffer. Pushes the buffer name onto the stack and begins capturing output. All output generated after this call will be captured until `end()` is called with the same name.

Example:

```
Buffer::start('sidebar');
echo "<div class='sidebar'>";
echo "  <h3>Navigation</h3>";
echo "  <ul>...</ul>";
echo "</div>";
Buffer::end('sidebar');
```

## End

```
Buffer::end(string $name): void
```

End a named output buffer. Stops capturing output for the named buffer and stores the captured content. The buffer name must match the most recently started buffer to maintain proper nesting.

Throws `RuntimeException` if the buffer name doesn't match the top of the stack.

Example:

```
Buffer::start('content');
// ... output content ...
Buffer::end('content');
```

## Set

```
Buffer::set(string $name, string $string): void
```

Set the contents of a named buffer. Directly assigns content to a buffer without using output buffering. This overwrites any existing content for the buffer.

Example:

```
Buffer::set('title', 'Welcome to MintyPHP');
Buffer::set('meta_description', 'A lightweight PHP framework');
```

## Get

```
Buffer::get(string $name): bool
```

Get the contents of a named buffer. Echoes the stored content of the specified buffer if it exists.

Returns true if the buffer exists and was output, false otherwise.

Example:

```
// Output the sidebar buffer in your layout
if (Buffer::get('sidebar')) {
  // Sidebar was rendered
} else {
  // No sidebar content available
}
```

Common usage in templates:

```
<!DOCTYPE html>
<html>
<head>
  <title><?php Buffer::get('title'); ?></title>
</head>
<body>
  <main><?php Buffer::get('html'); ?></main>
  <aside><?php Buffer::get('sidebar'); ?></aside>
</body>
</html>
```
