local generate_tests = require("gptest.generate_tests")
local framework_config = require("gptest.framework_config")

local config = {}

local gptest = {}

gptest.setup = function(userConfig)
  if type(userConfig.api_key) ~= "string" then
    error("You must provide an api key")
  end

  config = userConfig
  framework_config.set_framework_config(userConfig.framework_config)
end

local function gen_test()
  generate_tests.generate_tests_for_highlighted_code(config.api_key)
end

local function copy_generated()
  local tests = generate_tests.get_generated_tests_and_close()
  vim.fn.setreg('"', tests)
end

gptest.gen_test = gen_test
gptest.copy_generated = copy_generated
return gptest
