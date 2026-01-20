local constants = require( "color-skimer.constants" )
local utils = require( "color-skimer.utils" )
local windows = require( "color-skimer.windows" )
local setup = require( "color-skimer.setup" )


-- setup.setup( {} )

return {
   setup = setup.setup,
   toggle = windows.toggle_win,
}
