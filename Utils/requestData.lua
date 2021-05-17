return function()
  local ENV = getsenv(PlayerScripts.Client)
  return {
    Player_Data = getupvalue(ENV.ClientDismount, 4),
    Gun_Data = getupvalue(ENV.ClientDismount, 6),
    Save_Data = getupvalue(ENV.ClientDismount, 7)
  }
end