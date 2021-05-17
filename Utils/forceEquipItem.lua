return function(itemName, itemType)
  local EquippedInventory = Utils.requestData().Save_Data.Weapons
  local itemList = Utils.requestWeaponData()
  local List = itemList[itemType]
  for WeaponName, WeaponData in next, EquippedInventory do
    if table.find(List, WeaponName) then
      rawset(EquippedInventory, WeaponName, nil)
      rawset(EquippedInventory, itemName, {Equipped=true})
    end
  end
end