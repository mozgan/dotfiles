-- find more here: https://www.nerdfonts.com/cheat-sheet
vim.g.use_nerd_icons = false

return {
  kind = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
    Specifier = " ",
    Statement = "",
    Recovery = " ",
    TranslationUnit = " ",
    PackExpansion = " "
  },
  type = {
    Array = " ",
    Number = " ",
    String = " ",
    Boolean = " ",
    Object = " ",
    Template = " "
  },
  documents = {
    File = "",
    Files = "",
    Folder = "",
    OpenFolder = "",
    EmptyFolder = "",
    EmptyOpenFolder = "",
    Unknown = "",
    Symlink = "",
    FolderSymlink = "",
    Modified = '●',
    SymlinkArrow = ' ➛ ',
    Closed = '',
    Open = '',
  },
  git = {
    Add = " ",
    Mod = " ",
    Remove = " ",
    Untrack = " ",
    Rename = " ",
    Diff = " ",
    Repo = " ",
    Branch = " ",
    Unmerged = " ",
    Ignored = '◌',
  },
  ui = {
    Lock              = "",
    TinyCircle        = "",
    Circle            = "",
    BigCircle         = "",
    BigUnfilledCircle = "",
    CircleWithGap     = "",
    LogPoint          = "",
    Close             = "",
    NewFile           = "",
    Search            = "",
    Lightbulb         = "",
    Project           = "",
    Dashboard         = "",
    History           = "",
    Comment           = "",
    Bug               = "",
    Code              = "",
    Telescope         = " ",
    Gear              = "",
    Package           = "",
    List              = "",
    SignIn            = "",
    Check             = "",
    Fire              = " ",
    Note              = "",
    BookMark          = "",
    Pencil            = " ",
    ChevronRight = "",
    -- ChevronRight      = ">",
    Table             = "",
    Calendar          = "",
    Line              = "▊",
    Evil              = "",
    Debug             = "",
    Run               = "",
    VirtualPrefix     = "",
    Next              = "",
    Previous          = ""
  },
  diagnostics = {
    Error = " ",
    Warning = " ",
    Information = " ",
    Question = " ",
    Hint = " ",
  },
  misc = {
    Robot = "ﮧ ",
    Squirrel = "  ",
    Tag = " ",
  },
}