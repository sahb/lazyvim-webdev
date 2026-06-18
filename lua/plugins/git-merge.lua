-- lua/plugins/git-merge.lua
-- Merge-conflict tooling for LazyVim: a rich 3-way merge view plus
-- quick inline conflict resolution. Loaded automatically by LazyVim
-- because it lives under lua/plugins/.

return {
  -- diffview.nvim: full-screen diff browser and 3-way merge tool.
  -- Best for reviewing the whole conflict (OURS | BASE | THEIRS) side by side.
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    keys = {
      -- Open the diff/merge view (run this while a merge has conflicts)
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open (merge/diff)" },
      -- Close the diff/merge view
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
      -- Inspect the commit history of the current file
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history" },
    },
    opts = {
      enhanced_diff_hl = true, -- stronger, easier-to-read diff highlighting
      view = {
        -- Show OURS, BASE and THEIRS together while resolving a conflict
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true, -- silence LSP noise during the merge
        },
      },
    },
  },

  -- git-conflict.nvim: highlights conflict markers and gives one-key
  -- resolution. Best for quickly resolving conflicts directly in the buffer.
  {
    "akinsho/git-conflict.nvim",
    version = "*", -- track the latest tagged release
    event = "BufReadPre", -- load early so conflicts are detected on file open
    opts = {
      default_mappings = false, -- define our own keymaps to avoid clashes
      disable_diagnostics = false,
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
    keys = {
      -- Keep the local (current branch) side of the conflict
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Conflict: choose ours" },
      -- Keep the incoming (merged branch) side of the conflict
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Conflict: choose theirs" },
      -- Keep both sides
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Conflict: choose both" },
      -- Discard both sides
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Conflict: choose none" },
      -- Jump between conflicts in the current buffer
      { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
      { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous conflict" },
    },
  },
}
