# fivem-json-db

**Lua JSON database for FiveM. Save and persist player and server data without MySQL, with a simple Lua API.**

![Lua](https://img.shields.io/badge/Lua-FiveM-blue) ![License: MIT](https://img.shields.io/badge/License-MIT-green)

`fivem-json-db` is a small, dependency-free Lua database module for FiveM. It stores your data in JSON-backed collections with optional timed auto-save, so you can persist players, items, quests or any server-side state without setting up MySQL or oxmysql. There is no SQL server to run and no tables to migrate, just JSON storage you can read on disk. It fits prototypes, config-style data, and small to mid-size servers on ESX, QBCore, Qbox or standalone.

If you have been looking for a way to save FiveM player data without a database, this is the no-SQL route: everything lives in flat JSON files you can open and read.

## Features
- JSON collections with plain CRUD (insert, get, update, delete)
- Optional timed auto-save that persists each collection to disk
- Search across a whole collection by field and value
- Toggleable debug logging with readable output
- Zero dependencies. Pure Lua, no database server, MIT licensed

## Installation
1. Download this resource into your server's `resources/` folder as `fivem-json-db`.
2. From any resource that needs storage, load the module in your server script context:

```lua
server_script "@fivem-json-db/server/database.lua"
```

## Quick start
```lua
-- Database.new(resourceName, path, autoSave, prettyPrint, autoSaveIntervalMs, debug)
local db = Database.new("my_resource", "data/database", true, true, 60000, true)

-- declare your collections
db:init({ "players", "items", "quests" })

-- create / update
db:insert("players", "player123", { name = "John", level = 10 })
db:update("players", "player123", { level = 11 })

-- read
local player = db:get("players", "player123")

-- search a whole collection by field/value
local level10Players = db:searchAll("players", "level", 10)
```

Full method reference: [`API_DOCUMENTATION.md`](API_DOCUMENTATION.md) · runnable examples: [`example/`](example/).

## When to use it
Reach for `fivem-json-db` when you want quick, file-based persistence without standing up a database: dev servers, config data, small player bases, side resources, or anywhere a full MySQL setup is overkill. For large, high-write production servers, a real SQL backend such as oxmysql is still the better call.

## How it compares to oxmysql / MySQL
- No SQL server, no schema, no migrations. The data lives in JSON files you can open and read.
- Writes go to disk on a timer, so it suits low-to-moderate write volume rather than thousands of writes per second.
- You keep the simple exports-style API instead of writing queries.

If your server already runs oxmysql at scale, stay on it. If you just want persistent data in JSON and never wanted MySQL in the first place, this covers that case.

## Built by oxince
`fivem-json-db` is built and maintained by [oxince](https://oxince.com), a FiveM developer in Frankfurt who builds custom scripts, web dashboards and server optimization for FiveM and works with clients worldwide.

Need a custom script, a dashboard, or your server optimized? [oxince.com](https://oxince.com)

## License
MIT © [oxince](https://oxince.com)
