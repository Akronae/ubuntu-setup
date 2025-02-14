vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

local keymap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

local notify = function(cmd)
  return function() vim.fn.VSCodeNotify(cmd) end
end

local vcmd = function(cmd)
  return function() vim.cmd(cmd) end
end

keymap("", "&", "1")
keymap("", "é", "2")
keymap("", "\"", "3")
keymap("", "'", "4")
keymap("", "(", "5")
keymap("", "-", "6")
keymap("", "è", "7")
keymap("", "_", "8")
keymap("", "ç", "9")
keymap("", "à", "0")
keymap("", "ù", "%")
keymap("", "µ", "#")
keymap("", "f<left>", "^")
keymap("", "f<right>", "$")
keymap("", "f<up>", "[m")
keymap("", "f<down>", "]M")
keymap("", "d", "\"_d")
keymap({"", "i"}, "<c-right>", notify("editor.gotoNextFold"))
keymap({"", "i"}, "<c-left>", notify("editor.gotoPreviousFold"))
keymap("", "za", notify("editor.toggleFold"))
keymap("", "zi", notify("editor.toggleImportFold"))
keymap("", "rr", notify("editor.action.rename"))
keymap("", "gr", notify("editor.action.goToReferences"))
keymap("", "<leader>p", notify("workbench.view.explorer"))
keymap("", "<leader>c", notify("workbench.action.terminal.focus"))
keymap("", "<leader>w", notify("workbench.action.files.save"))
keymap("", "<leader>g", notify("workbench.view.scm"))
keymap("", "<c-s-t>", notify("workbench.action.reopenClosedEditor"))
keymap("i", "<c-s>", "<esc>")
