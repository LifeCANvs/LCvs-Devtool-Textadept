-- Copyright 2007-2009 Mitchell mitchell<att>caladbolg.net. See LICENSE.

local textadept = _G.textadept

---
-- Provides dynamic menus for Textadept.
-- This module, like ext/key_commands, should be 'require'ed last.
module('textadept.menu', package.seeall)

local t = textadept
local l = textadept.locale
local gtkmenu = textadept.gtkmenu

local SEPARATOR = 'separator'
local ID = {
  SEPARATOR = 0,
  -- File
  NEW = 101,
  OPEN = 102,
  RELOAD = 103,
  SAVE = 104,
  SAVEAS = 105,
  CLOSE = 106,
  CLOSE_ALL = 107,
  LOAD_SESSION = 108,
  SAVE_SESSION = 109,
  QUIT = 110,
  -- Edit
  UNDO = 201,
  REDO = 202,
  CUT = 203,
  COPY = 204,
  PASTE = 205,
  DELETE = 206,
  SELECT_ALL = 207,
  MATCH_BRACE = 208,
  SELECT_TO_BRACE = 209,
  COMPLETE_WORD = 210,
  DELETE_WORD = 211,
  TRANSPOSE_CHARACTERS = 212,
  SQUEEZE = 213,
  JOIN_LINES = 245,
  CONVERT_INDENTATION = 216,
  CUT_TO_LINE_END = 217,
  COPY_TO_LINE_END = 218,
  PASTE_FROM_RING = 219,
  PASTE_NEXT_FROM_RING = 220,
  PASTE_PREV_FROM_RING = 221,
  ENCLOSE_IN_HTML_TAGS = 224,
  ENCLOSE_IN_HTML_SINGLE_TAG = 225,
  ENCLOSE_IN_DOUBLE_QUOTES = 226,
  ENCLOSE_IN_SINGLE_QUOTES = 227,
  ENCLOSE_IN_PARENTHESES = 228,
  ENCLOSE_IN_BRACKETS = 229,
  ENCLOSE_IN_BRACES = 230,
  ENCLOSE_IN_CHARACTER_SEQUENCE = 231,
  GROW_SELECTION = 232,
  SELECT_IN_STRUCTURE = 233,
  SELECT_IN_HTML_TAG = 234,
  SELECT_IN_DOUBLE_QUOTE = 235,
  SELECT_IN_SINGLE_QUOTE = 236,
  SELECT_IN_PARENTHESIS = 237,
  SELECT_IN_BRACKET = 238,
  SELECT_IN_BRACE = 239,
  SELECT_IN_WORD = 240,
  SELECT_IN_LINE = 241,
  SELECT_IN_PARAGRAPH = 242,
  SELECT_IN_INDENTED_BLOCK = 243,
  SELECT_IN_SCOPE = 244,
  -- Search
  FIND = 301,
  FIND_NEXT = 302,
  FIND_PREV = 303,
  FIND_AND_REPLACE = 304,
  REPLACE = 305,
  REPLACE_ALL = 306,
  GOTO_LINE = 307,
  -- Tools
  FOCUS_COMMAND_ENTRY = 401,
  RUN = 420,
  COMPILE = 421,
  INSERT_SNIPPET = 402,
  PREVIOUS_SNIPPET_PLACEHOLDER = 403,
  CANCEL_SNIPPET = 404,
  LIST_SNIPPETS = 405,
  SHOW_SCOPE = 406,
  ADD_MULTIPLE_LINE = 407,
  ADD_MULTIPLE_LINES = 408,
  REMOVE_MULTIPLE_LINE = 409,
  REMOVE_MULTIPLE_LINES = 410,
  UPDATE_MULTIPLE_LINES = 411,
  FINISH_MULTIPLE_LINES = 412,
  TOGGLE_BOOKMARK = 416,
  CLEAR_BOOKMARKS = 417,
  GOTO_NEXT_BOOKMARK = 418,
  GOTO_PREV_BOOKMARK = 419,
  START_RECORDING_MACRO = 413,
  STOP_RECORDING_MACRO = 414,
  PLAY_MACRO = 415,
  -- Buffers
  NEXT_BUFFER = 501,
  PREV_BUFFER = 502,
  TOGGLE_VIEW_EOL = 503,
  TOGGLE_WRAP_MODE = 504,
  TOGGLE_SHOW_INDENT_GUIDES = 505,
  TOGGLE_USE_TABS = 506,
  TOGGLE_VIEW_WHITESPACE = 507,
  REFRESH_SYNTAX_HIGHLIGHTING = 508,
  -- Views
  NEXT_VIEW = 601,
  PREV_VIEW = 602,
  SPLIT_VIEW_VERTICAL = 603,
  SPLIT_VIEW_HORIZONTAL = 604,
  UNSPLIT_VIEW = 605,
  UNSPLIT_ALL_VIEWS = 606,
  GROW_VIEW = 607,
  SHRINK_VIEW = 608,
  -- Project Manager
  TOGGLE_PM_VISIBLE = 701,
  FOCUS_PM = 702,
  SHOW_PM_PROJECT = 703,
  SHOW_PM_CTAGS = 704,
  SHOW_PM_BUFFERS = 705,
  SHOW_PM_FILES = 706,
  SHOW_PM_MACROS = 707,
  SHOW_PM_MODULES = 708,
  -- Lexers
  LEXER_ACTIONSCRIPT = 801,
  LEXER_ADA = 802,
  LEXER_ANTLR = 803,
  LEXER_APDL = 804,
  LEXER_APPLESCRIPT = 805,
  LEXER_ASP = 806,
  LEXER_AWK = 807,
  LEXER_BATCH = 808,
  LEXER_BOO = 809,
  LEXER_CONTAINER = 810,
  LEXER_CPP = 811,
  LEXER_CSHARP = 812,
  LEXER_CSS = 813,
  LEXER_D = 814,
  LEXER_DIFF = 815,
  LEXER_DJANGO = 816,
  LEXER_EIFFEL = 817,
  LEXER_ERLANG = 818,
  LEXER_ERRORLIST = 819,
  LEXER_FORTH = 820,
  LEXER_FORTRAN = 821,
  LEXER_GAP = 822,
  LEXER_GETTEXT = 823,
  LEXER_GNUPLOT = 824,
  LEXER_GROOVY = 825,
  LEXER_HASKELL = 826,
  LEXER_HTML = 827,
  LEXER_IDL = 828,
  LEXER_INI = 829,
  LEXER_IO = 830,
  LEXER_JAVA = 831,
  LEXER_JAVASCRIPT = 832,
  LEXER_LATEX = 833,
  LEXER_LISP = 834,
  LEXER_LUA = 835,
  LEXER_MAKEFILE = 836,
  LEXER_MYSQL = 837,
  LEXER_OBJECTIVEC = 838,
  LEXER_OCAML = 839,
  LEXER_PASCAL = 840,
  LEXER_PERL = 841,
  LEXER_PHP = 842,
  LEXER_PIKE = 843,
  LEXER_POSTSCRIPT = 844,
  LEXER_PROPS = 845,
  LEXER_PYTHON = 846,
  LEXER_R = 847,
  LEXER_RAGEL = 848,
  LEXER_REBOL = 849,
  LEXER_REXX = 850,
  LEXER_RHTML = 851,
  LEXER_RUBY = 852,
  LEXER_SCHEME = 853,
  LEXER_SHELLSCRIPT = 854,
  LEXER_SMALLTALK = 855,
  LEXER_TCL = 856,
  LEXER_VALA = 857,
  LEXER_VERILOG = 858,
  LEXER_VHDL = 859,
  LEXER_VISUALBASIC = 860,
  LEXER_XML = 861
}


t.menubar = {
  gtkmenu {
    title = l.MENU_FILE_TITLE,
    { l.MENU_FILE_NEW, ID.NEW },
    { l.MENU_FILE_OPEN, ID.OPEN },
    { l.MENU_FILE_RELOAD, ID.RELOAD },
    { l.MENU_FILE_SAVE, ID.SAVE },
    { l.MENU_FILE_SAVEAS, ID.SAVEAS },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_FILE_CLOSE, ID.CLOSE },
    { l.MENU_FILE_CLOSE_ALL, ID.CLOSE_ALL },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_FILE_LOAD_SESSION, ID.LOAD_SESSION },
    { l.MENU_FILE_SAVE_SESSION, ID.SAVE_SESSION },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_FILE_QUIT, ID.QUIT },
  },
  gtkmenu {
    title = l.MENU_EDIT_TITLE,
    { l.MENU_EDIT_UNDO, ID.UNDO },
    { l.MENU_EDIT_REDO, ID.REDO },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_EDIT_CUT, ID.CUT },
    { l.MENU_EDIT_COPY, ID.COPY },
    { l.MENU_EDIT_PASTE, ID.PASTE },
    { l.MENU_EDIT_DELETE, ID.DELETE },
    { l.MENU_EDIT_SELECT_ALL, ID.SELECT_ALL },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_EDIT_MATCH_BRACE, ID.MATCH_BRACE },
    { l.MENU_EDIT_SELECT_TO_BRACE, ID.SELECT_TO_BRACE },
    { l.MENU_EDIT_COMPLETE_WORD, ID.COMPLETE_WORD },
    { l.MENU_EDIT_DELETE_WORD, ID.DELETE_WORD },
    { l.MENU_EDIT_TRANSPOSE_CHARACTERS, ID.TRANSPOSE_CHARACTERS },
    { l.MENU_EDIT_SQUEEZE, ID.SQUEEZE },
    { l.MENU_EDIT_JOIN_LINES, ID.JOIN_LINES },
    { l.MENU_EDIT_CONVERT_INDENTATION, ID.CONVERT_INDENTATION },
    { title = l.MENU_EDIT_KR_TITLE,
      { l.MENU_EDIT_KR_CUT_TO_LINE_END, ID.CUT_TO_LINE_END },
      { l.MENU_EDIT_KR_COPY_TO_LINE_END, ID.COPY_TO_LINE_END },
      { l.MENU_EDIT_KR_PASTE_FROM, ID.PASTE_FROM_RING },
      { l.MENU_EDIT_KR_PASTE_NEXT_FROM, ID.PASTE_NEXT_FROM_RING },
      { l.MENU_EDIT_KR_PASTE_PREV_FROM, ID.PASTE_PREV_FROM_RING },
    },
    { title = l.MENU_EDIT_SEL_TITLE,
      { title = l.MENU_EDIT_SEL_ENC_TITLE,
        { l.MENU_EDIT_SEL_ENC_HTML_TAGS, ID.ENCLOSE_IN_HTML_TAGS },
        { l.MENU_EDIT_SEL_ENC_HTML_SINGLE_TAG, ID.ENCLOSE_IN_HTML_SINGLE_TAG },
        { l.MENU_EDIT_SEL_ENC_DOUBLE_QUOTES, ID.ENCLOSE_IN_DOUBLE_QUOTES },
        { l.MENU_EDIT_SEL_ENC_SINGLE_QUOTES, ID.ENCLOSE_IN_SINGLE_QUOTES },
        { l.MENU_EDIT_SEL_ENC_PARENTHESES, ID.ENCLOSE_IN_PARENTHESES },
        { l.MENU_EDIT_SEL_ENC_BRACKETS, ID.ENCLOSE_IN_BRACKETS },
        { l.MENU_EDIT_SEL_ENC_BRACES, ID.ENCLOSE_IN_BRACES },
        { l.MENU_EDIT_SEL_ENC_CHAR_SEQ, ID.ENCLOSE_IN_CHARACTER_SEQUENCE },
      },
      { l.MENU_EDIT_SEL_GROW, ID.GROW_SELECTION },
    },
    { title = l.MENU_EDIT_SEL_IN_TITLE,
      { l.MENU_EDIT_SEL_IN_STRUCTURE, ID.SELECT_IN_STRUCTURE },
      { l.MENU_EDIT_SEL_IN_HTML_TAG, ID.SELECT_IN_HTML_TAG },
      { l.MENU_EDIT_SEL_IN_DOUBLE_QUOTE, ID.SELECT_IN_DOUBLE_QUOTE },
      { l.MENU_EDIT_SEL_IN_SINGLE_QUOTE, ID.SELECT_IN_SINGLE_QUOTE },
      { l.MENU_EDIT_SEL_IN_PARENTHESIS, ID.SELECT_IN_PARENTHESIS },
      { l.MENU_EDIT_SEL_IN_BRACKET, ID.SELECT_IN_BRACKET },
      { l.MENU_EDIT_SEL_IN_BRACE, ID.SELECT_IN_BRACE },
      { l.MENU_EDIT_SEL_IN_WORD, ID.SELECT_IN_WORD },
      { l.MENU_EDIT_SEL_IN_LINE, ID.SELECT_IN_LINE },
      { l.MENU_EDIT_SEL_IN_PARAGRAPH, ID.SELECT_IN_PARAGRAPH },
      { l.MENU_EDIT_SEL_IN_INDENTED_BLOCK, ID.SELECT_IN_INDENTED_BLOCK },
      { l.MENU_EDIT_SEL_IN_SCOPE, ID.SELECT_IN_SCOPE },
    },
  },
  gtkmenu {
    title = l.MENU_SEARCH_TITLE,
    { l.MENU_SEARCH_FIND, ID.FIND },
    { l.MENU_SEARCH_FIND_NEXT, ID.FIND_NEXT },
    { l.MENU_SEARCH_FIND_PREV, ID.FIND_PREV },
    { l.MENU_SEARCH_FIND_AND_REPLACE, ID.FIND_AND_REPLACE },
    { l.MENU_SEARCH_REPLACE, ID.REPLACE },
    { l.MENU_SEARCH_REPLACE_ALL, ID.REPLACE_ALL },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_SEARCH_GOTO_LINE, ID.GOTO_LINE },
  },
  gtkmenu {
    title = l.MENU_TOOLS_TITLE,
    { l.MENU_TOOLS_FOCUS_COMMAND_ENTRY, ID.FOCUS_COMMAND_ENTRY },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_TOOLS_RUN, ID.RUN },
    { l.MENU_TOOLS_COMPILE, ID.COMPILE },
    { SEPARATOR, ID.SEPARATOR },
    { title = l.MENU_TOOLS_SNIPPETS_TITLE,
      { l.MENU_TOOLS_SNIPPETS_INSERT, ID.INSERT_SNIPPET },
      { l.MENU_TOOLS_SNIPPETS_PREV_PLACE, ID.PREVIOUS_SNIPPET_PLACEHOLDER },
      { l.MENU_TOOLS_SNIPPETS_CANCEL, ID.CANCEL_SNIPPET },
      { l.MENU_TOOLS_SNIPPETS_LIST, ID.LIST_SNIPPETS },
      { l.MENU_TOOLS_SNIPPETS_SHOW_SCOPE, ID.SHOW_SCOPE },
    },
    { title = l.MENU_TOOLS_ML_TITLE,
      { l.MENU_TOOLS_ML_ADD, ID.ADD_MULTIPLE_LINE },
      { l.MENU_TOOLS_ML_ADD_MULTIPLE, ID.ADD_MULTIPLE_LINES },
      { l.MENU_TOOLS_ML_REMOVE, ID.REMOVE_MULTIPLE_LINE },
      { l.MENU_TOOLS_ML_REMOVE_MULTIPLE, ID.REMOVE_MULTIPLE_LINES },
      { l.MENU_TOOLS_ML_UPDATE, ID.UPDATE_MULTIPLE_LINES },
      { l.MENU_TOOLS_ML_FINISH, ID.FINISH_MULTIPLE_LINES },
    },
    { title = l.MENU_TOOLS_BM_TITLE,
      { l.MENU_TOOLS_BM_TOGGLE, ID.TOGGLE_BOOKMARK },
      { l.MENU_TOOLS_BM_CLEAR_ALL, ID.CLEAR_BOOKMARKS },
      { l.MENU_TOOLS_BM_NEXT, ID.GOTO_NEXT_BOOKMARK },
      { l.MENU_TOOLS_BM_PREV, ID.GOTO_PREV_BOOKMARK },
    },
    { title = l.MENU_TOOLS_MACROS_TITLE,
      { l.MENU_TOOLS_MACROS_START, ID.START_RECORDING_MACRO },
      { l.MENU_TOOLS_MACROS_STOP, ID.STOP_RECORDING_MACRO },
      { l.MENU_TOOLS_MACROS_PLAY, ID.PLAY_MACRO },
    },
  },
  gtkmenu {
    title = l.MENU_BUF_TITLE,
    { l.MENU_BUF_NEXT, ID.NEXT_BUFFER },
    { l.MENU_BUF_PREV, ID.PREV_BUFFER },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_BUF_TOGGLE_VIEW_EOL, ID.TOGGLE_VIEW_EOL },
    { l.MENU_BUF_TOGGLE_WRAP, ID.TOGGLE_WRAP_MODE },
    { l.MENU_BUF_TOGGLE_INDENT_GUIDES, ID.TOGGLE_SHOW_INDENT_GUIDES },
    { l.MENU_BUF_TOGGLE_TABS, ID.TOGGLE_USE_TABS },
    { l.MENU_BUF_TOGGLE_VIEW_WHITESPACE, ID.TOGGLE_VIEW_WHITESPACE },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_BUF_REFRESH, ID.REFRESH_SYNTAX_HIGHLIGHTING },
  },
  gtkmenu {
    title = l.MENU_VIEW_TITLE,
    { l.MENU_VIEW_NEXT, ID.NEXT_VIEW },
    { l.MENU_VIEW_PREV, ID.PREV_VIEW },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_VIEW_SPLIT_VERTICAL, ID.SPLIT_VIEW_VERTICAL },
    { l.MENU_VIEW_SPLIT_HORIZONTAL, ID.SPLIT_VIEW_HORIZONTAL },
    { l.MENU_VIEW_UNSPLIT, ID.UNSPLIT_VIEW },
    { l.MENU_VIEW_UNSPLIT_ALL, ID.UNSPLIT_ALL_VIEWS },
    { SEPARATOR, ID.SEPARATOR },
    { l.MENU_VIEW_GROW, ID.GROW_VIEW },
    { l.MENU_VIEW_SHRINK, ID.SHRINK_VIEW },
  },
  gtkmenu {
    title = l.MENU_PM_TITLE,
    { l.MENU_PM_TOGGLE_VISIBLE, ID.TOGGLE_PM_VISIBLE },
    { l.MENU_PM_FOCUS, ID.FOCUS_PM },
    { l.MENU_PM_BUFFERS, ID.SHOW_PM_BUFFERS },
    { l.MENU_PM_PROJECT, ID.SHOW_PM_PROJECT },
    { l.MENU_PM_FILES, ID.SHOW_PM_FILES },
    { l.MENU_PM_CTAGS, ID.SHOW_PM_CTAGS },
    { l.MENU_PM_MACROS, ID.SHOW_PM_MACROS },
    { l.MENU_PM_MODULES, ID.SHOW_PM_MODULES },
  },
  gtkmenu {
    title = l.MENU_LEX_TITLE,
    { 'actionscript', ID.LEXER_ACTIONSCRIPT },
    { 'ada', ID.LEXER_ADA },
    { 'antlr', ID.LEXER_ANTLR },
    { 'apdl', ID.LEXER_APDL },
    { 'applescript', ID.LEXER_APPLESCRIPT },
    { 'asp', ID.LEXER_ASP },
    { 'awk', ID.LEXER_AWK },
    { 'batch', ID.LEXER_BATCH },
    { 'boo', ID.LEXER_BOO },
    { 'container', ID.LEXER_CONTAINER },
    { 'cpp', ID.LEXER_CPP },
    { 'csharp', ID.LEXER_CSHARP },
    { 'css', ID.LEXER_CSS },
    { 'd', ID.LEXER_D },
    { 'diff', ID.LEXER_DIFF },
    { 'django', ID.LEXER_DJANGO },
    { 'eiffel', ID.LEXER_EIFFEL },
    { 'erlang', ID.LEXER_ERLANG },
    { 'errorlist', ID.LEXER_ERRORLIST },
    { 'forth', ID.LEXER_FORTH },
    { 'fortran', ID.LEXER_FORTRAN },
    { 'gap', ID.LEXER_GAP },
    { 'gettext', ID.LEXER_GETTEXT },
    { 'gnuplot', ID.LEXER_GNUPLOT },
    { 'groovy', ID.LEXER_GROOVY },
    { 'haskell', ID.LEXER_HASKELL },
    { 'html', ID.LEXER_HTML },
    { 'idl', ID.LEXER_IDL },
    { 'ini', ID.LEXER_INI },
    { 'io', ID.LEXER_IO },
    { 'java', ID.LEXER_JAVA },
    { 'javascript', ID.LEXER_JAVASCRIPT },
    { 'latex', ID.LEXER_LATEX },
    { 'lisp', ID.LEXER_LISP },
    { 'lua', ID.LEXER_LUA },
    { 'makefile', ID.LEXER_MAKEFILE },
    { 'mysql', ID.LEXER_MYSQL },
    { 'objective__c', ID.LEXER_OBJECTIVEC },
    { 'ocaml', ID.LEXER_OCAML },
    { 'pascal', ID.LEXER_PASCAL },
    { 'perl', ID.LEXER_PERL },
    { 'php', ID.LEXER_PHP },
    { 'pike', ID.LEXER_PIKE },
    { 'postscript', ID.LEXER_POSTSCRIPT },
    { 'props', ID.LEXER_PROPS },
    { 'python', ID.LEXER_PYTHON },
    { 'r', ID.LEXER_R },
    { 'ragel', ID.LEXER_RAGEL },
    { 'rebol', ID.LEXER_REBOL },
    { 'rexx', ID.LEXER_REXX },
    { 'rhtml', ID.LEXER_RHTML },
    { 'ruby', ID.LEXER_RUBY },
    { 'scheme', ID.LEXER_SCHEME },
    { 'shellscript', ID.LEXER_SHELLSCRIPT },
    { 'smalltalk', ID.LEXER_SMALLTALK },
    { 'tcl', ID.LEXER_TCL },
    { 'vala', ID.LEXER_VALA },
    { 'verilog', ID.LEXER_VERILOG },
    { 'vhdl', ID.LEXER_VHDL },
    { 'visualbasic', ID.LEXER_VISUALBASIC },
    { 'xml', ID.LEXER_XML },
  },
}

local b, v = 'buffer', 'view'
local m_snippets = _m.textadept.lsnippets
local m_editing = _m.textadept.editing
local m_mlines = _m.textadept.mlines
local m_bookmarks = _m.textadept.bookmarks
local m_macros = _m.textadept.macros
local m_run = _m.textadept.run

local function pm_activate(text)
  t.pm.entry_text = text
  t.pm.activate()
end
local function toggle_setting(setting)
  local state = buffer[setting]
  if type(state) == 'boolean' then
    buffer[setting] = not state
  elseif type(state) == 'number' then
    buffer[setting] = buffer[setting] == 0 and 1 or 0
  end
  t.events.update_ui() -- for updating statusbar
end
local function set_lexer_language(lexer)
  buffer:set_lexer_language(lexer)
  buffer:colourise(0, -1)
end

local actions = {
  -- File
  [ID.NEW] = { t.new_buffer },
  [ID.OPEN] = { t.io.open },
  [ID.RELOAD] = { 'reload', b },
  [ID.SAVE] = { 'save', b },
  [ID.SAVEAS] = { 'save_as', b },
  [ID.CLOSE] = { 'close', b },
  [ID.CLOSE_ALL] = { t.io.close_all },
  [ID.LOAD_SESSION] = { t.io.load_session }, -- TODO: file open dialog prompt
  [ID.SAVE_SESSION] = { t.io.save_session }, -- TODO: file save dialog prompt
  [ID.QUIT] = { t.quit },
  -- Edit
  [ID.UNDO] = { 'undo', b },
  [ID.REDO] = { 'redo', b },
  [ID.CUT] = { 'cut', b },
  [ID.COPY] = { 'copy', b },
  [ID.PASTE] = { 'paste', b },
  [ID.DELETE] = { 'clear', b },
  [ID.SELECT_ALL] = { 'select_all', b },
  [ID.MATCH_BRACE] = { m_editing.match_brace },
  [ID.SELECT_TO_BRACE] = { m_editing.match_brace, 'select' },
  [ID.COMPLETE_WORD] = { m_editing.autocomplete_word, '%w_' },
  [ID.DELETE_WORD] = { m_editing.current_word, 'delete' },
  [ID.TRANSPOSE_CHARACTERS] = { m_editing.transpose_chars },
  [ID.SQUEEZE] = { m_editing.squeeze },
  [ID.JOIN_LINES] = { m_editing.join_lines },
  [ID.CONVERT_INDENTATION] = { m_editing.convert_indentation },
  -- Edit -> Kill Ring
  [ID.CUT_TO_LINE_END] = { m_editing.smart_cutcopy },
  [ID.COPY_TO_LINE_END] = { m_editing.smart_cutcopy, 'copy' },
  [ID.PASTE_FROM_RING] = { m_editing.smart_paste },
  [ID.PASTE_NEXT_FROM_RING] = { m_editing.smart_paste, 'cycle' },
  [ID.PASTE_PREV_FROM_RING] = { m_editing.smart_paste, 'reverse' },
  -- Edit -> Selection -> Enclose in...
  [ID.ENCLOSE_IN_HTML_TAGS] = { m_editing.enclose, 'tag' },
  [ID.ENCLOSE_IN_HTML_SINGLE_TAG] = { m_editing.enclose, 'single_tag' },
  [ID.ENCLOSE_IN_DOUBLE_QUOTES] = { m_editing.enclose, 'dbl_quotes' },
  [ID.ENCLOSE_IN_SINGLE_QUOTES] = { m_editing.enclose, 'sng_quotes' },
  [ID.ENCLOSE_IN_PARENTHESES] = { m_editing.enclose, 'parens' },
  [ID.ENCLOSE_IN_BRACKETS] = { m_editing.enclose, 'brackets' },
  [ID.ENCLOSE_IN_BRACES] = { m_editing.enclose, 'braces' },
  [ID.ENCLOSE_IN_CHARACTER_SEQUENCE] = { m_editing.enclose, 'chars' },
  -- Edit -> Selection
  [ID.GROW_SELECTION] = { m_editing.grow_selection, 1 },
  -- Edit -> Select In...
  [ID.SELECT_IN_STRUCTURE] = { m_editing.select_enclosed },
  [ID.SELECT_IN_HTML_TAG] = { m_editing.select_enclosed, 'tags' },
  [ID.SELECT_IN_DOUBLE_QUOTE] = { m_editing.select_enclosed, 'dbl_quotes' },
  [ID.SELECT_IN_SINGLE_QUOTE] = { m_editing.select_enclosed, 'sng_quotes' },
  [ID.SELECT_IN_PARENTHESIS] = { m_editing.select_enclosed, 'parens' },
  [ID.SELECT_IN_BRACKET] = { m_editing.select_enclosed, 'brackets' },
  [ID.SELECT_IN_BRACE] = { m_editing.select_enclosed, 'braces' },
  [ID.SELECT_IN_WORD] = { m_editing.current_word, 'select' },
  [ID.SELECT_IN_LINE] = { m_editing.select_line },
  [ID.SELECT_IN_PARAGRAPH] = { m_editing.select_paragraph },
  [ID.SELECT_IN_INDENTED_BLOCK] = { m_editing.select_indented_block },
  [ID.SELECT_IN_SCOPE] = { m_editing.select_scope },
  -- Search
  [ID.FIND] = { t.find.focus },
  [ID.FIND_NEXT] = { t.find.call_find_next },
  [ID.FIND_PREV] = { t.find.call_find_prev },
  [ID.FIND_AND_REPLACE] = { t.find.focus },
  [ID.REPLACE] = { t.find.call_replace },
  [ID.REPLACE_ALL] = { t.find.call_replace_all },
  [ID.GOTO_LINE] = { m_editing.goto_line },
  -- Tools
  [ID.FOCUS_COMMAND_ENTRY] = { t.command_entry.focus },
  [ID.RUN] = { m_run.go },
  [ID.COMPILE] = { m_run.compile },
  -- Tools -> Snippets
  [ID.INSERT_SNIPPET] = { m_snippets.insert },
  [ID.PREVIOUS_SNIPPET_PLACEHOLDER] = { m_snippets.prev },
  [ID.CANCEL_SNIPPET] = { m_snippets.cancel_current },
  [ID.LIST_SNIPPETS] = { m_snippets.list },
  [ID.SHOW_SCOPE] = { m_snippets.show_style },
  -- Tools -> Multiple Line Editing
  [ID.ADD_MULTIPLE_LINE] = { m_mlines.add },
  [ID.ADD_MULTIPLE_LINES] = { m_mlines.add_multiple },
  [ID.REMOVE_MULTIPLE_LINE] = { m_mlines.remove },
  [ID.REMOVE_MULTIPLE_LINES] = { m_mlines.remove_multiple },
  [ID.UPDATE_MULTIPLE_LINES] = { m_mlines.update },
  [ID.FINISH_MULTIPLE_LINES] = { m_mlines.clear },
  -- Tools -> Bookmark
  [ID.TOGGLE_BOOKMARK] = { m_bookmarks.toggle },
  [ID.CLEAR_BOOKMARKS] = { m_bookmarks.clear },
  [ID.GOTO_NEXT_BOOKMARK] = { m_bookmarks.goto_next },
  [ID.GOTO_PREV_BOOKMARK] = { m_bookmarks.goto_prev },
  -- Tools -> Macros
  [ID.START_RECORDING_MACRO] = { m_macros.start_recording },
  [ID.STOP_RECORDING_MACRO] = { m_macros.stop_recording },
  [ID.PLAY_MACRO] = { m_macros.play },
  -- Buffers
  [ID.NEXT_BUFFER] = { 'goto_buffer', v, 1, false },
  [ID.PREV_BUFFER] = { 'goto_buffer', v, -1, false },
  [ID.TOGGLE_VIEW_EOL] = { toggle_setting, 'view_eol' },
  [ID.TOGGLE_WRAP_MODE] = { toggle_setting, 'wrap_mode' },
  [ID.TOGGLE_SHOW_INDENT_GUIDES] = { toggle_setting, 'indentation_guides' },
  [ID.TOGGLE_USE_TABS] = { toggle_setting, 'use_tabs' },
  [ID.TOGGLE_VIEW_WHITESPACE] = { toggle_setting, 'view_ws' },
  [ID.REFRESH_SYNTAX_HIGHLIGHTING] = { 'colourise', b, 0, -1 },
  -- Views
  [ID.NEXT_VIEW] = { t.goto_view, 1, false },
  [ID.PREV_VIEW] = { t.goto_view, -1, false },
  [ID.SPLIT_VIEW_VERTICAL] = { 'split', v },
  [ID.SPLIT_VIEW_HORIZONTAL] = { 'split', v, false },
  [ID.UNSPLIT_VIEW] = { function() view:unsplit() end },
  [ID.UNSPLIT_ALL_VIEWS] = { function() while view:unsplit() do end end },
  [ID.GROW_VIEW] = {
    function() if view.size then view.size = view.size + 10 end end
  },
  [ID.SHRINK_VIEW] = {
    function() if view.size then view.size = view.size - 10 end end
  },
  -- Project Manager
  [ID.TOGGLE_PM_VISIBLE] = { t.pm.toggle_visible },
  [ID.FOCUS_PM] = { t.pm.focus },
  [ID.SHOW_PM_PROJECT] = { pm_activate, 'project' },
  [ID.SHOW_PM_CTAGS] = { pm_activate, 'ctags' },
  [ID.SHOW_PM_BUFFERS] = { pm_activate, 'buffers' },
  [ID.SHOW_PM_FILES] = { pm_activate, not WIN32 and '/' or 'C:\\' },
  [ID.SHOW_PM_MACROS] = { pm_activate, 'macros' },
  [ID.SHOW_PM_MODULES] = { pm_activate, 'modules' },
}

-- lexers here MUST be in the same order as in the menu
local lexers = {
  'actionscript', 'ada', 'antlr', 'apdl', 'applescript', 'asp', 'awk', 'batch',
  'boo', 'container', 'cpp', 'csharp', 'css', 'd', 'diff', 'django', 'eiffel',
  'erlang', 'errorlist', 'forth', 'fortran', 'gap', 'gettext', 'gnuplot',
  'groovy', 'haskell', 'html', 'idl', 'ini', 'io', 'java', 'javascript',
  'latex', 'lisp', 'lua', 'makefile', 'mysql', 'objective__c', 'ocaml',
  'pascal', 'perl', 'php', 'pike', 'postscript', 'props', 'python', 'r',
  'ragel', 'rebol', 'rexx', 'rhtml', 'ruby', 'scheme', 'shellscript',
  'smalltalk', 'tcl', 'vala', 'verilog', 'vhdl', 'visualbasic', 'xml'
}

-- Most of this handling code comes from keys.lua.
t.events.add_handler('menu_clicked',
  function(menu_id)
    local active_table = actions[menu_id]
    if menu_id >= ID.LEXER_ACTIONSCRIPT and menu_id <= ID.LEXER_XML then
      active_table = { set_lexer_language, lexers[menu_id - 800] }
    end
    local f, args
    if active_table and #active_table > 0 then
      local func = active_table[1]
      if type(func) == 'function' then
        f, args = func, { unpack(active_table, 2) }
      elseif type(func) == 'string' then
        local object = active_table[2]
        if object == 'buffer' then
          f, args = buffer[func], { buffer, unpack(active_table, 3) }
        elseif object == 'view' then
          f, args = view[func], { view, unpack(active_table, 3) }
        end
      end
      if f and args then
        local ret, retval = pcall(f, unpack(args))
        if not ret then textadept.events.error(retval) end -- error
      else
        error(l.MENU_UNKNOWN_COMMAND..tostring(func))
      end
    end
  end)
