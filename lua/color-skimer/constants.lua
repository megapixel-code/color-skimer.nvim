PLUGIN_NAME = "color-skimer"
DEFAULT_CONFIG = {
   colorscheme = {
      -- default vim themes
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

   name_override = {},

   pre_function = {
      ["*"] = function() end,
   },
   post_function = {
      ["*"] = function() end,
   },

   pre_callback = {
      ["*"] = function() end,
   },
   post_callback = {
      ["*"] = function() end,
   },
}
INTERFACE = {
   buf_id = nil,
   win_id = nil,
}
COLORSCHEME_PARAMS = {}



return {
   PLUGIN_NAME = PLUGIN_NAME,
   DEFAULT_CONFIG = DEFAULT_CONFIG,
   INTERFACE = INTERFACE,
   COLORSCHEME_PARAMS = COLORSCHEME_PARAMS,
}
