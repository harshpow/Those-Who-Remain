return function(newAmmoCount, doMag, doPool, ItemId)
  local GunData = Utils.requestData().Gun_Data

  ItemId = ItemId == "Primary" and 1 or ItemId == "Secondary" and 2 or nil

  if ItemId then
    -- GunData[ItemId].Name
    if doMag then
      GunData[ItemId].Mag = newAmmoCount
    end
    if doPool then
      GunData[ItemId].Pool = newAmmoCount
    end
  end
end