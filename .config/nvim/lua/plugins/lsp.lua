return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ansiblels",
          "clangd",
          "pyright",
          "rust_analyzer",
          "ts_ls",
          "vimls",
          "yamlls",
        },
        handlers = {
          function(server_name)
            vim.lsp.config[server_name] = {
              -- We'll attach capabilities here, but on_attach is better defined centrally or via an autocmd in modern configs
              -- For now we'll inherit the default behavior which is usually fine
            }
          end,
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 5000, lsp_fallback = true },
    },
    -- init = function()
    --   -- If you want the formatexpr, here is the place to set it
    --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP Attach function
      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      end

      -- SourceKit LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config["sourcekit"] = {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("Package.swift")(fname) or util.find_git_ancestor(fname)
        end,
      }
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        floating_window_above_cur_line = false,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
  },
}
