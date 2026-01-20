local constants = require( "color-skimer.constants" )
local utils = require( "color-skimer.utils" )
local windows = require( "color-skimer.windows" )

--- function that setup the tables to be read by the rest of the program
--- tables will be set like so:
--- result = {
---    {
---      name = "...",
---      colorscheme = "...",
---      pre_function = function() ... end
---      post_function = function() ... end
---      pre_callback = function() ... end
---      post_callback = function() ... end
---    }
---    ... for every colorscheme
--- }
--- @param options_table table
--- @return table
local function get_colorscheme_params( options_table )
   local default = constants.DEFAULT_CONFIG

   local result = {}

   local name
   local pre_function
   local post_function
   local pre_callback
   local post_callback


   if options_table.colorscheme == nil then
      options_table.colorscheme = default.colorscheme
   end
   if options_table.name_override == nil then
      options_table.name_override = default.name_override
   end
   if options_table.pre_function == nil then
      options_table.pre_function = default.pre_function
   end
   if options_table.post_function == nil then
      options_table.post_function = default.post_function
   end
   if options_table.pre_callback == nil then
      options_table.pre_callback = default.pre_callback
   end
   if options_table.post_callback == nil then
      options_table.post_callback = default.post_callback
   end


   for _, colorscheme in ipairs( options_table.colorscheme ) do
      if options_table.name_override[colorscheme] ~= nil then
         name = options_table.name_override[colorscheme]
      else
         name = colorscheme
      end

      if options_table.pre_function[colorscheme] ~= nil then
         pre_function = options_table.pre_function[colorscheme]
      elseif options_table.pre_function["*"] ~= nil then
         pre_function = options_table.pre_function["*"]
      else
         pre_function = default.pre_function["*"]
      end

      if options_table.post_function[colorscheme] ~= nil then
         post_function = options_table.post_function[colorscheme]
      elseif options_table.post_function["*"] ~= nil then
         post_function = options_table.post_function["*"]
      else
         post_function = default.post_function["*"]
      end

      if options_table.pre_callback[colorscheme] ~= nil then
         pre_callback = options_table.pre_callback[colorscheme]
      elseif options_table.pre_callback["*"] ~= nil then
         pre_callback = options_table.pre_callback["*"]
      else
         pre_callback = default.pre_callback["*"]
      end

      if options_table.post_callback[colorscheme] ~= nil then
         post_callback = options_table.post_callback[colorscheme]
      elseif options_table.post_callback["*"] ~= nil then
         post_callback = options_table.post_callback["*"]
      else
         post_callback = default.post_callback["*"]
      end

      vim.list_extend( result, {
         {
            colorscheme = colorscheme,
            name = name,
            pre_function = pre_function,
            post_function = post_function,
            pre_callback = pre_callback,
            post_callback = post_callback,
         },
      } )
   end
   return result
end

local function setup( opts )
   constants.COLORSHCEME_PARAMS = get_colorscheme_params( opts )

   utils.retrieve_last_colorscheme()

   vim.api.nvim_create_user_command( "ColorSkimerToggle", windows.toggle_win,
                                     { desc = "toggle color-skimer plugin" } )
end

return {
   setup = setup,
}
