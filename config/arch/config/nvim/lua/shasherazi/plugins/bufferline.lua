return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = "VeryLazy",
  dependenies = 'nvim-tree/nvim-web-devicons',

  config = function()
    local BufferLine = require('bufferline')
    BufferLine.setup()
  end
}
