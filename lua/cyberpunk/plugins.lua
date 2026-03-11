local plugins = {}
local util = require('cyberpunk.util')

function plugins.setup(colors, config)
  local groups = {}

  local sidebar_bg = (config.styles.sidebars == "transparent") and "NONE" or colors.bg_sidebar
  local float_bg   = (config.styles.floats   == "transparent") and "NONE" or colors.bg_float

  -- Telescope (fuzzy finder)
  if config.plugins.telescope then
    groups = vim.tbl_deep_extend("force", groups, {
      TelescopeBorder = { fg = colors.border },
      TelescopeSelectionCaret = { fg = colors.neon_pink },
      TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual },
      TelescopeMatching = { fg = colors.neon_cyan, style = "bold" },
      TelescopePromptPrefix = { fg = colors.neon_pink },
      TelescopeResultsTitle = { fg = colors.neon_cyan, style = "bold" },
      TelescopePreviewTitle = { fg = colors.neon_green, style = "bold" },
      TelescopePromptTitle = { fg = colors.neon_pink, style = "bold" },
    })
  end

  -- NvimTree (file explorer)
  if config.plugins.nvim_tree then
    groups = vim.tbl_deep_extend("force", groups, {
      NvimTreeNormal = { fg = colors.fg, bg = sidebar_bg },
      NvimTreeRootFolder = { fg = colors.neon_cyan, style = "bold" },
      NvimTreeGitDirty = { fg = colors.git_change },
      NvimTreeGitNew = { fg = colors.git_add },
      NvimTreeGitDeleted = { fg = colors.git_delete },
      NvimTreeGitStaged = { fg = colors.neon_green },
      NvimTreeGitMerge = { fg = colors.neon_orange },
      NvimTreeGitRenamed = { fg = colors.neon_purple },
      NvimTreeSymlink = { fg = colors.neon_cyan, style = "italic" },
      NvimTreeFolderName = { fg = colors.neon_blue },
      NvimTreeFolderIcon = { fg = colors.neon_blue },
      NvimTreeOpenedFolderName = { fg = colors.neon_cyan, style = "bold" },
      NvimTreeEmptyFolderName = { fg = colors.fg_dark },
      NvimTreeIndentMarker = { fg = colors.fg_gutter },
      NvimTreeImageFile = { fg = colors.neon_purple },
      NvimTreeSpecialFile = { fg = colors.neon_orange, style = "underline" },
      NvimTreeExecFile = { fg = colors.neon_green },
    })
  end

  -- Neo-tree (modern file explorer)
  if config.plugins.neo_tree then
    groups = vim.tbl_deep_extend("force", groups, {
      NeoTreeNormal = { fg = colors.fg, bg = sidebar_bg },
      NeoTreeNormalNC = { fg = colors.fg, bg = sidebar_bg },
      NeoTreeDirectoryName = { fg = colors.neon_blue },
      NeoTreeDirectoryIcon = { fg = colors.neon_blue },
      NeoTreeRootName = { fg = colors.neon_cyan, style = "bold" },
      NeoTreeFileName = { fg = colors.fg },
      NeoTreeFileIcon = { fg = colors.fg },
      NeoTreeFileNameOpened = { fg = colors.neon_cyan },
      NeoTreeIndentMarker = { fg = colors.fg_gutter },
      NeoTreeGitAdded = { fg = colors.git_add },
      NeoTreeGitConflict = { fg = colors.neon_orange },
      NeoTreeGitDeleted = { fg = colors.git_delete },
      NeoTreeGitIgnored = { fg = colors.comment },
      NeoTreeGitModified = { fg = colors.git_change },
      NeoTreeGitUnstaged = { fg = colors.neon_orange },
      NeoTreeGitUntracked = { fg = colors.git_add },
      NeoTreeGitStaged = { fg = colors.neon_green },
    })
  end

  -- BufferLine (tab-like buffer display)
  if config.plugins.bufferline then
    groups = vim.tbl_deep_extend("force", groups, {
      BufferLineIndicatorSelected = { fg = colors.neon_cyan },
      BufferLineFill = { bg = colors.bg_dark },
      BufferLineBackground = { fg = colors.fg_dark, bg = colors.bg_dark },
      BufferLineBufferSelected = { fg = colors.neon_cyan, bg = colors.bg, style = "bold" },
      BufferLineBufferVisible = { fg = colors.fg, bg = colors.bg_dark },
      BufferLineCloseButton = { fg = colors.fg_dark, bg = colors.bg_dark },
      BufferLineCloseButtonSelected = { fg = colors.neon_pink, bg = colors.bg },
      BufferLineCloseButtonVisible = { fg = colors.fg_dark, bg = colors.bg_dark },
      BufferLineModified = { fg = colors.neon_orange, bg = colors.bg_dark },
      BufferLineModifiedSelected = { fg = colors.neon_orange, bg = colors.bg },
      BufferLineModifiedVisible = { fg = colors.neon_orange, bg = colors.bg_dark },
      BufferLineSeparator = { fg = colors.bg_dark, bg = colors.bg_dark },
      BufferLineSeparatorSelected = { fg = colors.bg, bg = colors.bg_dark },
      BufferLineSeparatorVisible = { fg = colors.bg_dark, bg = colors.bg_dark },
    })
  end

  -- Lualine (statusline)
  if config.plugins.lualine then
    groups = vim.tbl_deep_extend("force", groups, {
      lualine_a_normal = { fg = colors.bg, bg = colors.neon_cyan, style = "bold" },
      lualine_b_normal = { fg = colors.fg, bg = colors.bg_statusline },
      lualine_c_normal = { fg = colors.fg_dark, bg = colors.bg_dark },
      lualine_a_insert = { fg = colors.bg, bg = colors.neon_green, style = "bold" },
      lualine_a_visual = { fg = colors.bg, bg = colors.neon_purple, style = "bold" },
      lualine_a_replace = { fg = colors.bg, bg = colors.neon_orange, style = "bold" },
      lualine_a_command = { fg = colors.bg, bg = colors.neon_pink, style = "bold" },
      lualine_a_terminal = { fg = colors.bg, bg = colors.neon_yellow, style = "bold" },
    })
  end

  -- GitSigns (git integration)
  if config.plugins.gitsigns then
    groups = vim.tbl_deep_extend("force", groups, {
      GitSignsAdd = { fg = colors.git_add },
      GitSignsChange = { fg = colors.git_change },
      GitSignsDelete = { fg = colors.git_delete },
      GitSignsCurrentLineBlame = { fg = colors.comment, style = "italic" },
      GitSignsAddInline = { bg = util.darken(colors.git_add, 0.9) },
      GitSignsDeleteInline = { bg = util.darken(colors.git_delete, 0.9) },
      GitSignsChangeInline = { bg = util.darken(colors.git_change, 0.9) },
      GitSignsAddLnInline = { bg = util.darken(colors.git_add, 0.95) },
      GitSignsChangeLnInline = { bg = util.darken(colors.git_change, 0.95) },
      GitSignsDeleteLnInline = { bg = util.darken(colors.git_delete, 0.95) },
      GitSignsDeleteVirtLnInLine = { bg = util.darken(colors.git_delete, 0.95) },
      GitSignsAddPreview = { bg = util.darken(colors.git_add, 0.8) },
      GitSignsDeletePreview = { bg = util.darken(colors.git_delete, 0.8) },
    })
  end

  -- nvim-cmp (completion)
  if config.plugins.cmp then
    groups = vim.tbl_deep_extend("force", groups, {
      CmpBorder = { fg = colors.neon_cyan },
      CmpItemAbbrDeprecated = { fg = colors.fg_dark, style = "strikethrough" },
      CmpItemAbbrMatch = { fg = colors.neon_cyan, style = "bold" },
      CmpItemAbbrMatchFuzzy = { fg = colors.neon_cyan, style = "bold" },
      CmpItemMenu = { fg = colors.comment },
      CmpItemKindText = { fg = colors.fg },
      CmpItemKindMethod = { fg = colors.function_name },
      CmpItemKindFunction = { fg = colors.function_name },
      CmpItemKindConstructor = { fg = colors.neon_blue },
      CmpItemKindField = { fg = colors.neon_cyan },
      CmpItemKindVariable = { fg = colors.identifier },
      CmpItemKindClass = { fg = colors.type },
      CmpItemKindInterface = { fg = colors.type },
      CmpItemKindModule = { fg = colors.neon_blue },
      CmpItemKindProperty = { fg = colors.neon_cyan },
      CmpItemKindUnit = { fg = colors.number },
      CmpItemKindValue = { fg = colors.constant },
      CmpItemKindEnum = { fg = colors.type },
      CmpItemKindKeyword = { fg = colors.keyword },
      CmpItemKindSnippet = { fg = colors.neon_purple },
      CmpItemKindColor = { fg = colors.special },
      CmpItemKindFile = { fg = colors.fg },
      CmpItemKindReference = { fg = colors.neon_cyan },
      CmpItemKindFolder = { fg = colors.neon_blue },
      CmpItemKindEnumMember = { fg = colors.constant },
      CmpItemKindConstant = { fg = colors.constant },
      CmpItemKindStruct = { fg = colors.type },
      CmpItemKindEvent = { fg = colors.neon_orange },
      CmpItemKindOperator = { fg = colors.operator },
      CmpItemKindTypeParameter = { fg = colors.type },
    })
  end

  -- Blink.cmp (modern completion)
  if config.plugins.blink_cmp then
    groups = vim.tbl_deep_extend("force", groups, {
      BlinkCmpMenu = { fg = colors.fg, bg = float_bg },
      BlinkCmpMenuBorder = { fg = colors.neon_cyan },
      BlinkCmpMenuSelection = { fg = colors.bg, bg = colors.neon_cyan },
      BlinkCmpLabel = { fg = colors.fg },
      BlinkCmpLabelMatch = { fg = colors.neon_cyan, style = "bold" },
      BlinkCmpLabelDescription = { fg = colors.comment },
      BlinkCmpLabelDetail = { fg = colors.fg_dark },
      BlinkCmpKind = { fg = colors.neon_purple },
      BlinkCmpSource = { fg = colors.comment },
      BlinkCmpGhostText = { fg = colors.comment, style = "italic" },
    })
  end

  -- Indent BlankLine (indentation guides)
  if config.plugins.indent_blankline then
    groups = vim.tbl_deep_extend("force", groups, {
      IblIndent = { fg = colors.fg_gutter },
      IblScope = { fg = colors.neon_cyan },
      IblWhitespace = { fg = colors.fg_gutter },
    })
  end

  -- Alpha (dashboard)
  if config.plugins.alpha then
    groups = vim.tbl_deep_extend("force", groups, {
      AlphaShortcut = { fg = colors.neon_pink, style = "bold" },
      AlphaHeader = { fg = colors.neon_cyan, style = "bold" },
      AlphaHeaderLabel = { fg = colors.neon_green },
      AlphaFooter = { fg = colors.neon_purple, style = "italic" },
      AlphaButtons = { fg = colors.neon_orange },
    })
  end

  -- Which-key (key binding hints)
  if config.plugins.which_key then
    groups = vim.tbl_deep_extend("force", groups, {
      WhichKey = { fg = colors.neon_cyan, style = "bold" },
      WhichKeyGroup = { fg = colors.neon_pink },
      WhichKeyDesc = { fg = colors.fg },
      WhichKeySeperator = { fg = colors.comment },
      WhichKeyFloat = { bg = float_bg },
      WhichKeyValue = { fg = colors.neon_purple },
    })
  end

  -- Notify (notification system)
  if config.plugins.notify then
    groups = vim.tbl_deep_extend("force", groups, {
      NotifyERRORBorder = { fg = colors.error },
      NotifyWARNBorder = { fg = colors.warning },
      NotifyINFOBorder = { fg = colors.info },
      NotifyDEBUGBorder = { fg = colors.hint },
      NotifyTRACEBorder = { fg = colors.neon_purple },
      NotifyERRORIcon = { fg = colors.error },
      NotifyWARNIcon = { fg = colors.warning },
      NotifyINFOIcon = { fg = colors.info },
      NotifyDEBUGIcon = { fg = colors.hint },
      NotifyTRACEIcon = { fg = colors.neon_purple },
      NotifyERRORTitle = { fg = colors.error, style = "bold" },
      NotifyWARNTitle = { fg = colors.warning, style = "bold" },
      NotifyINFOTitle = { fg = colors.info, style = "bold" },
      NotifyDEBUGTitle = { fg = colors.hint, style = "bold" },
      NotifyTRACETitle = { fg = colors.neon_purple, style = "bold" },
    })
  end

  -- Noice (UI replacement)
  if config.plugins.noice then
    groups = vim.tbl_deep_extend("force", groups, {
      NoicePopup = { bg = float_bg },
      NoicePopupBorder = { fg = colors.border },
      NoiceCmdlinePopup = { bg = float_bg },
      NoiceCmdlinePopupBorder = { fg = colors.neon_cyan },
      NoiceCmdlineIcon = { fg = colors.neon_pink },
      NoiceConfirm = { bg = float_bg },
      NoiceConfirmBorder = { fg = colors.neon_green },
    })
  end

  -- Flash (enhanced f/t motions)
  if config.plugins.flash then
    groups = vim.tbl_deep_extend("force", groups, {
      FlashBackdrop = { fg = colors.comment },
      FlashMatch = { fg = colors.bg, bg = colors.neon_cyan, style = "bold" },
      FlashCurrent = { fg = colors.bg, bg = colors.neon_pink, style = "bold" },
      FlashLabel = { fg = colors.bg, bg = colors.neon_orange, style = "bold" },
      FlashPrompt = { bg = float_bg },
      FlashPromptIcon = { fg = colors.neon_cyan },
      FlashCursor = { fg = colors.bg, bg = colors.cursor },
    })
  end

  -- Leap (motion plugin)
  if config.plugins.leap then
    groups = vim.tbl_deep_extend("force", groups, {
      LeapMatch = { fg = colors.bg, bg = colors.neon_cyan, style = "bold" },
      LeapLabelPrimary = { fg = colors.bg, bg = colors.neon_pink, style = "bold" },
      LeapLabelSecondary = { fg = colors.bg, bg = colors.neon_green, style = "bold" },
      LeapBackdrop = { fg = colors.comment },
    })
  end

  -- ToggleTerm (terminal integration)
  if config.plugins.toggleterm then
    groups = vim.tbl_deep_extend("force", groups, {
      ToggleTerm1FloatBorder = { fg = colors.neon_cyan },
      ToggleTerm2FloatBorder = { fg = colors.neon_pink },
      ToggleTerm3FloatBorder = { fg = colors.neon_green },
      ToggleTerm4FloatBorder = { fg = colors.neon_purple },
    })
  end

  -- Oil.nvim (file manager)
  if config.plugins.oil then
    groups = vim.tbl_deep_extend("force", groups, {
      OilDir = { fg = colors.neon_blue, style = "bold" },
      OilFile = { fg = colors.fg },
      OilLink = { fg = colors.neon_cyan, style = "italic" },
      OilCopy = { fg = colors.neon_green },
      OilMove = { fg = colors.neon_orange },
      OilChange = { fg = colors.git_change },
      OilCreate = { fg = colors.git_add },
      OilDelete = { fg = colors.git_delete },
    })
  end

  return groups
end

return plugins