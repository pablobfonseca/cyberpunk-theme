local highlights = {}
local util = require('cyberpunk.util')

function highlights.setup(colors, config)
  local groups = {}

  -- Resolve float background per config.styles
  local float_bg = (config.styles.floats == "transparent") and "NONE" or colors.bg_float

  -- Base Neovim highlights
  groups = vim.tbl_deep_extend("force", groups, {
    -- Editor
    Normal = { fg = colors.fg, bg = config.transparent and "NONE" or colors.bg },
    NormalFloat = { fg = colors.fg, bg = float_bg },
    FloatBorder = { fg = colors.border },
    NormalNC = config.dim_inactive and { fg = colors.fg_dark, bg = colors.bg } or { fg = colors.fg, bg = colors.bg },

    -- Cursor and line
    Cursor = { fg = colors.bg, bg = colors.cursor },
    CursorLine = { bg = colors.cursor_line },
    CursorColumn = { bg = colors.cursor_line },
    ColorColumn = { bg = colors.cursor_line },

    -- Line numbers
    LineNr = { fg = colors.fg_gutter },
    CursorLineNr = { fg = colors.neon_cyan, style = "bold" },
    SignColumn = { fg = colors.fg_gutter, bg = colors.bg },
    FoldColumn = { fg = colors.fg_gutter, bg = colors.bg },

    -- Visual selection
    Visual = { bg = colors.bg_visual },
    VisualNOS = { bg = colors.bg_visual },

    -- Search
    Search = { fg = colors.bg, bg = colors.search },
    IncSearch = { fg = colors.bg, bg = colors.neon_orange },
    CurSearch = { fg = colors.bg, bg = colors.neon_pink },

    -- Statusline
    StatusLine = { fg = colors.fg, bg = colors.bg_statusline },
    StatusLineNC = { fg = colors.fg_dark, bg = colors.bg_dark },

    -- Tabline
    TabLine = { fg = colors.fg_dark, bg = colors.bg_dark },
    TabLineFill = { bg = colors.bg_dark },
    TabLineSel = { fg = colors.neon_cyan, bg = colors.bg },

    -- Popup menu
    Pmenu = { fg = colors.fg, bg = float_bg },
    PmenuSel = { fg = colors.bg, bg = colors.neon_cyan },
    PmenuSbar = { bg = float_bg },
    PmenuThumb = { bg = colors.fg_gutter },

    -- Messages
    ErrorMsg = { fg = colors.error },
    WarningMsg = { fg = colors.warning },
    ModeMsg = { fg = colors.neon_cyan, style = "bold" },
    MoreMsg = { fg = colors.neon_green },
    Question = { fg = colors.neon_blue },

    -- Folds
    Folded = { fg = colors.fg_dark, bg = colors.bg_dark },

    -- Diff
    DiffAdd = { bg = util.darken(colors.git_add, 0.9) },
    DiffChange = { bg = util.darken(colors.git_change, 0.9) },
    DiffDelete = { bg = util.darken(colors.git_delete, 0.9) },
    DiffText = { bg = util.darken(colors.git_change, 0.7) },

    -- Wildmenu
    WildMenu = { fg = colors.bg, bg = colors.neon_cyan },

    -- Matching brackets
    MatchParen = { fg = colors.match_paren, bg = colors.bg_dark, style = "bold" },
  })

  -- Syntax highlighting
  groups = vim.tbl_deep_extend("force", groups, {
    -- Comments
    Comment = { fg = colors.comment, style = config.styles.comments },

    -- Constants
    Constant = { fg = colors.constant },
    String = { fg = colors.string },
    Character = { fg = colors.character },
    Number = { fg = colors.number },
    Boolean = { fg = colors.boolean },
    Float = { fg = colors.float },

    -- Identifiers
    Identifier = { fg = colors.identifier, style = config.styles.variables },
    Function = { fg = colors.function_name, style = config.styles.functions },

    -- Statements
    Statement = { fg = colors.statement, style = config.styles.keywords },
    Conditional = { fg = colors.conditional, style = config.styles.keywords },
    Repeat = { fg = colors.repeat_key, style = config.styles.keywords },
    Label = { fg = colors.label },
    Operator = { fg = colors.operator },
    Keyword = { fg = colors.keyword, style = config.styles.keywords },
    Exception = { fg = colors.exception, style = config.styles.keywords },

    -- Preprocessing
    PreProc = { fg = colors.preproc },
    Include = { fg = colors.include },
    Define = { fg = colors.define },
    Macro = { fg = colors.macro },
    PreCondit = { fg = colors.preproc },

    -- Types
    Type = { fg = colors.type },
    StorageClass = { fg = colors.storage_class, style = config.styles.keywords },
    Structure = { fg = colors.structure },
    Typedef = { fg = colors.typedef },

    -- Special
    Special = { fg = colors.special },
    SpecialChar = { fg = colors.special_char },
    Tag = { fg = colors.tag },
    Delimiter = { fg = colors.delimiter },
    SpecialComment = { fg = colors.special_comment },
    Debug = { fg = colors.debug },

    -- Underlines
    Underlined = { style = "underline" },

    -- Ignored
    Ignore = { fg = colors.fg_gutter },

    -- Errors
    Error = { fg = colors.error },
    Todo = { fg = colors.bg, bg = colors.warning, style = "bold" },
  })

  -- Treesitter highlights (modern syntax highlighting)
  if config.plugins.treesitter then
    groups = vim.tbl_deep_extend("force", groups, {
      -- Literals
      ["@string"] = { fg = colors.string },
      ["@string.regex"] = { fg = colors.neon_orange },
      ["@string.escape"] = { fg = colors.neon_purple },
      ["@character"] = { fg = colors.character },
      ["@character.special"] = { fg = colors.special_char },
      ["@number"] = { fg = colors.number },
      ["@number.float"] = { fg = colors.float },
      ["@boolean"] = { fg = colors.boolean },

      -- Functions
      ["@function"] = { fg = colors.function_name, style = config.styles.functions },
      ["@function.builtin"] = { fg = colors.neon_cyan, style = config.styles.functions },
      ["@function.call"] = { fg = colors.function_name },
      ["@function.macro"] = { fg = colors.macro },
      ["@method"] = { fg = colors.function_name, style = config.styles.functions },
      ["@method.call"] = { fg = colors.function_name },
      ["@constructor"] = { fg = colors.neon_blue },

      -- Keywords
      ["@keyword"] = { fg = colors.keyword, style = config.styles.keywords },
      ["@keyword.function"] = { fg = colors.neon_pink, style = config.styles.keywords },
      ["@keyword.operator"] = { fg = colors.operator, style = config.styles.keywords },
      ["@keyword.return"] = { fg = colors.neon_pink, style = config.styles.keywords },
      ["@conditional"] = { fg = colors.conditional, style = config.styles.keywords },
      ["@repeat"] = { fg = colors.repeat_key, style = config.styles.keywords },
      ["@label"] = { fg = colors.label },
      ["@exception"] = { fg = colors.exception, style = config.styles.keywords },

      -- Operators
      ["@operator"] = { fg = colors.operator },

      -- Variables
      ["@variable"] = { fg = colors.identifier, style = config.styles.variables },
      ["@variable.builtin"] = { fg = colors.neon_purple, style = config.styles.variables },
      ["@variable.parameter"] = { fg = colors.neon_orange },
      ["@variable.member"] = { fg = colors.neon_cyan },

      -- Types
      ["@type"] = { fg = colors.type },
      ["@type.builtin"] = { fg = colors.neon_blue },
      ["@type.definition"] = { fg = colors.typedef },
      ["@attribute"] = { fg = colors.neon_purple },

      -- Identifiers
      ["@property"] = { fg = colors.neon_cyan },
      ["@field"] = { fg = colors.neon_cyan },
      ["@namespace"] = { fg = colors.neon_blue },

      -- Punctuation
      ["@punctuation.delimiter"] = { fg = colors.delimiter },
      ["@punctuation.bracket"] = { fg = colors.delimiter },
      ["@punctuation.special"] = { fg = colors.special },

      -- Comments
      ["@comment"] = { fg = colors.comment, style = config.styles.comments },
      ["@comment.documentation"] = { fg = colors.special_comment, style = config.styles.comments },
      ["@comment.error"] = { fg = colors.error },
      ["@comment.warning"] = { fg = colors.warning },
      ["@comment.todo"] = { fg = colors.warning, style = "bold" },
      ["@comment.note"] = { fg = colors.info },

      -- Markup (for markdown, etc.)
      ["@markup.heading"] = { fg = colors.neon_cyan, style = "bold" },
      ["@markup.heading.1"] = { fg = colors.neon_pink, style = "bold" },
      ["@markup.heading.2"] = { fg = colors.neon_cyan, style = "bold" },
      ["@markup.heading.3"] = { fg = colors.neon_green, style = "bold" },
      ["@markup.heading.4"] = { fg = colors.neon_purple, style = "bold" },
      ["@markup.heading.5"] = { fg = colors.neon_orange, style = "bold" },
      ["@markup.heading.6"] = { fg = colors.neon_blue, style = "bold" },
      ["@markup.emphasis"] = { style = "italic" },
      ["@markup.strong"] = { style = "bold" },
      ["@markup.strikethrough"] = { style = "strikethrough" },
      ["@markup.link"] = { fg = colors.neon_cyan, style = "underline" },
      ["@markup.link.url"] = { fg = colors.neon_blue, style = "underline" },
      ["@markup.raw"] = { fg = colors.string },
      ["@markup.raw.block"] = { fg = colors.string },

      -- Tags (for HTML, XML)
      ["@tag"] = { fg = colors.tag },
      ["@tag.attribute"] = { fg = colors.neon_orange },
      ["@tag.delimiter"] = { fg = colors.delimiter },

      -- Misc
      ["@error"] = { fg = colors.error },
      ["@warning"] = { fg = colors.warning },
      ["@danger"] = { fg = colors.error },
      ["@note"] = { fg = colors.info },
    })
  end

  -- LSP semantic tokens
  if config.plugins.lsp then
    groups = vim.tbl_deep_extend("force", groups, {
      ["@lsp.type.class"] = { fg = colors.type },
      ["@lsp.type.decorator"] = { fg = colors.neon_purple },
      ["@lsp.type.enum"] = { fg = colors.type },
      ["@lsp.type.enumMember"] = { fg = colors.constant },
      ["@lsp.type.function"] = { fg = colors.function_name },
      ["@lsp.type.interface"] = { fg = colors.type },
      ["@lsp.type.macro"] = { fg = colors.macro },
      ["@lsp.type.method"] = { fg = colors.function_name },
      ["@lsp.type.namespace"] = { fg = colors.neon_blue },
      ["@lsp.type.parameter"] = { fg = colors.neon_orange },
      ["@lsp.type.property"] = { fg = colors.neon_cyan },
      ["@lsp.type.struct"] = { fg = colors.type },
      ["@lsp.type.type"] = { fg = colors.type },
      ["@lsp.type.typeParameter"] = { fg = colors.type },
      ["@lsp.type.variable"] = { fg = colors.identifier },
    })
  end

  -- Diagnostic highlights
  groups = vim.tbl_deep_extend("force", groups, {
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticVirtualTextError = { fg = colors.error, bg = util.darken(colors.error, 0.9) },
    DiagnosticVirtualTextWarn = { fg = colors.warning, bg = util.darken(colors.warning, 0.9) },
    DiagnosticVirtualTextInfo = { fg = colors.info, bg = util.darken(colors.info, 0.9) },
    DiagnosticVirtualTextHint = { fg = colors.hint, bg = util.darken(colors.hint, 0.9) },
    DiagnosticUnderlineError = { style = "undercurl", sp = colors.error },
    DiagnosticUnderlineWarn = { style = "undercurl", sp = colors.warning },
    DiagnosticUnderlineInfo = { style = "undercurl", sp = colors.info },
    DiagnosticUnderlineHint = { style = "undercurl", sp = colors.hint },
    DiagnosticSignError = { fg = colors.error, style = "bold" },
    DiagnosticSignWarn = { fg = colors.warning, style = "bold" },
    DiagnosticSignInfo = { fg = colors.info, style = "bold" },
    DiagnosticSignHint = { fg = colors.hint, style = "bold" },
  })

  -- Load plugin-specific highlights
  local plugin_highlights = require('cyberpunk.plugins')
  groups = vim.tbl_deep_extend("force", groups, plugin_highlights.setup(colors, config))

  return groups
end

return highlights