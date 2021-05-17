return function(ModuleN, Func, nFunc)
  local Old = ModuleN[Func]
  ModuleN[Func] = nFunc
  return Old
end