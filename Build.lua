local function a(b,...)return b("joehack$ -> ",...)end;local c=game:GetService("Players").LocalPlayer;local d=c.PlayerScripts;local e=require(d.Client.Animate)local f=require(d.Client.Bullets)local g=require(d.Client.CursorModule)local h=require(d.Client.Effects)local i=require(d.Client["Equip/UnEquip"])local j=require(d.Client.Footsteps)local k=require(d.Client.Fortifications)local l=require(d.Client.Gui)local m=require(d.Client.Helicopter)local n=require(d.Client.Interact)local o=require(d.Client.Lobby)local p=require(d.Client.Map)local q=require(d.Client.Projectiles)local r=require(d.Client.Ragdolls)local s=require(d.Client.Sounds)local t=require(d.Client["Spawn/Die"])local u=require(d.Client.Spectate)local v=require(d.Client["World Effects"])local w={}w.Config={}function w.requestData()local x=getsenv(d.Client)return{Player_Data=getupvalue(x.ClientDismount,4),Gun_Data=getupvalue(x.ClientDismount,6),Save_Data=getupvalue(x.ClientDismount,7)}end;function w.requestWeaponData()return{Primary={"Sawn Off Shotgun","Ruger 10/22","Ingram MAC-10","Sten Mk V","Mossberg 500","Aero Survival Rifle","Winchester Model 70","KAC PDW","PP-91 Kedr","SAP-6","Kriss Vector","M1 Garand","MP5A2","AR-57","P90","M4A1","SKO Shorty","M14","AK-47","Mosin Nagant","CMMG Mk47 Mutant","RPK","LWRC IC-PSD","Flamethrower","M60","Barrett M82A1","Winchester Model 1892"},Secondary={"Glock 17","LH9 MKII","Walther P38","Serbu Super Shorty","M1911A1","Makarov","TEC-9","MP-443 Grach","PB 6P9","Uzi","Taurus Model 66","CBJ-MS","Colt Python","HK P30L","Desert Eagle"},Melee={"2x4","Wrench","Frying Pan","Umbrella","Crowbar","Pool Cue","Shovel","Golf Club","Butcher Knife","2x4 w/ Barbed Wire","Sledge Hammer","Baseball Bat","Fire Axe","Spiked Baseball Bat","Sabre","Katana"}}end;function w.spoofWeapons()local y={isEnabled=false}coroutine.wrap(function()local z=getrawmetatable(game)local A=z.__namecall;setreadonly(z,false)z.__namecall=newcclosure(function(B,...)local C={...}if y.isEnabled and getnamecallmethod()=="FireServer"and C[1]=="GlobalReplicate"then local D=C[2].Type;if D=="Equip"then return end end;return A(B,...)end)setreadonly(z,true)end)()return y end;function w.forceEquipItem(E,F)local G=w.requestData().Save_Data.Weapons;local H=w.requestWeaponData()local I=H[F]for J,K in next,G do if table.find(I,J)then rawset(G,J,nil)rawset(G,E,{Equipped=true})end end end;local L={}function w.setAnimationTime(M,N)if#L==0 then local O=e.PlayAnimation;L.PlayAnimation=function(P,Q,R,S,T,U,V,W,X)if L[Q]then X=L[Q]end;return O(P,Q,R,S,T,U,V,W,X)end else L[M]=N end end;function w.setAmmo(Y,Z,_,a0)local a1=w.requestData().Gun_Data;a0=a0=="Primary"and 1 or a0=="Secondary"and 2 or nil;if a0 then if Z then a1[a0].Mag=Y end;if _ then a1[a0].Pool=Y end end end;function w.getClosestInfected()local a2=c:GetMouse()local a3=game:GetService("Workspace").CurrentCamera;local a4,a5=math.huge,nil;for a6,a7 in next,workspace.Entities.Infected:GetChildren()do pcall(function()local a8=a7;if a8 and a8.Humanoid.Health>1 then local a9,aa=a3:WorldToViewportPoint(a8.HumanoidRootPart.Position)if aa then local ab=(Vector2.new(a2.X,a2.Y)-Vector2.new(a9.X,a9.Y)).Magnitude;if ab<a4 then a5=a7;a4=ab end end end end)end;return a5,a4 end;function w.hook(ac,ad,ae)local af=ac[ad]ac[ad]=ae;return af end;function w.shootAt(ag,ah)local ai=w.requestData().Save_Data;local aj=w.requestData().Player_Data;local a1=w.requestData().Gun_Data;ah=ah=="Primary"and 1 or ah=="Secondary"and 2;local ak=a1[ah]local al=getsenv(game.Players.LocalPlayer.PlayerScripts.Client).Fire;al(ai,aj,0,ak.Mag,workspace.CurrentCamera.CFrame,{1,2,3},ag,false,0,0)end;local am,an,ao;do for a6,ap in next,getgc(true)do if type(ap)=="table"and rawget(ap,"lm")and rawget(ap,"updateDamageStr")then am=ap end end;an=getupvalue(am.lm,1)ao=getupvalue(am.UpdateSaveClock,1)end;function w.forceDamage(aq,ar,as)local at=game.ReplicatedStorage.RE;local function au()local av=string.reverse(tostring(ao:GetTime()*1+1337))local aw=string.sub(av,string.len(av)-5,string.len(av)-3)..string.sub(av,1,string.len(av)-10)..string.sub(av,string.len(av)-2,string.len(av))..string.sub(av,string.len(av)-9,string.len(av)-6)local ax=""for ay=1,string.len(aw)do local az=string.sub(aw,ay,ay)local aA=az;if an[az]then aA=an[az]end;ax=ax..aA end;return ax,getupvalue(am.updateDamageStr,1)end;local ax,aB=au()at:FireServer(aB,{En=ax,AIs={{AI=aq,Velocity=aq.HumanoidRootPart.Velocity,Special=as,Damage=ar}}})end;function w.forceEquipSkin(aC)local G=w.requestData().Save_Data.Weapons;for Q,a6 in next,G do G[Q].Skin=aC end end;local aD=Drawing.new("Circle")aD.Color=Color3.fromRGB(227,41,87)aD.Position=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)aD.Thickness=2;aD.Filled=false;aD.NumSides=120;aD.Visible=false;local aE=w.spoofWeapons()aE.isEnabled=false;local aF=loadstring(game:HttpGet("https://pastebin.com/raw/RFiFy5wy"))()local aG=aF.new(true,"joehack$ - Those Who Remain")aG.ChangeToggleKey(Enum.KeyCode.RightControl)local aH=aG:Category("Aimbot")local aI=aG:Category("Visuals")local aJ=aG:Category("Editor")local aK=aG:Category("Inventory")local aL=aG:Category("Farmer")local aM=aG:Category("Settings")local aN=aG:Category("Credits")local aO=aN:Sector("Made By")local aP=aN:Sector("Testers")local aQ=aN:Sector("Contact")aO:Cheat("Label","Averias#5303 - discord")aO:Cheat("Label","Averias - v3rmillion")aP:Cheat("Label","Realism#8928")aQ:Cheat("Label","discord server: discord.gg/gkxQWssZHt")aQ:Cheat("Label","discord: Averias#5303")aQ:Cheat("Label","website: joehack.buzz")local aR={SilentAim={Enabled=false,HitPart="Head",FOV_Enabled=false,FOV_Visible=false,FOV_Range=180,WallBang=false},Visuals={Infected={Enabled=false,NameESP=false},Items={Enabled=false,NameESP=false}},Inventory={Primary={InfiniteClipAmmo=false,InfiniteMagAmmo=false},Secondary={InfiniteClipAmmo=false,InfiniteMagAmmo=false},Melee={FastMelee=false,KillAura_Enabled=false,KillAura_HitDelay=5,KillAura_Range=12.5,DecapitationBonus=false},Hammer={FastBuild=false},Shared={FastAim=false,FastReload=false,FastThrow=false}},Farmer={Enabled=false,Method="Rotation",Bonus=nil,DamageDelay=2,SafePlatform=false,DamageModifier=150},Other={ForceAttemptFixLag=false}}local aS=aM:Sector("Force Fix Lag")aS:Cheat("Checkbox","Enabled",function(aT)aR.Other.ForceAttemptFixLag=aT end)do local aU=aH:Sector("Silent Aim")local aV=aH:Sector("Field Of View")local aW=aH:Sector("Other")do aU:Cheat("Checkbox","Silent Aim Enabled",function(aT)aR.SilentAim.Enabled=aT end)aU:Cheat("Dropdown","Hit Part",function(aT)aR.SilentAim.HitPart=aT end,{options={"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}})end;do aV:Cheat("Checkbox","Field Of View Enabled",function(aT)aR.SilentAim.FOV_Enabled=aT end)aV:Cheat("Checkbox","Display Field Of View Circle",function(aT)aD.Visible=aT;aD.Transparency=1 end)aV:Cheat("Slider","Field Of View Range",function(aT)aR.SilentAim.FOV_Range=aT;aD.Radius=aT end,{min=0,max=360,suffix="px"})end;do aW:Cheat("Checkbox","Wall Bang",function(aT)aR.SilentAim.WallBang=aT end)end end;do local aX=aI:Sector("Infected")local aY=aI:Sector("Items")do aX:Cheat("Checkbox","Master Toggle",function(aT)aR.Visuals.Infected.Enabled=aT end)aX:Cheat("Checkbox","Name ESP",function(aT)aR.Visuals.Infected.NameESP=aT end)end;do aY:Cheat("Checkbox","Master Toggle",function(aT)aR.Visuals.Items.Enabled=aT end)aY:Cheat("Checkbox","Name ESP",function(aT)aR.Visuals.Items.NameESP=aT end)end end;do local y={Primary="Sawn Off Shotgun",Secondary="Glock 17",Melee="2x4"}local aZ=aJ:Sector("Loadout")local a_=aJ:Sector("Skins")local b0=aJ:Sector("Other")do aZ:Cheat("Dropdown","Primary Weapon",function(aT)y.Primary=aT end,{options={"Sawn Off Shotgun","Ruger 10/22","Ingram MAC-10","Sten Mk V","Mossberg 500","Aero Survival Rifle","Winchester Model 70","KAC PDW","PP-91 Kedr","SAP-6","Kriss Vector","M1 Garand","MP5A2","AR-57","P90","M4A1","SKO Shorty","M14","AK-47","Mosin Nagant","CMMG Mk47 Mutant","RPK","LWRC IC-PSD","Flamethrower","M60","Barrett M82A1","Winchester Model 1892"}})aZ:Cheat("Dropdown","Secondary Weapon",function(aT)y.Secondary=aT end,{options={"Glock 17","LH9 MKII","Walther P38","Serbu Super Shorty","M1911A1","Makarov","TEC-9","MP-443 Grach","PB 6P9","Uzi","Taurus Model 66","CBJ-MS","Colt Python","HK P30L","Desert Eagle"}})aZ:Cheat("Dropdown","Melee Weapon",function(aT)y.Melee=aT end,{options={"2x4","Wrench","Frying Pan","Umbrella","Crowbar","Pool Cue","Shovel","Golf Club","Butcher Knife","2x4 w/ Barbed Wire","Sledge Hammer","Baseball Bat","Fire Axe","Spiked Baseball Bat","Sabre","Katana"}})aZ:Cheat("Button","Apply",function()if not aE.isEnabled then game.Players.LocalPlayer:Kick("\n\nEnable Editor->Others->false Weapons\nbefore using this.")end;w.forceEquipItem(y.Primary,"Primary")w.forceEquipItem(y.Secondary,"Secondary")w.forceEquipItem(y.Melee,"Melee")end)end;do local b1={Type="Neon",Value="Grid"}a_:Cheat("Dropdown","Neon Tier Skin",function(aT)b1={Type="Neon",Value=aT}end,{options={"Grid","Lightning","Triangles","Matrix","Reality","Pandora","Hawaiian","Ego","Mischief","Lucidity","Past","Fireball","Ripples","Miami","Bliss"}})a_:Cheat("Dropdown","High Tier Skin",function(aT)b1={Type="High",Value=aT}end,{options={"Hope","Dark Mahogany","Steampunk","Hot Head","Virtue","Jupiter","Galaxy","Diamond","Gold","Ruby","Emerald","Sapphire","Amethyst","Spetsnaz Urban","Pacific Tactical","Cherry Blossom","Lava","Pearl","Royalty","Art Deco","Christmas 2018","Christmas 2019","Christmas 2020"}})a_:Cheat("Dropdown","Medium Tier Skin",function(aT)b1={Type="Med",Value=aT}end,{options={"Brushed Metal","Bronze","Eighties","Caution","City Bus","VI","Noir","Blackout","Whiteout","Sports Car","Spiffo","Dark Tan","Veil","Red Polymer","Neapolitan","Coyote Brown","Desert","Winter","OD Green"}})a_:Cheat("Dropdown","Low Tier Skin",function(aT)print(aT)b1={Type="Low",Value=aT}end,{options={"Cocoa","Storm Blue","Orange","Dark Green","Flint","White","Red","Purple","Pink","Pastel Blue","Dark Grey","Yellow","Sage Green","Salmon Pink","Tan","Brown","Grime"}})a_:Cheat("Button","Apply Skin",function()w.forceEquipSkin({b1.Type,b1.Value})end)end;do b0:Cheat("Checkbox","False Weapons",function(aT)aE.isEnabled=aT end)end end;local b2=Instance.new("Part",workspace)b2.Name="joehack$ -> sf platform"b2.Anchored=true;b2.Size=Vector3.new(1000,2,1000)b2.Position=Vector3.new(0,1000,0)local b3=game:GetService("RunService").Stepped;do local b4=aK:Sector("Primary")local b5=aK:Sector("Secondary")local b6=aK:Sector("Melee")local b7=aK:Sector("Hammer")local b8=aK:Sector("Shared")do b4:Cheat("Checkbox","Infinite Clip Ammo",function(aT)aR.Inventory.Primary.InfiniteClipAmmo=aT end)b4:Cheat("Checkbox","Infinite Mag Ammo",function(aT)aR.Inventory.Primary.InfiniteMagAmmo=aT end)end;do b5:Cheat("Checkbox","Infinite Clip Ammo",function(aT)aR.Inventory.Secondary.InfiniteClipAmmo=aT end)b5:Cheat("Checkbox","Infinite Mag Ammo",function(aT)aR.Inventory.Secondary.InfiniteMagAmmo=aT end)end;do b6:Cheat("Checkbox","Fast Melee",function(aT)aR.Inventory.Melee.FastMelee=aT end)b6:Cheat("Checkbox","Kill Aura",function(aT)aR.Inventory.Melee.KillAura_Enabled=aT end)b6:Cheat("Checkbox","Decapitation Bonus",function(aT)aR.Inventory.Melee.DecapitationBonus=aT end)b6:Cheat("Slider","Kill Aura Hit Delay",function(aT)aR.Inventory.Melee.KillAura_HitDelay=aT end,{min=0,max=3,suffix="s"})b6:Cheat("Slider","Kill Aura Range",function(aT)aR.Inventory.Melee.KillAura_Range=aT end,{min=0,max=25,suffix="Studs"})end;do b7:Cheat("Checkbox","Fast Build",function(aT)aR.Inventory.Hammer.FastBuild=aT end)end;do b8:Cheat("Checkbox","Fast Aim",function(aT)aR.Inventory.Shared.FastAim=aT end)b8:Cheat("Checkbox","Fast Reload",function(aT)aR.Inventory.Shared.FastReload=aT end)b8:Cheat("Checkbox","Fast Throw",function(aT)aR.Inventory.Shared.FastThrow=aT end)end end;do local b9=aL:Sector("Kill All")do b9:Cheat("Checkbox","Kill All Enabled",function(aT)aR.Farmer.Enabled=aT end)b9:Cheat("Dropdown","Method",function(aT)aR.Farmer.Method=aT end,{options={"Rotation","Direction"}})b9:Cheat("Checkbox","Safe Platform",function(aT)aR.Farmer.SafePlatform=aT end)b9:Cheat("Dropdown","Bonus",function(aT)if aT=="None"then aR.Farmer.Bonus=nil else aR.Farmer.Bonus=aT end end,{options={"None","Headshot","Fire"}})b9:Cheat("Slider","Damage Modifier",function(aT)aR.Farmer.DamageModifier=aT end,{min=0,max=300,suffix="Damage"})b9:Cheat("Slider","Damage Delay",function(aT)aR.Farmer.DamageDelay=aT end,{min=0,max=4,suffix="s"})b9:Cheat("Label","NOTE: Direction Method doesn't work with Safe Platform.")end end;local ba;ba=w.hook(e,"PlayAnimation",function(P,Q,R,S,T,U,V,W,X)if Q=="Build"and aR.Inventory.Hammer.FastBuild then X=0.05 end;if Q=="Reload"and aR.Inventory.Shared.FastReload then X=0.05 end;if Q=="Throw"and aR.Inventory.Shared.FastThrow then X=0.05 end;if Q=="UnAim"and aR.Inventory.Shared.FastAim then X=0.05 end;if Q=="Aim"and aR.Inventory.Shared.FastAim then X=0.05 end;if Q=="Swing"and aR.Inventory.Melee.FastMelee then X=0.05 end;return ba(P,Q,R,S,T,U,V,W,X)end)local bb;bb=w.hook(f,"Fire",function(P,bc,R,bd,be,U,V)if aR.SilentAim.Enabled then local a7,bf=w.getClosestInfected()if a7 then if aR.SilentAim.FOV_Enabled and bf<=aR.SilentAim.FOV_Range then be=(a7[aR.SilentAim.HitPart].Position-bd.Position).Unit*1000 elseif not aR.SilentAim.FOV_Enabled then be=(a7[aR.SilentAim.HitPart].Position-bd.Position).Unit*1000 end end end;return bb(P,bc,R,bd,be,U,V)end)local bg;bg=w.hook(f,"CheckHit",function(P,bh,R,S)if aR.SilentAim.WallBang then bh.IgList={workspace.Terrain,workspace.Map,workspace.Ignore}end;return bg(P,bh,R,S)end)coroutine.wrap(function()while true do if aR.Inventory.Melee.KillAura_Enabled then for a6,bi in next,workspace.Entities.Infected:GetChildren()do if bi and bi.HumanoidRootPart then pcall(function()local bf=(workspace.CurrentCamera.CFrame.Position-bi.HumanoidRootPart.Position).Magnitude;if bf<=aR.Inventory.Melee.KillAura_Range then w.forceDamage(bi,aR.Farmer.DamageModifier,aR.Inventory.Melee.DecapitationBonus and"Decapitation"or nil)end end)end;if aR.Other.ForceAttemptFixLag then b3:Wait()end end end;wait(aR.Inventory.Melee.KillAura_HitDelay)end end)()coroutine.wrap(function()while true do if aR.Inventory.Primary.InfiniteClipAmmo or aR.Inventory.Primary.InfiniteMagAmmo then pcall(function()local a1=w.requestData().Gun_Data;local J=a1[1].Name;local bj=require(game:GetService("ReplicatedStorage").Modules["Weapon Modules"][J]).Stats;if bj then local bk,bl=bj.Mag,bj.Pool;w.setAmmo(bk,aR.Inventory.Primary.InfiniteClipAmmo,false,"Primary")w.setAmmo(bl,false,aR.Inventory.Primary.InfiniteMagAmmo,"Primary")end end)end;wait()end end)()coroutine.wrap(function()while true do if aR.Inventory.Secondary.InfiniteClipAmmo or aR.Inventory.Secondary.InfiniteMagAmmo then pcall(function()local a1=w.requestData().Gun_Data;local J=a1[2].Name;local bj=require(game:GetService("ReplicatedStorage").Modules["Weapon Modules"][J]).Stats;if bj then local bk,bl=bj.Mag,bj.Pool;w.setAmmo(bk,aR.Inventory.Secondary.InfiniteClipAmmo,false,"Secondary")w.setAmmo(bl,false,aR.Inventory.Secondary.InfiniteMagAmmo,"Secondary")end end)end;wait()end end)()coroutine.wrap(function()while true do if aR.Farmer.Enabled then for a6,bi in next,workspace.Entities.Infected:GetChildren()do if aR.Other.ForceAttemptFixLag then b3:Wait()end;pcall(function()if aR.Farmer.Method=="Rotation"then local bm=c.Character.HumanoidRootPart;bm.CFrame=CFrame.new(bm.Position,bi.HumanoidRootPart.Position)end;if aR.Farmer.SafePlatform then c.Character.HumanoidRootPart.CFrame=CFrame.new(0,1015,0)end;w.forceDamage(bi,aR.Farmer.DamageModifier,aR.Farmer.Bonus)end)end end;wait(aR.Farmer.DamageDelay)end end)()coroutine.wrap(function()while wait(1)do if aR.Farmer.SafePlatform then pcall(function()c.Character.HumanoidRootPart.Position=Vector3.new(0,1005,0)end)end end end)()local bn=game:GetService("VirtualUser")game:GetService("Players").LocalPlayer.Idled:connect(function()bn:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)wait(1)bn:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end)local bo={}bo.Items={}bo.Infected={}local a3=workspace.CurrentCamera;game:GetService("RunService"):BindToRenderStep("esp-upd-t-joehack$",0,function()if aR.Visuals.Infected.NameESP and aR.Visuals.Infected.Enabled then for a6,a7 in next,game:GetService("Workspace").Entities.Infected:GetChildren()do local bp;if not bo.Infected[a7]then bp=Drawing.new("Text")bp.Color=Color3.fromRGB(123,123,123)bp.Visible=true;bo.Infected[a7]=bp else bp=bo.Infected[a7]end;local a9,aa=a3:WorldToViewportPoint(a7.HumanoidRootPart.Position)bp.Color=Color3.fromRGB(209,132,54)bp.Visible=aa and aR.Visuals.Items.NameESP or false;bp.Position=Vector2.new(a9.X,a9.Y)bp.Text=a7.Name end end;if aR.Visuals.Items.NameESP and aR.Visuals.Items.Enabled then for a6,bq in next,game:GetService("Workspace").Ignore.Items:GetChildren()do local bp;if not bo.Items[bq]then bp=Drawing.new("Text")bp.Color=Color3.fromRGB(123,123,123)bp.Visible=true;bo.Items[bq]=bp else bp=bo.Items[bq]end;local a9,aa=a3:WorldToViewportPoint(bq.Box.Position)bp.Color=Color3.fromRGB(82,217,82)bp.Visible=aa and aR.Visuals.Items.NameESP or false;bp.Position=Vector2.new(a9.X,a9.Y)bp.Text=bq.Name end end end)game:GetService("Workspace").Entities.Infected.ChildRemoved:Connect(function(a7)if bo.Infected[a7]then bo.Infected[a7]:Remove()bo.Infected[a7]=nil end end)game:GetService("Workspace").Ignore.Items.ChildRemoved:Connect(function(bq)if bo.Items[bq]then bo.Items[bq]:Remove()bo.Items[bq]=nil end end)