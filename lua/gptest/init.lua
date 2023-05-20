-- require('gptest.request')

local function test()
  local selectedText = require('gptest.select').get_selected_text()
  print(selectedText)

end

local gptest = {}
gptest.test = test
return gptest
