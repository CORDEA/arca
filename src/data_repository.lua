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

return dataRepository
