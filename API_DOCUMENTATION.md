## API Documentation

The Lua Database Module provides several functions to interact with data collections. Below is a list of available functions along with their descriptions:

### `Database.new(resourceName, path, beautify, timedSave, saveInterval, debug)`

Create a new Database instance.

- `resourceName` (string): Name of the FiveM resource.
- `path` (string): Path to the directory where collection JSON files will be stored.
- `beautify` (boolean): Whether to beautify JSON output.
- `timedSave` (boolean): Enable timed auto-save.
- `saveInterval` (number): Time interval for auto-save in milliseconds.
- `debug` (boolean): Enable debugging log output.

### `Database:init(collections)`

Initialize the database with a list of collections.

- `collections` (table): List of collection names.

### `Database:insert(collection, key, value)`

Insert a value into a collection.

- `collection` (string): Collection name.
- `key` (string): Key for the data.
- `value` (table): Data to be inserted.

### `Database:update(collection, key, value)`

Update a value in a collection.

- `collection` (string): Collection name.
- `key` (string): Key of the data to be updated.
- `value` (table): Updated data.

### `Database:delete(collection, key)`

Delete a value from a collection.

- `collection` (string): Collection name.
- `key` (string): Key of the data to be deleted.

### `Database:get(collection, key)`

Get a value from a collection by key.

- `collection` (string): Collection name.
- `key` (string): Key of the data to retrieve.

### `Database:search(collection, key, value)`

Search for a value in a collection based on a specific key-value pair.

- `collection` (string): Collection name.
- `key` (string): Key to search for.
- `value`: Value to match.

### `Database:searchAll(collection, key, value)`

Search for all values in a collection based on a specific key-value pair.

- `collection` (string): Collection name.
- `key` (string): Key to search for.
- `value`: Value to match.

### `Database:save(collection)`

Save collection(s) data to JSON files.

- `collection` (string, optional): Specific collection to save. If not provided, all collections will be saved.

### Other Functions

Additional functions are available for handling collections and initializing the database.

For more detailed information about the function parameters and usage examples, please refer to the code comments or the actual source code.

## Examples

Examples of how to use these functions can be found in the [Usage](#usage) section above.

