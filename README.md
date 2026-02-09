# Color-skimer

Color-skimer is a lightweight colorscheme/theme switcher. It allow you to change your colorschemes quickly and easily. Inspired by [themery.nvim](https://github.com/zaldih/themery.nvim).

<img
    style="display: block;
           margin-left: auto;
           margin-right: auto;
           width: 85%;"
    src="https://github.com/user-attachments/assets/ce493171-aa43-4d1c-897d-745ff1cc9c5f"
    alt="color-skimer">
</img>

## TABLE OF CONTENTS

- [FEATURES](#features)
- [USAGE](#usage)
   - [How to interact with the plugin ?](#how-to-interact-with-the-plugin-)
   - [Base binds](#base-binds)
- [INSTALLATION](#installation)
   - [Lazy](#lazy)
   - [Others (untested)](#others-untested)
- [CONFIGURATION](#configuration)
   - [Default config](#default-config)
   - [Custom hooks](#custom-hooks)
- [WHY COLOR-SKIMER ?](#why-color-skimer-)
- [BONUS](#bonus)
- [CONTRIBUTING](#contributing)
- [LICENSE](#license)

## FEATURES

- **Quick Colorscheme Switching**: Ability to cycle through your colorschemes fast.
- **Persistent**: Colorscheme stays set across your sessions.
- **Live Preview**: Preview your colorschemes as you move through your list.
- **Higly Configurable**: Large amount of specific configurations options available
- **Custom Lua Hooks**: You can define Lua functions to be executed at specific instants. (see [CUSTOM HOOKS](#custom-hooks))
- **No dependencies**.

## USAGE

### How to interact with the plugin ?
With the plugin api :
```lua
local color_skimer_toggle_function = require( "color-skimer" ).toggle
vim.api.nvim_set_keymap( "n", "<leader>st", "", { callback = color_skimer_toggle_function, desc = "Search themes" } )
```

Or just use the command : ```:ColorSkimerToggle```

### Base binds
- movement:
   same way as you would for any other buffer (```j```, ```k```, ```C-U```, ```C-D```, etc...)
- select and save to memory colorscheme : ```<CR>```
- exit without saving : ```<ESC>```

## INSTALLATION

### Lazy
```lua
return {
   "megapixel-code/color-skimer.nvim",

   --- @module "color-skimer"
   --- @type color_skimer_config
   opts = {
      -- TODO: config goes here
   },
}
```

### Others (untested)
Packer :
```lua
use "megapixel-code/color-skimer.nvim"
require( "color-skimer" ).setup( {
   -- TODO: config goes here
} )
```

Vim-plug :
```lua
Plug "megapixel-code/color-skimer.nvim"
require( "color-skimer" ).setup( {
   -- TODO: config goes here
} )
```

## CONFIGURATION

### Default config
If you give a empty table or no table in setup() the plugin will act as this is your config:

```lua
--- @type color_skimer_config
{
   colorscheme = { -- < list of your colorschemes names
      -- The default options are the default vim colorschemes :
      "blue",
      "darkblue",
      "default",
      "delek",
      "desert",
      "elflord",
      "evening",
      "habamax",
      "industry",
      "koehler",
      "lunaperche",
      "morning",
      "murphy",
      "pablo",
      "peachpuff",
      "quiet",
      "retrobox",
      "ron",
      "shine",
      "slate",
      "sorbet",
      "torte",
      "unokai",
      "wildcharm",
      "zaibatsu",
      "zellner",
   },

   name_override = { -- < this will override the name displayed in the preview menu
      -- [Example]
      -- The name displayed for the "default" colorscheme will be displayed as "tluafed" in the preview menu
      -- ["default"] = "tluafed",
   },

   -- Same options as the {lhs} parameter of ':h vim.keymap.set()'
   -- NOTE: If the variable is an empty string it won't set the keymap
   --       That means you might not have a way to interact with the plugin
   keys = {               -- < Redefine some keymaps
      toggle_plugin = "", -- < Open/Close the plugin menu window, Example: I personally use "<leader>sc"
      escape = "<ESC>",   -- < Close the plugin menu window.
      save = "<CR>",      -- < Select and save a colorscheme in the menu window.
   },

   -- For more information about the pre_preview, post_preview, pre_save and post_save configurations,
   -- look at the README on the [CUSTOM HOOKS] section
   pre_preview = {
      ["*"] = function() end,
   },
   post_preview = {
      ["*"] = function() end,
   },
   pre_save = {
      ["*"] = function() end,
   },
   post_save = {
      ["*"] = function() end,
   },
}
```

### Custom hooks
Color-skimer has great hooks that can be set for all or specific colorschemes. This is the main reason I created this plugin (see [WHY COLOR-SKIMER ?](#why-color-skimer-)).

The following custom hooks are available :
```lua
pre_preview  > this will be called everytime before the colorscheme is displayed on the screen
post_preview > this will be called everytime after the colorscheme is displayed on the screen
pre_save     > this will be called everytime before saving the colorscheme to memory
post_save    > this will be called everytime after saving the colorscheme to memory
```

All custom hooks are configured in the same way.

Examples :
```lua
{
   pre_preview = {
      -- Here it would set nvim in dark mode for every colorscheme
      -- except vscode where we set it to light mode
      ["*"] = function()
         vim.o.background = "dark"
      end,
      ["vscode"] = function()
         vim.o.background = "light"
      end,
   },
   post_preview = {
      ["*"] = function()
         print( "we are previewing a colorscheme" )
      end,
      ["vague"] = function()
         print( "we are previewing the vague colorscheme" )
      end,
   },

   pre_save = {
      ["*"] = function() end,
   },
   post_save = {
      ["*"] = function()
         -- message after saving, right before closing the menu window
         print( "colorscheme set and saved !" )
      end,
   },
}
```

## WHY COLOR-SKIMER ?
Other plugins options :
- themery: https://github.com/zaldih/themery.nvim

I used themery for a long time. Whilst this plugin is great there are few reasons I wanted to create this and move away from themery :

- 1: I **need** the post_save hook to update my terminal colors after every colorscheme save.
- 2: I want to be able to have Lua function instead of text blocks that get executed.
- 3: Themery seems to go in the direction of a complete theme manager with a community repertoire. I do not have the need for this and I would rather have a lighter plugin than have that bloat built in (my opinion).
- 4: Color-skimer has (in my opinion) better/nicer configuration settings.
- 5: To have a bit of fun, this is my first plugin.

## BONUS

For the peoples who like colorschemes here are some personal favorite of mine :
```lua
colorscheme = {
   "github_dark_default",
   "vscode",
   "lackluster",
   "no-clown-fiesta-dark",
   "vague",
   "kanso-ink",
   "kanagawa-paper-ink",
   "zenbones",
   "rosebones",
   "tokyobones",
   "neobones",
   "base16-ashes",
   "base16-kanagawa-dragon",
   "base16-vulcan",
   "base16-tarot",
   "boo",
   "sunset_cloud",
   "radioactive_waste",
   "forest_stream",
   "crimson_moonlight",
   "mfd-dark",
},
```

## CONTRIBUTING
- No AI slop.
- Only submit a pull request after having a prior issue or discussion.
- Keep PRs small and focused.

## LICENSE
GPL-3
