Database = {};
Database.__index = Database;

function Database.new(resourceName, path, beautify, timedSave, saveInterval, debug)
  local self = setmetatable({}, Database);
  self.resourceName = resourceName;
  self.timedSave = timedSave;
  self.saveInterval = saveInterval or 60000;
  self.debug = debug;
  self.collections = {};
  self.path = path;
  self.beautify = beautify;
  self.log = function(message)
    if self.debug then
      print(("[DATABASE] [%s] %s"):format(self.resourceName, message));
    end
  end
  self.log(("Database path: %s"):format(path));
  return self;
end

function Database.save(self, collection)
  function saveCollection(collection)
    local collectionFile = ("%s/%s.json"):format(self.path, collection);
    local collectionData = json.encode(self.collections[collection], self.beautify and { indent = true, level = 2 } or nil);
    SaveResourceFile(self.resourceName, collectionFile, collectionData, -1);
    self.log(("Saved collection %s"):format(collection));
  end

  if collection then
    saveCollection(collection);
  else
    for collection, _ in pairs(self.collections) do
      saveCollection(collection);
    end
  end

  return self;
end

function Database.init(self, collections)
  for idx, collection in ipairs(collections) do
    local collectionFile = ("%s/%s.json"):format(self.path, collection);
    local collectionData = LoadResourceFile(self.resourceName, collectionFile);
    if collectionData then
      self.collections[collection] = json.decode(collectionData);
      self.log(("Loaded collection %s"):format(collection));
    else
      self.collections[collection] = {};
      self.log(("Created collection %s"):format(collection));
    end
  end

  if self.timedSave then
    self.log(("Saving database every %s seconds"):format(self.saveInterval / 1000));
    self.saveTimer = function()
      self:save();
      SetTimeout(self.saveInterval, self.saveTimer);
    end
    self.saveTimer();
  end

  self.log("Database initialized");

  return self;
end

function Database.update(self, collection, key, value)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  self.collections[collection][key] = value;
  self.log(("Updated %s in %s"):format(key, collection));

  if not self.timedSave then
    self:save(collection);
  end
end

function Database.delete(self, collection, key)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  self.collections[collection][key] = nil;
  self.log(("Deleted %s from %s"):format(key, collection));

  if not self.timedSave then
    self:save(collection);
  end
end

function Database.get(self, collection, key)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  return self.collections[collection][key];
end

function Database.getAll(self, collection)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  return self.collections[collection];
end

function Database.insert(self, collection, key, value)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  if self.collections[collection][key] then
    self.log(("Key %s already exists in %s"):format(key, collection));
    return false;
  end

  self.collections[collection][key] = value;
  self.log(("Inserted %s into %s"):format(key, collection));

  if not self.timedSave then
    self:save(collection);
  end
end

function Database.insertAll(self, collection, data)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end

  for key, value in pairs(data) do
    if self.collections[collection][key] then
      self.log(("Key %s already exists in %s"):format(key, collection));
      return false;
    end

    self.collections[collection][key] = value;
  end

  self.log(("Inserted %s keys into %s"):format(#data, collection));

  if not self.timedSave then
    self:save(collection);
  end
end

function Database.search(self, collection, key, value)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end
  
  for k, v in pairs(self.collections[collection]) do
    if v[key] == value then
      return v;
    end
  end
end

function Database.searchAll(self, collection, key, value)
  if not self.collections[collection] then
    self.log(("Collection %s does not exist"):format(collection));
    return false;
  end
  
  local results = {};
  for k, v in pairs(self.collections[collection]) do
    if v[key] == value then
      table.insert(results, v);
    end
  end
  
  return results;
end