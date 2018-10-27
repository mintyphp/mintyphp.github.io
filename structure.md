# Structure

This is the directory structure of a project:

```
.
├── config     Configuration of the framework
├── lib        PHP classes for extensions
├── pages      PHP for dynamic pages
├── templates  Layouts for dynamic pages
├── vendor     External dependencies/libraries
└── web        Javascript, CSS, fonts and images
```

The classes in the "lib" directory should have the "MintyPHP" namespace.
Public static properties of these classes can be configured from the "MintyPHP\Config" namespace in the "config/config.php" file.