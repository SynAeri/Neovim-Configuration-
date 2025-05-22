-- config/lua/plugins/nvim-chadui.lua
-- Since you're using nvchad-ui and base46 as separate packages,
-- let's configure them properly

-- Load base46 theme
local base46_ok, base46 = pcall(require, "base46")
if base46_ok then
  -- Set up base46 with onedark theme
  base46.load_theme("onedark")
else
  print("base46 not available")
end

-- If nvchad-ui is available, we can use some of its components
local nvchad_ok, nvchad = pcall(require, "nvchad_ui")
if nvchad_ok then
  -- Configure nvchad ui components if available
  print("NvChad UI loaded successfully")
else
  print("NvChad UI not available")
end
