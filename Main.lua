-- local SCRIPT_UPDATE_VERSION = 755
-- local GAME_UPDATE_VERSION = game.PlaceVersion

local function debugOut(ftype, ...)
  return ftype("joehack$ -> ", ...)
end

local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerScripts = LocalPlayer.PlayerScripts
local Animate = require(PlayerScripts.Client.Animate)
local Bullets = require(PlayerScripts.Client.Bullets)
local CursorModule = require(PlayerScripts.Client.CursorModule)
local Effects = require(PlayerScripts.Client.Effects)
local Equip_Unequip = require(PlayerScripts.Client["Equip/UnEquip"])
local Footsteps = require(PlayerScripts.Client.Footsteps)
local Fortifications = require(PlayerScripts.Client.Fortifications)
local Gui = require(PlayerScripts.Client.Gui)
local Helicopter = require(PlayerScripts.Client.Helicopter)
local Interact = require(PlayerScripts.Client.Interact)
local Lobby = require(PlayerScripts.Client.Lobby)
local Map = require(PlayerScripts.Client.Map)
local Projectiles = require(PlayerScripts.Client.Projectiles)
local Ragdolls = require(PlayerScripts.Client.Ragdolls)
local Sounds = require(PlayerScripts.Client.Sounds)
local Spawn_Die = require(PlayerScripts.Client["Spawn/Die"])
local Spectate = require(PlayerScripts.Client.Spectate)
local WorldEffects = require(PlayerScripts.Client["World Effects"])


local FOV_Circle = Drawing.new("Circle")
FOV_Circle.Color = Color3.fromRGB(227, 41, 87)
FOV_Circle.Position = Vector2.new(
  workspace.CurrentCamera.ViewportSize.X / 2,
  workspace.CurrentCamera.ViewportSize.Y / 2
)
FOV_Circle.Thickness = 2
FOV_Circle.Filled = false
FOV_Circle.NumSides = 120
FOV_Circle.Visible = false

local SpoofConfig = Utils.spoofWeapons()
SpoofConfig.isEnabled = false

local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/RFiFy5wy"))()

local Window = UILibrary.new(true, "joehack$ - Those Who Remain")
-- local Window = UILibrary.new(true, ("joehack$ [version: %s]"):format("2.0."..tostring(SCRIPT_UPDATE_VERSION).."0.2"))
Window.ChangeToggleKey(Enum.KeyCode.RightControl)

local AimbotCategory = Window:Category("Aimbot")
local VisualsCategory = Window:Category("Visuals")
local EditorCategory = Window:Category("Editor")
local GunCheatsCategory = Window:Category("Inventory")
local FarmerCategory = Window:Category("Farmer")
local SettingsCategory = Window:Category("Settings")
local CreditsCategory = Window:Category("Credits")
local CSector = CreditsCategory:Sector("Made By")
local TSector = CreditsCategory:Sector("Testers")
local ISector = CreditsCategory:Sector("Contact")



CSector:Cheat("Label", "Averias#2829 - discord")
CSector:Cheat("Label", "Averias - v3rmillion")
TSector:Cheat("Label", "Realism#8928")
ISector:Cheat("Label", "discord server: discord.gg/gkxQWssZHt")
ISector:Cheat("Label", "discord: Averias#5303")
ISector:Cheat("Label", "website: joehack.buzz")

local ScriptSettings = {
  SilentAim = {
    Enabled = false,
    HitPart = "Head",
    FOV_Enabled = false,
    FOV_Visible = false,
    FOV_Range = 180,
    WallBang = false
  },
  Visuals = {
    Infected = {
      Enabled = false,
      NameESP = false,
    },
    Items = {
      Enabled = false,
      NameESP = false,
    }
  },
  Inventory = {
    Primary = {
      InfiniteClipAmmo = false,
      InfiniteMagAmmo = false
    },
    Secondary = {
      InfiniteClipAmmo = false,
      InfiniteMagAmmo = false
    },
    Melee = {
      FastMelee = false,
      KillAura_Enabled = false,
      KillAura_HitDelay = 5,
      KillAura_Range = 12.5,
      DecapitationBonus = false
    },
    Hammer = {
      FastBuild = false
    },
    Shared = {
      FastAim = false,
      FastReload = false,
      FastThrow = false
    }
  },
  Farmer = {
    Enabled = false,
    Method = "Rotation",
    Bonus = nil,
    DamageDelay = 2,
    SafePlatform = false,
    DamageModifier = 150,
  },
  Other = {
    ForceAttemptFixLag = false,
  }
}
local FRLSector = SettingsCategory:Sector("Force Fix Lag")
FRLSector:Cheat("Checkbox", "Enabled", function(State)
  ScriptSettings.Other.ForceAttemptFixLag = State
end)

do -- Setup Aimbot Category
  local SilentAimSector = AimbotCategory:Sector("Silent Aim")
  local FieldOfViewSector = AimbotCategory:Sector("Field Of View")
  local OtherSector = AimbotCategory:Sector("Other")
    
  do -- Setup SilentAim Sector
    SilentAimSector:Cheat("Checkbox", "Silent Aim Enabled", function(State)
      ScriptSettings.SilentAim.Enabled = State
    end)

    -- SilentAimSector:Cheat("Checkbox", "Screen Point Check", function(State)
    --   ScriptSettings.SilentAim.ScreenPointCheck = State
    -- end)

    SilentAimSector:Cheat("Dropdown", "Hit Part", function(State)
      ScriptSettings.SilentAim.HitPart = State
    end, {
      options = {
        "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"
      }
    })
  end

  do -- Setup FieldOfView Sector
    FieldOfViewSector:Cheat("Checkbox", "Field Of View Enabled", function(State)
      ScriptSettings.SilentAim.FOV_Enabled = State
    end)
    FieldOfViewSector:Cheat("Checkbox", "Display Field Of View Circle", function(State)
      FOV_Circle.Visible = State
      FOV_Circle.Transparency = 1
    end)
    FieldOfViewSector:Cheat("Slider", "Field Of View Range", function(State)
      ScriptSettings.SilentAim.FOV_Range = State
      FOV_Circle.Radius = State
    end, {min = 0, max = 360, suffix="px"})

  end

  do -- Setup Other Sector
    OtherSector:Cheat("Checkbox", "Wall Bang", function(State)
      ScriptSettings.SilentAim.WallBang = State
    end)
  end
end

do -- Setup Visuals Category
  local InfectedSector = VisualsCategory:Sector("Infected")
  local ItemsSector = VisualsCategory:Sector("Items")
  
  do -- Setup Infected Sector
    InfectedSector:Cheat("Checkbox", "Master Toggle", function(State)
      ScriptSettings.Visuals.Infected.Enabled = State
    end)
    
    InfectedSector:Cheat("Checkbox", "Name ESP", function(State)
      ScriptSettings.Visuals.Infected.NameESP = State
    end)
  end

  do -- Setup Items Sector
    ItemsSector:Cheat("Checkbox", "Master Toggle", function(State)
      ScriptSettings.Visuals.Items.Enabled = State
    end)

    ItemsSector:Cheat("Checkbox", "Name ESP", function(State)
      ScriptSettings.Visuals.Items.NameESP = State
    end)
  end
end
  
do -- Setup Editor Category
  local Config = {
    Primary = "Sawn Off Shotgun",
    Secondary = "Glock 17",
    Melee = "2x4"
  }
  local LoadoutCategory = EditorCategory:Sector("Loadout")
  local SkinsCategory = EditorCategory:Sector("Skins")
  local OtherCategory = EditorCategory:Sector("Other")

  do -- Setup Loadout Category
    LoadoutCategory:Cheat("Dropdown", "Primary Weapon", function(State)
      Config.Primary = State
    end, {
      options={
      "Sawn Off Shotgun",
      "Ruger 10/22",
      "Ingram MAC-10",
      "Sten Mk V",
      "Mossberg 500",
      "Aero Survival Rifle",
      "Winchester Model 70",
      "KAC PDW",
      "PP-91 Kedr",
      "SAP-6",
      "Kriss Vector",
      "M1 Garand",
      "MP5A2",
      "AR-57",
      "P90",
      "M4A1",
      "SKO Shorty",
      "M14",
      "AK-47",
      "Mosin Nagant",
      "CMMG Mk47 Mutant",
      "RPK",
      "LWRC IC-PSD",
      "Flamethrower",
      "M60",
      "Barrett M82A1",
      "Winchester Model 1892",
      }
    })
    LoadoutCategory:Cheat("Dropdown", "Secondary Weapon", function(State)
      Config.Secondary = State
    end, {
      options={
      "Glock 17",
      "LH9 MKII",
      "Walther P38",
      "Serbu Super Shorty",
      "M1911A1",
      "Makarov",
      "TEC-9",
      "MP-443 Grach",
      "PB 6P9",
      "Uzi",
      "Taurus Model 66",
      "CBJ-MS",
      "Colt Python",
      "HK P30L",
      "Desert Eagle"
      }
    })
    LoadoutCategory:Cheat("Dropdown", "Melee Weapon", function(State)
      Config.Melee = State
    end, {
      options={
      "2x4",
      "Wrench",
      "Frying Pan",
      "Umbrella",
      "Crowbar",
      "Pool Cue",
      "Shovel",
      "Golf Club",
      "Butcher Knife",
      "2x4 w/ Barbed Wire",
      "Sledge Hammer",
      "Baseball Bat",
      "Fire Axe",
      "Spiked Baseball Bat",
      "Sabre",
      "Katana"
      }
    })

    LoadoutCategory:Cheat("Button", "Apply", function()
      if not SpoofConfig.isEnabled then
        game.Players.LocalPlayer:Kick("\n\nEnable Editor->Others->false Weapons\nbefore using this.")
      end
      Utils.forceEquipItem(Config.Primary, "Primary")
      Utils.forceEquipItem(Config.Secondary, "Secondary")
      Utils.forceEquipItem(Config.Melee, "Melee")
    end)
  end

  do -- Setup Skins Category

    local SkinData = {Type="Neon", Value="Grid"}

    SkinsCategory:Cheat("Dropdown", "Neon Tier Skin", function(State)
      SkinData = {Type="Neon", Value=State}
    end, {
      options = {
      "Grid", "Lightning", "Triangles",
      "Matrix", "Reality", "Pandora",
      "Hawaiian", "Ego", "Mischief",
      "Lucidity", "Past", "Fireball",
      "Ripples", "Miami", "Bliss"
      }
    })
    SkinsCategory:Cheat("Dropdown", "High Tier Skin", function(State)
      SkinData = {Type="High", Value=State}
    end, {
      options = {
      "Hope", "Dark Mahogany", "Steampunk",
      "Hot Head", "Virtue", "Jupiter",
      "Galaxy", "Diamond", "Gold",
      "Ruby", "Emerald", "Sapphire",
      "Amethyst", "Spetsnaz Urban", "Pacific Tactical",
      "Cherry Blossom", "Lava", "Pearl",
      "Royalty", "Art Deco", "Christmas 2018",
      "Christmas 2019", "Christmas 2020"
      }
    })
    SkinsCategory:Cheat("Dropdown", "Medium Tier Skin", function(State)
      SkinData = {Type="Med", Value=State}
    end, {
      options = {
      "Brushed Metal", "Bronze", "Eighties",
      "Caution", "City Bus", "VI",
      "Noir", "Blackout", "Whiteout",
      "Sports Car", "Spiffo", "Dark Tan",
      "Veil", "Red Polymer", "Neapolitan",
      "Coyote Brown", "Desert", "Winter",
      "OD Green"
      }
    })
    SkinsCategory:Cheat("Dropdown", "Low Tier Skin", function(State)
      print(State)
      SkinData = {Type="Low", Value=State}
    end, {
      options = {
      "Cocoa", "Storm Blue", "Orange",
      "Dark Green", "Flint", "White",
      "Red", "Purple", "Pink",
      "Pastel Blue", "Dark Grey", "Yellow",
      "Sage Green", "Salmon Pink", "Tan",
      "Brown", "Grime",
      }
    })

    SkinsCategory:Cheat("Button", "Apply Skin", function()
      Utils.forceEquipSkin({
        SkinData.Type,
        SkinData.Value
      })
    end)
    
  end

  do -- Setup Other Category
    OtherCategory:Cheat("Checkbox", "False Weapons", function(State)
      SpoofConfig.isEnabled = State
    end)
    -- OtherCategory:Cheat("Checkbox", "Ammo Spoofing", function(State)
      
    -- end)
  end
end


local SafePlatformStand = Instance.new("Part", workspace)
SafePlatformStand.Name = "joehack$ -> sf platform"
SafePlatformStand.Anchored = true
SafePlatformStand.Size = Vector3.new(1000, 2, 1000)
SafePlatformStand.Position = Vector3.new(0, 1000, 0)

local RunServiceStepped = game:GetService("RunService").Stepped


do -- Setup Gun Cheats Category
  local PrimarySector = GunCheatsCategory:Sector("Primary")
  local SecondarySector = GunCheatsCategory:Sector("Secondary")
  local MeleeSector = GunCheatsCategory:Sector("Melee")
  local HammerSector = GunCheatsCategory:Sector("Hammer")
  local SharedSector = GunCheatsCategory:Sector("Shared")

  do -- Setup Primary Sector
    PrimarySector:Cheat("Checkbox", "Infinite Clip Ammo", function(State)
      ScriptSettings.Inventory.Primary.InfiniteClipAmmo = State
    end)
    
    PrimarySector:Cheat("Checkbox", "Infinite Mag Ammo", function(State)
      ScriptSettings.Inventory.Primary.InfiniteMagAmmo = State
    end)
  end

  do -- Setup Secondary Sector
    SecondarySector:Cheat("Checkbox", "Infinite Clip Ammo", function(State)
      ScriptSettings.Inventory.Secondary.InfiniteClipAmmo = State
    end)

    SecondarySector:Cheat("Checkbox", "Infinite Mag Ammo", function(State)
      ScriptSettings.Inventory.Secondary.InfiniteMagAmmo = State
    end)
  end

  

  do -- Setup Melee Sector
    MeleeSector:Cheat("Checkbox", "Fast Melee", function(State)
      ScriptSettings.Inventory.Melee.FastMelee = State
    end)
    MeleeSector:Cheat("Checkbox", "Kill Aura", function(State)
      ScriptSettings.Inventory.Melee.KillAura_Enabled = State
    end)
    MeleeSector:Cheat("Checkbox", "Decapitation Bonus", function(State)
      ScriptSettings.Inventory.Melee.DecapitationBonus = State
    end)
    MeleeSector:Cheat("Slider", "Kill Aura Hit Delay", function(State)
      ScriptSettings.Inventory.Melee.KillAura_HitDelay = State
    end, {min = 0, max = 3, suffix="s"})
    MeleeSector:Cheat("Slider", "Kill Aura Range", function(State)
      ScriptSettings.Inventory.Melee.KillAura_Range = State
    end, {min = 0, max = 25, suffix="Studs"})
  end

  do -- Setup Hammer Sector
    HammerSector:Cheat("Checkbox", "Fast Build", function(State)
      ScriptSettings.Inventory.Hammer.FastBuild = State
    end)
  end

  do -- Setup Shared Sector
    SharedSector:Cheat("Checkbox", "Fast Aim", function(State)
      ScriptSettings.Inventory.Shared.FastAim = State
    end)
    SharedSector:Cheat("Checkbox", "Fast Reload", function(State)
      ScriptSettings.Inventory.Shared.FastReload = State
    end)
    SharedSector:Cheat("Checkbox", "Fast Throw", function(State)
      ScriptSettings.Inventory.Shared.FastThrow = State
    end)
  end
end

do -- Setup Farmer Category
  local AutoFarmSector = FarmerCategory:Sector("Kill All")

  do -- Setup Auto Farm Sector
    AutoFarmSector:Cheat("Checkbox", "Kill All Enabled", function(State)
      ScriptSettings.Farmer.Enabled = State  
    end)
    AutoFarmSector:Cheat("Dropdown", "Method", function(State)
      ScriptSettings.Farmer.Method = State
    end, {
      options = {
        "Rotation", "Direction"
      }
    })
    AutoFarmSector:Cheat("Checkbox", "Safe Platform", function(State)
      ScriptSettings.Farmer.SafePlatform = State
    end)
    AutoFarmSector:Cheat("Dropdown", "Bonus", function(State)
      if State == "None" then
        ScriptSettings.Farmer.Bonus = nil
      else
        ScriptSettings.Farmer.Bonus = State
      end
    end, {
      options = {
        "None", "Headshot", "Fire"
      }
    })
    AutoFarmSector:Cheat("Slider", "Damage Modifier", function(State)
      ScriptSettings.Farmer.DamageModifier = State
    end, {min = 0, max = 300, suffix="Damage"})

    AutoFarmSector:Cheat("Slider", "Damage Delay", function(State)
      ScriptSettings.Farmer.DamageDelay = State
    end, {min = 0, max = 4, suffix="s"})

    AutoFarmSector:Cheat("Label", "NOTE: Direction Method doesn't work with Safe Platform.")
  end
end


local oldPlayAnim oldPlayAnim = Utils.hook(Animate, "PlayAnimation", function(a, Name, c, d, e, f, g, h, Cooldown)
  if Name == "Build" and ScriptSettings.Inventory.Hammer.FastBuild then
    Cooldown = 0.05
  end
  if Name == "Reload" and ScriptSettings.Inventory.Shared.FastReload then
    Cooldown = 0.05
  end
  if Name == "Throw" and ScriptSettings.Inventory.Shared.FastThrow then
    Cooldown = 0.05
  end
  if Name == "UnAim" and ScriptSettings.Inventory.Shared.FastAim then
    Cooldown = 0.05
  end
  if Name == "Aim" and ScriptSettings.Inventory.Shared.FastAim then
    Cooldown = 0.05
  end
  if Name == "Swing" and ScriptSettings.Inventory.Melee.FastMelee then
    Cooldown = 0.05
  end
  return oldPlayAnim(a, Name, c, d, e, f, g, h, Cooldown)
end)

local oldFireBullet oldFireBullet = Utils.hook(Bullets, "Fire", function(a,b,c,Current,Direction,f,g)
  if ScriptSettings.SilentAim.Enabled then
    local Infected, Distance = Utils.getClosestInfected()
    if Infected then
      if ScriptSettings.SilentAim.FOV_Enabled and Distance <= ScriptSettings.SilentAim.FOV_Range then
        Direction = ( Infected[ScriptSettings.SilentAim.HitPart].Position - Current.Position ).Unit * 1000
      elseif not ScriptSettings.SilentAim.FOV_Enabled then
        Direction = ( Infected[ScriptSettings.SilentAim.HitPart].Position - Current.Position ).Unit * 1000
      end
    end
  end
  return oldFireBullet(a,b,c,Current,Direction,f,g)
end)

local oldCheckHit oldCheckHit = Utils.hook(Bullets, "CheckHit", function(a,LIST,c,d)
  if ScriptSettings.SilentAim.WallBang then
    LIST.IgList = {
      workspace.Terrain,
      workspace.Map,
      workspace.Ignore
    }
  end
  return oldCheckHit(a, LIST, c, d)
end)

-- Melee Aura
coroutine.wrap(function()
  -- debugOut(warn, "Melee Aura Successfully instalized.")
  while true do
    if ScriptSettings.Inventory.Melee.KillAura_Enabled then
      for _, Entity in next, workspace.Entities.Infected:GetChildren() do
        if Entity and Entity.HumanoidRootPart then
          pcall(function()
            local Distance = (workspace.CurrentCamera.CFrame.Position - Entity.HumanoidRootPart.Position).Magnitude
            if Distance <= ScriptSettings.Inventory.Melee.KillAura_Range then
              Utils.forceDamage(Entity, ScriptSettings.Farmer.DamageModifier, ScriptSettings.Inventory.Melee.DecapitationBonus and "Decapitation" or nil)
            end
          end)
        end
        if ScriptSettings.Other.ForceAttemptFixLag then RunServiceStepped:Wait() end
      end
    end
    wait(ScriptSettings.Inventory.Melee.KillAura_HitDelay)
  end
end)()

-- Primary - Inf Ammo

coroutine.wrap(function()
  while true do
    if ScriptSettings.Inventory.Primary.InfiniteClipAmmo or ScriptSettings.Inventory.Primary.InfiniteMagAmmo then
      pcall(function()
        local GunData = Utils.requestData().Gun_Data
        local WeaponName = GunData[1].Name
        local DefaultSettings = require(game:GetService("ReplicatedStorage").Modules["Weapon Modules"][WeaponName]).Stats

        if DefaultSettings then
          local DefaultMag, DefaultPool = DefaultSettings.Mag, DefaultSettings.Pool
          Utils.setAmmo(DefaultMag, ScriptSettings.Inventory.Primary.InfiniteClipAmmo, false, "Primary")
          Utils.setAmmo(DefaultPool, false, ScriptSettings.Inventory.Primary.InfiniteMagAmmo, "Primary")
        end
      end)
    end
    wait()
  end
end)()

-- Secondary - Inf Ammo

coroutine.wrap(function()
  while true do
    if ScriptSettings.Inventory.Secondary.InfiniteClipAmmo or ScriptSettings.Inventory.Secondary.InfiniteMagAmmo then
      pcall(function()
        local GunData = Utils.requestData().Gun_Data
        local WeaponName = GunData[2].Name
        local DefaultSettings = require(game:GetService("ReplicatedStorage").Modules["Weapon Modules"][WeaponName]).Stats

        if DefaultSettings then
          local DefaultMag, DefaultPool = DefaultSettings.Mag, DefaultSettings.Pool
          Utils.setAmmo(DefaultMag, ScriptSettings.Inventory.Secondary.InfiniteClipAmmo, false, "Secondary")
          Utils.setAmmo(DefaultPool, false, ScriptSettings.Inventory.Secondary.InfiniteMagAmmo, "Secondary")
        end
      end)
    end
    wait()
  end
end)()

-- Kill All
coroutine.wrap(function()
  -- debugOut(warn, "Kill All Successfully instalized.")
  while true do
    if ScriptSettings.Farmer.Enabled then
      for _, Entity in next, workspace.Entities.Infected:GetChildren() do
        if ScriptSettings.Other.ForceAttemptFixLag then RunServiceStepped:Wait()  end
        pcall(function()
          if ScriptSettings.Farmer.Method == "Rotation" then
            local HRP = LocalPlayer.Character.HumanoidRootPart
            HRP.CFrame = CFrame.new(
              HRP.Position,
              Entity.HumanoidRootPart.Position
            )
            end
          if ScriptSettings.Farmer.SafePlatform then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1015, 0)
          end
          Utils.forceDamage(Entity, ScriptSettings.Farmer.DamageModifier, ScriptSettings.Farmer.Bonus)
        end)
      end
    end
    wait(ScriptSettings.Farmer.DamageDelay)
  end
end)()

coroutine.wrap(function()
  while wait(1) do
    if ScriptSettings.Farmer.SafePlatform then
      pcall(function()
        LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(0, 1005, 0)
      end)
    end
  end
end)()

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


local ESP = {}
ESP.Items = {}
ESP.Infected = {}

local Camera = workspace.CurrentCamera
game:GetService("RunService"):BindToRenderStep("esp-upd-t-joehack$", 0, function()
  if ScriptSettings.Visuals.Infected.NameESP and ScriptSettings.Visuals.Infected.Enabled then
    for _, Infected in next, game:GetService("Workspace").Entities.Infected:GetChildren() do
      local iESP
      if not ESP.Infected[Infected] then
        iESP = Drawing.new("Text")
        iESP.Color = Color3.fromRGB(123, 123, 123)
        iESP.Visible = true
        ESP.Infected[Infected] = iESP
      else
        iESP = ESP.Infected[Infected]
      end
      local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(Infected.HumanoidRootPart.Position)
      iESP.Color = Color3.fromRGB(209, 132, 54)
      iESP.Visible = IsVisibleOnViewPort and ScriptSettings.Visuals.Items.NameESP or false
      iESP.Position = Vector2.new(ScreenPosition.X, ScreenPosition.Y)
      iESP.Text = Infected.Name
    end
  end
  if ScriptSettings.Visuals.Items.NameESP and ScriptSettings.Visuals.Items.Enabled then
    for _, Item in next, game:GetService("Workspace").Ignore.Items:GetChildren() do
      local iESP
      if not ESP.Items[Item] then
        iESP = Drawing.new("Text")
        iESP.Color = Color3.fromRGB(123, 123, 123)
        iESP.Visible = true
        ESP.Items[Item] = iESP
      else
        iESP = ESP.Items[Item]
      end
      local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(Item.Box.Position)
      iESP.Color = Color3.fromRGB(82, 217, 82)
      iESP.Visible = IsVisibleOnViewPort and ScriptSettings.Visuals.Items.NameESP or false
      iESP.Position = Vector2.new(ScreenPosition.X, ScreenPosition.Y)
      iESP.Text = Item.Name
    end
  end
end)

game:GetService("Workspace").Entities.Infected.ChildRemoved:Connect(function(Infected)
  if ESP.Infected[Infected] then
    ESP.Infected[Infected]:Remove()
    ESP.Infected[Infected]=nil
  end
end)
game:GetService("Workspace").Ignore.Items.ChildRemoved:Connect(function(Item)
  if ESP.Items[Item] then
    ESP.Items[Item]:Remove()
    ESP.Items[Item]=nil
  end
end)
