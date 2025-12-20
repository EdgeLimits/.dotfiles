return{
  "numToStr/Comment.nvim",
  event = {  "BufReadPre", "BufNewFile" },
  -- config = true -- runs require("Comment").setup()
  config = function()
    local comment = require("Comment")
    comment.setup()
  end,
}

-- NORMAL mode
--[[
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment ]]


