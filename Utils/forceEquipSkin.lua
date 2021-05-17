return function(skinData)
  local EquippedInventory = Utils.requestData().Save_Data.Weapons
  for Name, _ in next, EquippedInventory do
    EquippedInventory[Name].Skin = skinData
  end
end