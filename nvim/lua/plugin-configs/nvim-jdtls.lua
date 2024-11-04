vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        if (args.match == "java") then
            local config = {
                cmd = {
                    "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true",
                    "-Dlog.level=ALL", "-Xmx1g", "--add-modules=ALL-SYSTEM", "--add-opens",
                    "java.base/java.util=ALL-UNNAMED", "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",
                    "-javaagent:/home/felipe/Documents/executables/lombok/lombok.jar", "-jar",
                    "/home/felipe/Documents/executables/jdt-language-server-1.38.0/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
                    "-configuration",
                    "/home/felipe/Documents/executables/jdt-language-server-1.38.0/config_linux",
                    "-data", "/home/felipe/.jdtls-data/" .. vim.fn.getcwd():gsub("%/", "__")
                },
                root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
                settings = {java = {signatureHelp = {enabled = true}}}
            }
            require("jdtls").start_or_attach(config)
        end
    end
})
