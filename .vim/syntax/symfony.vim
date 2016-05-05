" Vim syntax file
" Language:	Symfony template
" Maintainer:	Armin Ronacher <armin.ronacher@active-4.com>
" Last Change:	2008 May 9
" Version:      1.1
"
" Known Bugs:
"   because of odd limitations dicts and the modulo operator
"   appear wrong in the template.
"
" Changes:
"
"     2008 May 9:     Added support for Symfony2 changes (new keyword rules)

" .vimrc variable to disable html highlighting
if !exists('g:symfony_syntax_html')
   let g:symfony_syntax_html=1
endif

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'symfony'
endif

" Pull in the HTML syntax.
if g:symfony_syntax_html
  if version < 600
    so <sfile>:p:h/html.vim
  else
    runtime! syntax/html.vim
    unlet b:current_syntax
  endif
endif

syntax case match

" Symfony template built-in tags and parameters (without filter, macro, is and raw, they
" have special threatment)
syn keyword symfonyStatement containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained and if else in not or recursive as import

syn keyword symfonyStatement containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained is filter skipwhite nextgroup=symfonyFilter
syn keyword symfonyStatement containedin=symfonyTagBlock contained macro skipwhite nextgroup=symfonyFunction
syn keyword symfonyStatement containedin=symfonyTagBlock contained block skipwhite nextgroup=symfonyBlockName

" Variable Names
syn match symfonyVariable containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained /[a-zA-Z_][a-zA-Z0-9_]*/
syn keyword symfonySpecial containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained false true none False True None loop super caller varargs kwargs

" Filters
syn match symfonyOperator "|" containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained skipwhite nextgroup=symfonyFilter
syn match symfonyFilter contained /[a-zA-Z_][a-zA-Z0-9_]*/
syn match symfonyFunction contained /[a-zA-Z_][a-zA-Z0-9_]*/
syn match symfonyBlockName contained /[a-zA-Z_][a-zA-Z0-9_]*/

" Symfony template constants
syn region symfonyString containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained start=/"/ skip=/\(\\\)\@<!\(\(\\\\\)\@>\)*\\"/ end=/"/
syn region symfonyString containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained start=/'/ skip=/\(\\\)\@<!\(\(\\\\\)\@>\)*\\'/ end=/'/
syn match symfonyNumber containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained /[0-9]\+\(\.[0-9]\+\)\?/

" Operators
syn match symfonyOperator containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained /[+\-*\/<>=!,:]/
syn match symfonyPunctuation containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained /[()\[\]]/
syn match symfonyOperator containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained /\./ nextgroup=symfonyAttribute
syn match symfonyAttribute contained /[a-zA-Z_][a-zA-Z0-9_]*/

" Symfony template tag and variable blocks
syn region symfonyNested matchgroup=symfonyOperator start="(" end=")" transparent display containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained
syn region symfonyNested matchgroup=symfonyOperator start="\[" end="\]" transparent display containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained
syn region symfonyNested matchgroup=symfonyOperator start="{" end="}" transparent display containedin=symfonyVarBlock,symfonyTagBlock,symfonyNested contained
syn region symfonyTagBlock matchgroup=symfonyTagDelim start=/{%-\?/ end=/-\?%}/ containedin=ALLBUT,symfonyTagBlock,symfonyVarBlock,symfonyRaw,symfonyString,symfonyNested,symfonyComment

syn region symfonyVarBlock matchgroup=symfonyVarDelim start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,symfonyTagBlock,symfonyVarBlock,symfonyRaw,symfonyString,symfonyNested,symfonyComment

" Symfony template 'raw' tag
syn region symfonyRaw matchgroup=symfonyRawDelim start="{%\s*raw\s*%}" end="{%\s*endraw\s*%}" containedin=ALLBUT,symfonyTagBlock,symfonyVarBlock,symfonyString,symfonyComment

" Symfony comments
syn region symfonyComment matchgroup=symfonyCommentDelim start="{#" end="#}" containedin=ALLBUT,symfonyTagBlock,symfonyVarBlock,symfonyString

" Block start keywords.  A bit tricker.  We only highlight at the start of a
" tag block and only if the name is not followed by a comma or equals sign
" which usually means that we have to deal with an assignment.
syn match symfonyStatement containedin=symfonyTagBlock contained /\({%-\?\s*\)\@<=\<[a-zA-Z_][a-zA-Z0-9_]*\>\(\s*[,=]\)\@!/

" and context modifiers
syn match symfonyStatement containedin=symfonyTagBlock contained /\<with\(out\)\?\s\+context\>/


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_symfony_syn_inits")
  if version < 508
    let did_symfony_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink symfonyPunctuation symfonyOperator
  HiLink symfonyAttribute symfonyVariable
  HiLink symfonyFunction symfonyFilter

  HiLink symfonyTagDelim symfonyTagBlock
  HiLink symfonyVarDelim symfonyVarBlock
  HiLink symfonyCommentDelim symfonyComment
  HiLink symfonyRawDelim symfony

  HiLink symfonySpecial Special
  HiLink symfonyOperator Normal
  HiLink symfonyRaw Normal
  HiLink symfonyTagBlock PreProc
  HiLink symfonyVarBlock PreProc
  HiLink symfonyStatement Statement
  HiLink symfonyFilter Function
  HiLink symfonyBlockName Function
  HiLink symfonyVariable Identifier
  HiLink symfonyString Constant
  HiLink symfonyNumber Constant
  HiLink symfonyComment Comment

  delcommand HiLink
endif

let b:current_syntax = "symfony"

if main_syntax == 'symfony'
  unlet main_syntax
endif
