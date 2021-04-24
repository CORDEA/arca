DataRepository = require("data_repository")

local function main()
    local command = assert(arg[1])
    local key = arg[2]
    local password = assert(os.getenv("ARCA_PASSWORD"))
    local repository = DataRepository:new({ password = password })
    if command == "add" then
        local data = io.read("*all")
        assert(key)
        repository:insert(key, data)
    elseif command == "find" then
        assert(key)
        repository:find(key)
    elseif command == "list" then
        local r = repository:findAll()
        print(table.concat(r, "\n"))
    else
        error("Received unknown option.")
    end
end

main()
