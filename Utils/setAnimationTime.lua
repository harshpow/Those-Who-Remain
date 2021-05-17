local AnimationList = {}

return function(animName, animTime)
  if #AnimationList == 0 then
    local PlayAnimation = Animate.PlayAnimation
    AnimationList.PlayAnimation = function(a, Name, c, d, e, f, g, h, Cooldown)
      if AnimationList[Name] then
        Cooldown = AnimationList[Name]
      end
      return PlayAnimation(a, Name, c, d, e, f, g, h, Cooldown)
    end
  else
    AnimationList[animName] = animTime
  end
end