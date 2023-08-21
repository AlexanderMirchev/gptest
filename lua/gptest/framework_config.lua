local framework_config = {}

local function get_framework_for_language(language)
  if framework_config == nil then
    return nil
  end

  return framework_config[language]
end

local function set_framework_config(config)
  framework_config = config
end

local f_config = {}

f_config.get_framework_for_language = get_framework_for_language
f_config.set_framework_config = set_framework_config

return f_config
