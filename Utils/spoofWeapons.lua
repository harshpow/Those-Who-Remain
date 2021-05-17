return function()
  local Config={isEnabled=false}

  coroutine.wrap(function()
    local Metatable = getrawmetatable(game)
    local Namecall = Metatable.__namecall
    setreadonly(Metatable, false)

    Metatable.__namecall = newcclosure(function(T, ...)
      local Arguments = {...}
      if Config.isEnabled and getnamecallmethod() == "FireServer" and Arguments[1] == "GlobalReplicate" then
        local UpdateReplicateType = Arguments[2].Type
        if UpdateReplicateType == "Equip" then
          return
        end
      end

      return Namecall(T, ...)
    end)

    setreadonly(Metatable, true)
  end)()

  return Config
end