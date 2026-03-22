local init = require("init")

init.actions[options.RESET_1] = function() return misc.try_lock(options.RESET_1, 1, 1) end
init.actions[options.RESET_2] = function() return misc.try_lock(options.RESET_2, 2, 1) end
init.actions[options.RESET_3] = function() return misc.try_lock(options.RESET_3, 3, 1) end

return init