local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}
M.general = {
  i = {
    ["ii"] = {"<ESC>:w<ENTER>", opts = { nowait = true } },
    ["шш"] = {"<ESC>:w<ENTER>", opts = { nowait = true } },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
