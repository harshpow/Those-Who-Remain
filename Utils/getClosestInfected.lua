return function()
  local LMouse = LocalPlayer:GetMouse()
  local Camera = game:GetService("Workspace").CurrentCamera

  local ClosestDistance, ClosestInfected = math.huge, nil;
  for _,Infected in next, workspace.Entities.Infected:GetChildren() do
    pcall(function()
      local Character = Infected
      if Character and Character.Humanoid.Health > 1 then
        local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
        if IsVisibleOnViewPort then
          local MDistance = (Vector2.new(LMouse.X, LMouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
          if MDistance < ClosestDistance then
            ClosestInfected = Infected
            ClosestDistance = MDistance
          end
        end
      end
    end)
  end
  return ClosestInfected, ClosestDistance
end