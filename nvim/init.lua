-- Включение нумерации строк
--
vim.opt.number = true
-- Показывать номера строк в относительном формате
vim.opt.relativenumber = true

-- Включение табуляции с 4 пробелами
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Включение автодополнения скобок
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Включение подсветки текущей строки
vim.opt.cursorline = true

-- Включение подсветки синтаксиса
vim.opt.syntax = "on"

-- Включение поиска с игнорированием регистра
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Включение автосохранения при изменении буфера
vim.opt.autowrite = true

-- Включение разделителя между окнами
vim.opt.splitright = true
vim.opt.splitbelow = true

  vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- LAZY--

--
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)






-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {

    -- add your plugins here
    {
    "folke/tokyonight.nvim",
    lazy = false, -- Убедитесь, что она загружается во время старта, если это ваша основная цветовая схема
    priority = 1000, -- Убедитесь, что эта тема загружается до всех других плагинов, которые начинают работу
    config = function()
      -- Загрузка цветовой схемы здесь
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

     
   --LSP  - server
  {
        "neovim/nvim-lspconfig", -- Базовая настройка LSP
    },
    {
        "folke/trouble.nvim", -- Для удобного просмотра проблем
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            auto_open = false,
            auto_close = true,
        },
    },
    {
        "hrsh7th/nvim-cmp", -- Ядро автодополнения
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Источник данных от LSP
            "hrsh7th/cmp-buffer",   -- Источник данных из буфера
            "hrsh7th/cmp-path",     -- Источник данных из путей файловой системы
            "saadparwaiz1/cmp_luasnip", -- Поддержка сниппетов
        },
    },
    {

    {
        "L3MON4D3/LuaSnip", -- Snippets
    },
    {
        "nvim-treesitter/nvim-treesitter", -- Синтаксический анализ
        build = ":TSUpdate",
    },
    {
        "nvim-tree/nvim-tree.lua", -- File Explorer
    },
    {
        "nvim-lualine/lualine.nvim", -- Statusline
    },

    -- Настройка Ruff Language Server
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Зависимость для Telescope
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git" }, -- Игнорировать ненужные файлы
            },
        })

        -- Клавишные комбинации
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- Поиск файлов
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")  -- Поиск текста
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")   -- Поиск открытых буферов
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- Поиск справки
    end,
},

{
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Иконки для файлового менеджера
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30, -- Ширина окна
            },
            renderer = {
                icons = {
                    show = {
                        file = true, -- Показывать иконки файлов
                        folder = true, -- Показывать иконки папок
                    },
                },
            },
        })

        -- Клавишные комбинации
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>") -- Открыть/закрыть файловый менеджер
    end,
},
{
    "simrat39/symbols-outline.nvim",
    config = function()
        require("symbols-outline").setup({
            highlight_hovered_item = true, -- Подсвечивать выбранный элемент
            position = "right",           -- Позиция окна (справа)
            width = 30,                   -- Ширина окна
        })

        -- Клавишные комбинации
        vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>") -- Открыть обзор структуры
    end,
},

{
    "mfussenegger/nvim-dap", -- Основной плагин для отладки
},
{
    "mfussenegger/nvim-dap-python", -- Расширение для Python
    dependencies = { "mfussenegger/nvim-dap" },
},

  {
    "rcarriga/nvim-dap-ui", -- Интерфейс для отладки
    dependencies = { "mfussenegger/nvim-dap" },
},

{
    "lewis6991/gitsigns.nvim", -- Индикаторы изменений
},
{
    "TimUntersberger/neogit", -- Интерфейс Git
    dependencies = { "nvim-lua/plenary.nvim" },
},

{
    "nvim-neotest/neotest", -- Основной плагин для тестирования
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim", -- Для улучшения производительности
    },
},
{
    "nvim-neotest/neotest-python", -- Расширение для Python
},

{
    "nvim-neotest/nvim-nio", -- Обязательный плагин для neotest
},

{
  "jackplus-xyz/player-one.nvim",
  ---@type PlayerOne.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
{
    "EggbertFluffle/beepboop.nvim",
    opts = {
        audio_player = "paplay",
        max_sounds = 20,
        sound_map = {
            -- SOUND MAP DEFENITIONS HERE
        }
    }
}
}
  })
  ------------------------------------
 ------------------------------
 -------------
--Lazy с пакетами закончился
-----------------
--------------
-------------
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            runner = "pytest", -- Используйте pytest
            args = { "-v" }, -- Дополнительные аргументы для pytest
        }),
    },
})
  -- Настройка Ruff Language Server для Python
 -- Настройка Pyright
require("lspconfig").pyright.setup({
    on_attach = function(client, bufnr)
        -- Настройки для Pyright
    end,
   })

-- Настройка Ruff
require("lspconfig").ruff.setup({
    init_options = {
        settings = {
            fix = true, -- Включить автоматическое исправление ошибок
            line_length = 88, -- Максимальная длина строки
            select = { "F", "E", "W" }, -- Включить определённые категории правил
            ignore = { "F401", "F841" }, -- Исключить определённые правила
        },
    },
    on_attach = function(client, bufnr)
        -- Включение автоматического форматирования при сохранении файла
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("Format", { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})


--- Настройка nvim-cmp
local cmp = require("cmp")

cmp.setup({


    completion = {
        completeopt = "noinsert,noselect", -- Отключает автоматическое открытие меню
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Поддержка сниппетов
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Tab>"] = cmp.mapping.complete(), -- Открыть меню автодополнения
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор
        ["<S-Tab>"] = cmp.mapping.select_next_item(), -- Переключиться к следующему элементу
        ["<A-Tab>"] = cmp.mapping.select_prev_item(), -- Переключиться к предыдущему элементу
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Источник данных от LSP
        { name = "buffer" },   -- Источник данных из буфера
        { name = "path" },     -- Источник данных из путей файловой системы
    }),
})
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight-night" } },
        {

  -- automatically check for plugin updates
  checker = { enabled = true },


 }

 local dap = require("dap")
local dap_python = require("dap-python")

-- Настройка пути к Python (если вы используете виртуальное окружение)
dap_python.setup("~/.virtualenvs/debugpy/bin/python")

-- Пример конфигурации для запуска отладки
dap.adapters.python = {
    type = "executable",
    command = "~/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- Текущий файл
        pythonPath = function()
            return "~/.virtualenvs/debugpy/bin/python"
        end,
    },
}
vim.keymap.set("n", "<F5>", ":DapContinue<CR>") -- Запуск/продолжение отладки
vim.keymap.set("n", "<F10>", ":DapStepOver<CR>") -- Шаг вперёд
vim.keymap.set("n", "<F11>", ":DapStepInto<CR>") -- Шаг внутрь функции
vim.keymap.set("n", "<F12>", ":DapStepOut<CR>") -- Выход из функции
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>") -- Установка точки останова
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Клавишные комбинации
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr })
    end,
})
require("neogit").setup({
    integrations = {
        diffview = true, -- Интеграция с Diffview (опционально)
    },
})

-- Клавишная комбинация для открытия Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")



vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>") -- Запуск текущего теста
vim.keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>") -- Запуск всех тестов в файле
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>") -- Открыть/закрыть сводку тестовicons






require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false }, -- Настройки для отладки
        }),
    },
})
