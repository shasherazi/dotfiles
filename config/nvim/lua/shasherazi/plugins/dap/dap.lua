local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = 3666,
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = { "/home/shasherazi/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter", "${port}" },
  }
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
