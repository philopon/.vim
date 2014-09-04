syn clear
syn case match
setlocal iskeyword+=' iskeyword+=# iskeyword-=.

let s:opSymbol         = '[!#$%&⋆*+./<=>?@\\^|\-~:]'
let s:opSymbol_exColon = '[!#$%&⋆*+./<=>?@\\^|\-~]'
let s:end_region_skip  = '\v%(%(^%(\s*|--.*|\{-#@!.*)\n)+|^)'

let s:varid   = "[a-z_][A-Za-z0-9'_#]*"
let s:conid   = "[A-Z][A-Za-z0-9'_#]*"
let s:varsym  = s:opSymbol_exColon . s:opSymbol . "*"
let s:consym  = ':' . s:opSymbol . '*'
let s:qualify = '%(' . s:conid . '\.)*'
let s:modid   = s:qualify . s:conid

syn match hsError '\S\+'
hi def link hsError Error

"" Value {{{
"" Symbol/Id {{{
execute 'syn match hsVarId   "\<' . s:varid  . '\>" contained'
execute 'syn match hsConId   "\<' . s:conid  . '\>" contained'
execute 'syn match hsVarSym  "'   . s:varsym . '"   contained'
execute 'syn match hsConSym  "'   . s:consym . '"   contained'

let s:qualCommon = ' contained contains=hsQualify'
execute 'syn match hsInfixQVarId "\v`' . s:qualify . s:varid . '`"' . s:qualCommon
execute 'syn match hsInfixQConId "\v`' . s:qualify . s:conid . '`"' . s:qualCommon

execute 'syn match hsQVarId  "\v<' . s:qualify . s:varid  . '>"' . s:qualCommon
execute 'syn match hsQConId  "\v<' . s:qualify . s:conid  . '>"' . s:qualCommon
execute 'syn match hsQVarSym "\v'  . s:qualify . s:varsym .  '"' . s:qualCommon
execute 'syn match hsQConSym "\v'  . s:qualify . s:consym .  '"' . s:qualCommon
execute 'syn match hsQualify "\v<' . s:qualify . '" contained'

hi def link hsConId  Type
hi def link hsVarId  NONE
hi def link hsVarSym Operator
hi def link hsConSym Type

hi def link hsInfixQVarId Operator
hi def link hsInfixQConId Operator

hi def link hsQConId  Type
hi def link hsQVarId  NONE
hi def link hsQVarSym Operator
hi def link hsQConSym Type
hi hsQualify ctermfg=darkgray
""" Symbol/Id }}}

syn cluster hsQSym   contains=hsQVarSym,hsQConSym
syn cluster hsQId    contains=hsQVarId,hsQConId
syn cluster hsSym    contains=hsVarSym,hsConSym
syn cluster hsId     contains=hsVarId,hsConId
syn cluster hsInfix  contains=@hsSym,hsInfixQVarId,hsInfixQConId
syn cluster hsQIdSym contains=@hsQSym,@hsQId

syn cluster hsType
      \ contains=hsQConId,hsQConSym,hsVarId,hsTypeReserved,hsTypeForall,hsTypeBang,hsStringLiteral,hsIntegralLiteral

syn match hsTypeReserved "\v%(::|[\-=]\>|[\[\](){}:',|])" contained
syn match hsTypeBang     "!" contained
syn region hsTypeForall matchgroup=Keyword start="\<forall\>"
      \ matchgroup=hsTypeReserved end="\." contained contains=hsVarId

syn sync match hsForallSync grouphere hsTypeForall "\<forall\>"

hi hsTypeBang ctermfg=cyan
hi def link hsTypeReserved Special

syn cluster hsValue
      \ contains=@hsType,hsQVarId,hsQVarSym,hsValueWild,hsInfixQVarId,
      \ hsInfixQConId,@hsValuePragma,@hsLiteral,hsValueKeyword
syn match hsValueWild "[a-za-z0-9'_#]\@<!_[A-Za-z0-9'_#]\@!" contained
syn keyword hsValueKeyword do where let in if then else case of contained
hi def hsValueWild ctermfg=gray
hi def link hsValueKeyword Keyword

"" Literal {{{
syn cluster hsLiteral contains=hsStringLiteral,hsCharLiteral,hsIntegralLiteral,hsFloatingLiteral

syn match hsDecimalLiteral contained '[0-9]\+'
hi def link hsDecimalLiteral Number

syn region hsStringLiteral oneline contained
      \ matchgroup=hsStringQuote start='"' end='"' skip='\\"'

hi def link hsStringLiteral String
hi def link hsStringQuote   Special

let s:single_char_escape = '\\[0abfnrtv\"&''\\]'
let s:ascii_control_code = '\\%(NUL|SOH|STX|ETX|EOT|ENQ|ACK|BEL|BS|HT|LF|VT|FF|CR|'.
      \ 'SO|SI|DLE|DC1|DC2|DC3|DC4|NAK|SYN|ETB|CAN|EM|SUB|ESC|FS|GS|RS|US|SP|DEL)'
let s:control_with_char  = '\\\^[@A-Z\[\\\]^_]'
let s:numeric_escape10   = '\\\d+'
let s:numeric_escape8    = '\\o\o+'
let s:numeric_escape16   = '\\x\x+'

exe 'syn match hsCharLiteral /\v''%([^\\]|'.s:single_char_escape.
      \ '|'. s:ascii_control_code .
      \ '|'. s:control_with_char .
      \ '|'. s:numeric_escape10 .
      \ '|'. s:numeric_escape8  .
      \ '|'. s:numeric_escape16 .
      \ ')''/ contained'
hi def link hsCharLiteral Character

syn match hsIntegralLiteral "\v<%(\d+|0x\x+|0o\o+)>" contained
hi link hsIntegralLiteral Number

syn match hsFloatingLiteral "\v<\d+\.\d+%([eE]-?\d+)?>" contained
hi link hsFloatingLiteral Float

" integer, float
"" Literal }}}

"" Value }}}

"" Comment -> Pragma {{{
syn cluster hsComment contains=hsLineComment,hsBlockComment
syn region  hsBlockComment start=/{-#\@!/ end=/#\@<!-}/ contains=hsBlockComment
execute 'syn match hsLineComment ''\v--+' . s:opSymbol . '@!.*$'''

syn sync match hsBlockCommentSync grouphere  hsBlockComment "{-#\@!"
syn sync match hsBlockCommentSync groupthere hsBlockComment "#\@<!-}"

hi def link hsBlockComment Comment
hi def link hsLineComment  Comment
"" }}}

"" TODO: quasi quote

"" TODO: pragma:
"" WARNING,DEPRECATED
"" RULES
"" SPECIALIZE
"" UNPACK
"" SCC
"" LINE
"" INLINE, INLINABLE
"" ANN http://www.kotha.net/ghcguide_ja/7.6.2/extending-ghc.html

"" Pragma {{{
"" LANGUAGE {{{
syn match  hsHeaderPragma  "LANGUAGE\>" contained nextgroup=hsLANGUAGEPragma,hsError skipwhite skipempty
let s:xFlags = '\v<%('
for line in readfile(expand('<sfile>:p:h:h') . '/listPragma')
  let s:xFlags = s:xFlags . line . '|No' . line . '|'
endfor
exe "syn match  hsLANGUAGEPragma '".s:xFlags[:-2].")' contained nextgroup=hsPragmaEnd,hsLANGUAGEPragmaSplitter,hsError skipwhite skipempty"
syn match hsLANGUAGEPragmaSplitter "," contained nextgroup=hsLANGUAGEPragma,hsError skipwhite skipempty

hi default link hsLANGUAGEPragma Identifier
hi default link hsLANGUAGEPragmaSplitter hsPragmaBrace
"" LANGUAGE }}}

"" OPTIONS_GHC {{{
syn match  hsHeaderPragma "OPTIONS_GHC\>" contained nextgroup=hsOPTIONS_GHCPragma skipwhite skipempty
syn match  hsOPTIONS_GHCPragma "[^#[:space:]]\+" contained nextgroup=hsOPTIONS_GHCPragma,hsPragmaEnd skipwhite skipempty"

hi default link hsOPTIONS_GHCPragma NONE
"" OPTIONS_GHC }}}

"" INCLUDE {{{
syn match  hsHeaderPragma "\vINCLUDE>" contained nextgroup=hsINCLUDEPragma skipwhite skipempty
syn match  hsINCLUDEPragma "[^#[:space:]]\+" contained nextgroup=hsINCLUDEPragma,hsPragmaEnd skipwhite skipempty"

hi default link hsINCLUDEPragma NONE
"" INCLUDE }}}

syn match hsHeaderPragmaStart '^{-#' nextgroup=hsHeaderPragma,hsError skipwhite skipempty contained
syn match hsPragmaEnd '#-}' contained

hi def link hsHeaderPragma      Keyword
hi def link hsHeaderPragmaStart hsPragmaBrace
hi def link hsPragmaEnd         hsPragmaBrace
hi def link hsPragmaBrace       Define
"" Pragma }}}

"" header region -> import {{{
execute 'syn region  hsHeader start=/\%^/ end=/'.s:end_region_skip.
      \ '%(\{-|--|\s*$)@!/me=s-1 contains=@hsGlobal,hsHeaderPragmaStart fold'
"" }}}

" TODO: function
"" function/type signature {{{
exe 'syn region hsTypeSignature'
      \ 'start="\v^('.s:varid.'|\('.s:varsym.'\))(\s*|\_s\s+)::"'
      \ 'end="'.s:end_region_skip.'\S"me=s-1 contains=@hsType,hsTypeSignatureId,hsTypeSignatureSym'

exe 'syn match hsTypeSignatureId  "^'. s:varid.  '" contained'
exe 'syn match hsTypeSignatureSym "^('.s:varsym.')" contained'
hi def link hsTypeSignatureId  Type
hi def link hsTypeSignatureSym Operator

exe 'syn region hsFunctionPrefix fold'
      \ 'start="\v^\z(' . s:varid . '|\(' . s:varsym '\))'.
      \ '%(%('.s:varid.'|'.s:varsym.'|'.s:qualify.s:conid.'|'.s:qualify.s:consym.'|[(){}=,])(\s*|\_s\s+))*\s*\=[>]@!"'
      \ 'skip="\v^(#|\z1)"'
      \ 'end="'.s:end_region_skip.'\S"me=s-1 contains=@hsGlobal,@hsValue'
"" function/type signature }}}

"" module {{{
syn match  hsModulePragmaStart "\v%(^\s+|^@<!)\{-#" contained nextgroup=hsModulePragma,hsError skipwhite skipempty
syn match  hsModulePragma "\v%(WARNING|DEPRECATED)>" contained nextgroup=hsModulePragmaMessage,hsError skipwhite skipempty
syn region hsModulePragmaMessage start='"' end='"' skip='\\"' contained nextgroup=hsPragmaEnd,hsError skipwhite skipempty oneline

hi default link hsModulePragmaStart hsPragmaBrace
hi default link hsModulePragma      Keyword
hi default link hsModulePragmaMessage String

syn region hsModuleDecl matchgroup=Keyword start='^module\>' end='where'
      \ contains=@hsGlobal,hsModuleName,hsModuleExportList,hsModulePragmaStart fold
syn sync match hsModuleDeclSync grouphere hsModuleDecl '^module\>'

exe 'syn match  hsModuleName "'.s:modid.'" contained'
syn region hsModuleExportList contained
      \ matchgroup=hsModuleExportListParen  start='(' end=')'
      \ contains=@hsQIdSym,@hsGlobal,
      \          hsModuleExportElems,hsModuleExportSplitter,hsModuleExportModule
syn region hsModuleExportElems contained
      \ matchgroup=hsModuleExportElemsParen start='(' end=')'
      \ contains=@hsQIdSym,@hsGlobal,
      \ hsModuleExportSplitter,hsModuleExportConSym,hsModuleExportAll
syn region hsModuleExportConSym contained contains=@hsQSym,@hsGlobal
      \ matchgroup=hsModuleExportElemsParen start='(' end=')'

syn match  hsModuleExportModule "\<module\>\s*\S\+"
      \ contained contains=hsModuleExportModuleKeyword

syn match   hsModuleExportSplitter ","    contained
syn match   hsModuleExportAll      "\.\." contained
syn keyword hsModuleExportModuleKeyword module contained

hi def link hsModuleExportListParen  Special
hi def link hsModuleExportElemsParen Special
hi def link hsModuleExportSplitter   Special
hi def link hsModuleExportAll        Special
hi def link hsModuleExportModuleKeyword Keyword
"" }}}

"" CPP {{{
syn cluster hsCPP contains=hsCPPDefine,hsCPPConditional
syn region  hsCPPConditional
      \ start="\v^#%(ifdef|ifndef|if|else|endif)" end="$" skip="\\$"
syn region  hsCPPDefine
      \ start="\v^#%(define|undef)" end="$" skip="\\$"

hi def link hsCPPConditional PreCondit
hi def link hsCPPDefine      Define
"" CPP }}}

"" import {{{
syn match  hsImportPragmaStart "\v%(^\s+|^@<!)\{-#" contained nextgroup=hsImportPragma,hsError skipwhite skipempty
syn match  hsImportPragma "\vSOURCE" contained nextgroup=hsPragmaEnd,hsError skipwhite skipempty

hi default link hsImportPragma      Keyword
hi default link hsImportPragmaStart hsPragmaBrace

execute 'syn region hsImport fold '.
      \ 'start="^import\>" '.
      \ 'end="'.s:end_region_skip.'%(import>|$|#|--|\{-)@!"me=s-1 '.
      \ 'contains=@hsGlobal,hsImportName,hsImportKeyword,hsImportList,hsStringLiteral,hsImportPragmaStart'
syn sync match hsImportSync grouphere hsImport "^import\>"

exe 'syn match  hsImportName "'.s:modid.'" contained'
syn keyword hsImportKeyword import as qualified hiding contained
syn region  hsImportList contained contains=@hsId,hsImportSym
      \ matchgroup=hsImportListParen start='(' end=')'
syn region  hsImportSym  contained contains=@hsSym
      \ matchgroup=hsImportListParen start='(' end=')'

hi def link hsImport NONE
hi def link hsImportKeyword Keyword
hi def link hsImportListParen Special
"" import }}}

"" TODO: data pragma -- UNPACK, CTYPE
"" data/newtype {{{
execute 'syn region hsDataDecl fold matchgroup=Keyword start="\v^%(data|newtype)>" '.
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,hsDataPragma,hsDataDeclReserved,hsDataDeclKeyword,@hsType'

syn sync match hsDataDeclSync grouphere hsDataDecl '\v^%(data|newtype)>'

syn match   hsDataDeclReserved "[=]" contained
syn keyword hsDataDeclKeyword  where deriving contained

hi def link hsDataDeclKeyword  Keyword
hi def link hsDataDeclReserved Special
"" data/newtype }}}

"" TODO: Class Pragma -- INLINE, INLINABLE
"" class/instance {{{
execute 'syn region hsClassDecl fold matchgroup=Keyword start="\v^%(class|instance)>" '.
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,hsClassDeclReserved,hsClassDeclKeyword,@hsValue,hsClassPragma'
syn sync match hsClassDeclSync grouphere hsClassDecl '\v^%(class|instance)>'

syn keyword hsClassDeclKeyword newtype data type where contained

hi def link hsClassDeclKeyword  Keyword
hi def link hsClassDeclReserved Special
"" class/instance }}}

"" infix {{{
execute 'syn region hsInfixDecl matchgroup=Keyword start="\v^%(infix[lr]?)>" '.
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,hsDecimalLiteral,@hsInfix,hsInfixSplitter'
syn sync match hsInfixDeclSync grouphere hsInfixDecl '\v^%(infix[lr]?)>'

syn match hsInfixSplitter "," contained
hi def link hsInfixSplitter Special
"" infix }}}

"" type {{{
execute 'syn region hsTypeDecl fold matchgroup=Keyword start="\v^type>" '.
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,@hsType,hsTypeDeclReserved'
syn sync match hsTypeSync grouphere hsTypeDecl '\v^type>'

syn match hsTypeDeclReserved "\v[=]" contained
hi def link hsTypeDeclReserved Special
"" type }}}

"" type family {{{
execute 'syn region hsTypeFamilyDecl '.
      \ 'matchgroup=Keyword start="\v^type\s+%(family|instance)>"'
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,@hsType,'.
      \ 'hsTypeFamilyDeclReserved,hsTypeFamilyDeclKeyword'
syn sync match hsTypeFamilyDecl grouphere hsTypeFamilyDecl '\v^type\s+%(family|instance)>'

syn keyword hsTypeFamilyDeclKeyword where contained
syn match   hsTypeFamilyDeclReserved "\v[=]" contained
hi def link hsTypeFamilyDeclReserved Special
hi def link hsTypeFamilyDeclKeyword  Keyword
"" type family }}}

"" foreign {{{
execute 'syn region hsForeignDecl '.
      \ 'matchgroup=Keyword start="\v^foreign>" '.
      \ 'end="'.s:end_region_skip.'\S"me=s-1 '.
      \ 'contains=@hsGlobal,@hsType,hsForeignKeyword,hsStringLiteral'

syn sync match hsForeignDeclSync grouphere hsForeignDecl '\v^foreign>'

syn match hsForeignKeyword '\v<%(export|import|ccall|capi|stdcall|interruptible)>' contained
syn match hsForeignKeyword '\v"%(wrapper|dynamic)"' contained
hi def link hsForeignKeyword Keyword
"" foreign }}}

syn cluster hsGlobal contains=@hsComment,@hsCPP,hsLINEPragma

let b:current_syntax = "haskell"
