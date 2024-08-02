local dap_python = require('dap-python')
dap_python.setup("python")

-- dap.adapters.python = {
--     type = 'executable';
--     command = "/root/miniconda3/bin/python",
--     args = { '-m', 'debugpy.adapter', '--host', "0.0.0.0", '--port', '5678'}
-- }
-- dap.adapters.python = {
--     type = 'server',
--     options = {
--         max_retries = 1000,
--     }
-- }                                           --         type = 'python',
--         request = 'launch',
--         name = 'happy happy',
--         pythonPath = "/root/miniconda3/bin/python",
--         program = "${file}",
--     }
-- } 
--

-- dap.configurations.python = {
--     {
--         type = 'python',
--         request = 'attach',
--         name = 'attach program',
--         -- connect = {
--         --     host = '0.0.0.0',
--         --     port = 5678,
--         -- },
--     }
-- }
