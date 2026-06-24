# fivem-json-db

**Lightweight Lua JSON database for FiveM — store players, items and state in JSON collections with auto-save, no MySQL required.**

![Lua](https://img.shields.io/badge/Lua-FiveM-blue) ![License: MIT](https://img.shields.io/badge/License-MIT-green)

`fivem-json-db` is a small, dependency-free **Lua database module for FiveM** servers. It keeps your data in JSON-backed collections with optional timed auto-save, so you can persist players, items, quests or any server-side state **without setting up MySQL / oxmysql**. Perfect for prototypes, configs, and small-to-mid servers on ESX, QBCore, Qbox or standalone.

## Features
- 📦 **JSON collections** — clean CRUD (insert, get, update, delete)
- 💾 **Auto-save** — optional timed persistence to disk
- 🔍 **Search** — query a collection by field and value
- 🐛 **Debug logging** — toggleable, readable output
- 🪶 **Zero dependencies** — pure Lua, no database server, MIT licensed

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
Reach for `fivem-json-db` when you want quick, file-based persistence without standing up a database: dev servers, configs, small player bases, side resources, or anywhere a full MySQL setup is overkill. For large, high-write production servers, a proper SQL backend (e.g. oxmysql) is still the right call.

## Built by oxince
`fivem-json-db` is built and maintained by **[oxince](https://oxince.com)**, a FiveM developer in Frankfurt who builds custom scripts, dashboards and server optimization for FiveM.

Need a custom script, a dashboard, or your server optimized? **→ [oxince.com](https://oxince.com)**

## License
MIT © [oxince](https://oxince.com)
