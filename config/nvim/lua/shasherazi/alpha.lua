local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[_____________________                              _____________________]],
  [[`-._:  .:'   `:::  .:\           |\__/|           /::  .:'   `:::  .:.-']],
  [[    \      :          \          |:   |          /         :       /    ]],
  [[     \     ::    .     `-_______/ ::   \_______-'   .      ::   . /      ]],
  [[      |  :   :: ::'  :   :: ::'  :   :: ::'      :: ::'  :   :: :|       ]],
  [[      |     ;::         ;::         ;::         ;::         ;::  |       ]],
  [[      |  .:'   `:::  .:'   `:::  .:'   `:::  .:'   `:::  .:'   `:|       ]],
  [[      /     :           :           :           :           :    \       ]],
  [[     /______::_____     ::    .     ::    .     ::   _____._::____\      ]],
  [[                   `----._:: ::'  :   :: ::'  _.----'                    ]],
  [[                          `--.       ;::  .--'                           ]],
  [[                              `-. .:'  .-'                               ]],
  [[                                 \    /                                  ]],
  [[                                  \  /                                   ]],
  [[                                   \/                                    ]],
}
dashboard.section.buttons.val = {
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.header.opts = {
  position = 'center',
  padding = 100,
}

alpha.setup(dashboard.opts)
