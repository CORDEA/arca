DataRepository = require("data_repository")

local function main()
    local password = arg[1]
    local key = arg[2]
    local data = arg[3]
    local repository = DataRepository:new({ password = password })
end

main()
