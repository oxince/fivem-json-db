# Lua Database Module for FiveM

A flexible Lua database module designed for use in the FiveM platform. This module provides functionalities to manage collections of data in a database-like manner, including saving, loading, updating, deleting, searching, and more.

## Features

- Create, manage, and manipulate data collections.
- Efficiently save and load collection data using JSON encoding/decoding.
- Optional timed auto-save functionality.
- Debugging support with customizable logging.

## Documentation

For detailed usage instructions and function documentation, refer to the [API documentation](API_DOCUMENTATION.md).

## Usage

1. **Installation**: Add the `database.lua` file and include it in your FiveM resource by adding `server_script "@fivem-json-db/server/database.lua"` to your resource manifest.
   
2. **Usage Example**:

```lua
local db = Database.new("resource_name", "path/to/database", true, true, 60000, true)

-- Initialize with collections
db:init({"players", "items", "quests"})

-- Insert data into a collection
db:insert("players", "player123", { name = "John", level = 10 })

-- Update data in a collection
db:update("players", "player123", { level = 11 })

-- Get data from a collection
local playerData = db:get("players", "player123")

-- Search for data in a collection
local playersWithLevel10 = db:searchAll("players", "level", 10)

-- ... and more (see documentation for all available functions)
```

## Contributions

Contributions are welcome! If you find any issues or have improvements to suggest, feel free to submit a pull request or open an issue.

## License

This project is licensed under the [MIT License](LICENSE).

---

*Disclaimer: This module is intended for educational purposes and might need further customization to meet production-level requirements.*
