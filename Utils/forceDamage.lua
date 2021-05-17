local fDData, IdentifierGl, ClockHandler
do
  for _, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "lm") and rawget(v, "updateDamageStr") then
      fDData = v
    end
  end
  
  IdentifierGl = getupvalue(fDData.lm, 1)
  ClockHandler = getupvalue(fDData.UpdateSaveClock, 1)
end

return function(entity, damage, specialBonus)
  local Event = game.ReplicatedStorage.RE

  local function getKey()
    local Identifier = string.reverse( tostring( ClockHandler:GetTime() * 1 + 1337 ) )
    local BasicsKey = string.sub( Identifier, string.len( Identifier ) - 5, string.len( Identifier ) - 3 ) .. string.sub( Identifier, 1, string.len( Identifier ) - 10 ) .. string.sub( Identifier, string.len( Identifier ) - 2, string.len( Identifier ) ) .. string.sub( Identifier, string.len( Identifier ) - 9, string.len( Identifier ) - 6 )
    local EnKey = ""
    for SID = 1, string.len( BasicsKey ) do
      local iCL = string.sub( BasicsKey, SID, SID )
      local newiCL = iCL
      if IdentifierGl[iCL] then
        newiCL = IdentifierGl[iCL]
      end
      EnKey = EnKey .. newiCL
    end
    return EnKey, getupvalue(fDData.updateDamageStr, 1)
  end

  local EnKey, DamageKey = getKey()

  Event:FireServer(DamageKey, {
    En = EnKey,
    AIs = {
      {
        AI = entity,
        Velocity = entity.HumanoidRootPart.Velocity,
        Special = specialBonus,
        Damage = damage
      }
    }
  })
end