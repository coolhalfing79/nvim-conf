local M = {
    'mfussenegger/nvim-jdtls',
    ft = "java",
    config = function ()
        local cfg = {
            cmd = {
                'jdtls',
                '-configuration', '/home/anirudhachari/.local/lib/jdtls/config_linux',
                '-data', '/home/anirudhachari/.local/share/jdtls',
            },
            root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'pom.xml'}, { upward = true })[1]),
        }
        require('jdtls').start_or_attach(cfg)
    end
}

return M
