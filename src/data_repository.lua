local dataRepository = {
}

local sqlite3 = require("lsqlcipher")
local db = sqlite3.open("./arca.sqlite")

local function init(object)
    db:key(object.password)
    db:exec [[
        CREATE TABLE IF NOT EXISTS data (
            key TEXT PRIMARY KEY,
            data TEXT NOT NULL
        );
    ]]
end

function dataRepository:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    init(object)
    return object
end

function dataRepository:insert(key, data)
    local stmt = assert(db:prepare("INSERT INTO data VALUES (:key, :data)"))
    stmt:bind_names { key = key, data = data }
    stmt:step()
    stmt:reset()
end

function dataRepository:find(key)
    local stmt = assert(db:prepare("SELECT data FROM data WHERE key = :key"))
    stmt:bind_names { key = key }
    stmt:step()
    local value = stmt:get_value(0)
    stmt:reset()
    return value
end

function dataRepository:findAll()
    local stmt = assert(db:prepare("SELECT key FROM data"))
    local list = {}
    for row in stmt:nrows() do
        table.insert(list, row.key)
    end
    return list
end

return dataRepository
