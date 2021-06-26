-- Access Nvim functions
local fn = vim.fn

-- Get different completion item kinds
local kinds = require("vim.lsp.protocol").CompletionItemKind

-- Diagnistic signs
fn.sign_define("LspDiagnosticsSignError", {text = "✖"})
fn.sign_define("LspDiagnosticsSignHint", {text = ""})
fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
fn.sign_define("LspDiagnosticsSignWarning", {text = ""})




-- Icons
kinds[kinds.Class] = " Class"
kinds[kinds.Color] = " Color"
kinds[kinds.Constant] = " Constant"
kinds[kinds.Constructor] = " Constructor"
kinds[kinds.EnumMember] = " EnumMember"
kinds[kinds.Enum] = " Enum"
kinds[kinds.Event] = " Event"
kinds[kinds.Field] = " Field"
kinds[kinds.File] = " File"
kinds[kinds.Folder] = " Folder"
kinds[kinds.Function] = "𝝺 Function"
kinds[kinds.Interface] = " Interface"
kinds[kinds.Keyword] = " Keyword"
kinds[kinds.Method] = "ƒ Method"
kinds[kinds.Module] = " Module"
kinds[kinds.Operator] = " Operator"
kinds[kinds.Property] = " Property"
kinds[kinds.Reference] = " Reference"
kinds[kinds.Snippet] = "﬌ Snippet"
kinds[kinds.Struct] = " Struct"
kinds[kinds.Text] = " Text"
kinds[kinds.TypeParameter] = " TypeParameter"
kinds[kinds.Unit] = " Unit"
kinds[kinds.Value] = " Value"
kinds[kinds.Variable] = " Variable"
