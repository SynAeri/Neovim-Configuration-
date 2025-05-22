-- config/lua/debug-chadrc.lua
print("=== DEBUG: Testing chadrc loading ===")

local ok, chadrc = pcall(require, "chadrc")
print("chadrc loaded:", ok)

if ok then
  print("chadrc type:", type(chadrc))
  if chadrc.nvdash then
    print("nvdash config exists:", chadrc.nvdash ~= nil)
    print("load_on_startup:", chadrc.nvdash.load_on_startup)
    if chadrc.nvdash.header then
      print("header lines:", #chadrc.nvdash.header)
      print("first header line:", chadrc.nvdash.header[1])
      print("second header line:", chadrc.nvdash.header[2])
    end
  end
else
  print("chadrc error:", chadrc)
end

-- Check if nvconfig is also being loaded (it shouldn't be)
local nvconfig_ok, nvconfig = pcall(require, "nvconfig")
print("nvconfig loaded (should be false):", nvconfig_ok)
