DataRepository = require("data_repository")

local function main()
    local command = arg[1]
    local password = os.getenv("ARCA_PASSWORD")
    local repository = DataRepository:new({ password = password })
    if command == "add" then
        local key = arg[2]
        local data = arg[3]
        repository.insert(key, data)
    elseif command == "find" then
        local key = arg[2]
        repository.find(key)
    elseif command == "list" then
        local r = repository.findAll()
        print(table.concat(r, "\n"))
    else
        error("Received unknown option.")
    end
end

main()
