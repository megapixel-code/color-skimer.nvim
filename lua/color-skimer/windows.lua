local constants = require( "color-skimer.constants" )
local utils = require( "color-skimer.utils" )

-- NOTE: this file is partly inspired by the themery plugin :
--       https://github.com/zaldih/themery.nvim/

--- @class win_shape
--- @field width integer width of the window
--- @field height integer height of the window
--- @field col integer north-west column coordinate of the window
--- @field row integer north-west row coordinate of the window

--- Returns a table with the coordinates and size of the window
--- @return win_shape
local function get_win_shape()
   local editor_columns = vim.api.nvim_get_option_value( "columns", {} )
   local editor_rows = vim.api.nvim_get_option_value( "lines", {} )
   local width = 40
   local height = 15

   --- @type win_shape
   local result = {
      width = width - 2,
      height = height - 2,
      col = (editor_columns / 2) - (width / 2),
      row = (editor_rows / 2) - (height / 2),
   }

   return result
end

--- Function to close the window, does nothing if no window is open
local function close_win()
   if constants.INTERFACE.win_id == nil then
      return
   end

   vim.api.nvim_win_close( constants.INTERFACE.win_id, true )
   constants.INTERFACE = {
      buf_id = nil,
      win_id = nil,
   }
end

--- Function that setup the options and autocmds of the menu window
local function setup_win_config()
   -- buf options
   vim.api.nvim_set_option_value( "filetype",   constants.PLUGIN_NAME, { buf = constants.INTERFACE.buf_id } )
   vim.api.nvim_set_option_value( "modifiable", false,                 { buf = constants.INTERFACE.buf_id } )

   -- win options
   vim.api.nvim_set_option_value( "cursorline", true, { win = constants.INTERFACE.win_id } )
   vim.api.nvim_set_option_value( "scrolloff",  4,    { win = constants.INTERFACE.win_id } )

   -- autocmds
   vim.api.nvim_create_autocmd( "CursorMoved", {
      group = vim.api.nvim_create_augroup( constants.PLUGIN_NAME .. "-WINCONFIG", { clear = true } ),
      buffer = constants.INTERFACE.buf_id,
      callback = function()
         utils.cursor_moved()
      end,
   } )

   if constants.COLORSCHEME_PARAMS.keys.save ~= "" then
      vim.api.nvim_buf_set_keymap( constants.INTERFACE.buf_id, "n", constants.COLORSCHEME_PARAMS.keys.save, "", {
         callback = function()
            local line = vim.api.nvim_win_get_cursor( constants.INTERFACE.win_id )[1]
            utils.save_colorscheme( line )
            close_win()
         end,
      } )
   end
end

--- Function that setup the future closing of the window and the buffer with autocmds/keymaps
local function setup_win_closing()
   vim.api.nvim_set_option_value( "bufhidden", "wipe", { buf = constants.INTERFACE.buf_id } )

   vim.api.nvim_create_autocmd( { "WinLeave", "BufLeave" }, {
      group = vim.api.nvim_create_augroup( constants.PLUGIN_NAME .. "-WINCLOSING", { clear = true } ),
      buffer = constants.INTERFACE.buf_id,
      callback = function()
         close_win()
         utils.retrieve_last_colorscheme()
      end,
      once = true,
   } )

   if constants.COLORSCHEME_PARAMS.keys.escape ~= "" then
      vim.api.nvim_buf_set_keymap( constants.INTERFACE.buf_id, "n", constants.COLORSCHEME_PARAMS.keys.escape, "", {
         callback = function()
            vim.api.nvim_buf_del_keymap( constants.INTERFACE.buf_id, "n", constants.COLORSCHEME_PARAMS.keys.escape )
            close_win()
         end,
      } )
   end
end

--- Function that will open/close the menu window
local function toggle_win()
   if constants.INTERFACE.win_id ~= nil then
      close_win()
      return
   end
   if constants.COLORSCHEME_PARAMS[1] == nil then
      -- no params, shouldn't happen ?
      print( "ERROR: no options are available, setup() function has not been run" )
      print( "       if you are using lazy, please make sure you are using either 'config' OR 'opts' but not both" )
      return
   end

   local coords = get_win_shape()

   -- TODO: feature to override thoses args
   --- @type vim.api.keyset.win_config
   local opts = {
      style = "minimal",
      relative = "editor",
      border = "single",
      width = coords.width,
      height = coords.height,
      row = coords.row,
      col = coords.col,
      title = " Color-Skimer ",
      title_pos = "center",
   }

   local buf_id = vim.api.nvim_create_buf( false, true )
   local win_id = vim.api.nvim_open_win( buf_id, true, opts )

   constants.INTERFACE = {
      buf_id = buf_id,
      win_id = win_id,
   }

   setup_win_closing()
   setup_win_config()

   utils.write_to_buf()

   -- place the cursor in the right starting position
   local row = utils.get_colorscheme_id_from_memory()
   vim.api.nvim_win_set_cursor( constants.INTERFACE.win_id, { row, 0 } )
end

return {
   toggle_win = toggle_win,
}
