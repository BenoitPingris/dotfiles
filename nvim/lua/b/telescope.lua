local actions = require'telescope.actions'

require"telescope".setup{
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close
            }
        }
    },
    extensions = {
        fzf = {
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

require"telescope".load_extension("fzf")
