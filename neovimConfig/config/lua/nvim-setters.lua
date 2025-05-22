vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true

-- Only try to load base46 cache if the directory exists
if vim.fn.isdirectory(vim.g.base46_cache) == 1 then
  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
  end
else
  print("base46_cache directory not found")
end
