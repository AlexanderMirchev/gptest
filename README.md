# gptest.nvim

Introducing gptest.nvim: Supercharge your plugin development with our
groundbreaking NVim plugin that seamlessly integrates the power of
ChatGPT 3.5 Turbo into your unit testing process. With our innovative
plugin, you can now harness the capabilities of state-of-the-art language
AI to automatically generate comprehensive unit tests. Say goodbye to
repetitive testing tasks and hello to accelerated development, as you unlock
a new era of efficiency and accuracy in ensuring the robustness of your code.

## Getting started

- using packer:

      use({
        "AlexanderMirchev/gptest.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
      })

## Setup structure

The setup requires a valid [OpenAI key](https://platform.openai.com/account/api-keys), which
is to be used for the code completion. Also framwork customizations are possible, using the
framework_config property to set the default testing framework based on filetype (e.g setting vitest
as the default framework whenever generating tests for a .ts file). Not specifying will just
default to whatever the completion model deems most popular or adequate. Here is how you can setup
the plugin (should be required in your configuration's init.lua):

    local gptest = require("gptest")

    gptest.setup({
      api_key = <your-api-key>, -- reqiured
      framework_config = { ["typescript"] = "vitest" }, -- optional
    })

## Shortcuts

Using the plugin would require only 2 commands - gen_tests, which accepts selection and
prompts a window for editing the generated tests, and copy_generated, which closes the
window and puts the generated tests into your clipboard. Here are suggested keymaps:

    vim.keymap.set("v", "<leader>gt", "<cmd>lua require('gptest').gen_test()<cr>")
    vim.keymap.set("n", "<leader>cg", "<cmd>lua require('gptest').copy_generated()<cr>")

## Contributions

All contributions are welcome! Just open a pull request.
