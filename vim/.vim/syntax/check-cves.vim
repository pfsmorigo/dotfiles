" Vim syntax file

"if version < 600
  "syntax clear
"elseif exists("b:current_syntax")
  "finish
"endif

syn match comment "^#.*"
syn match cveStatus "\(needs\-triage\|needed\|deferred\|pending\|released\|ignored\|not\-affected\|DNE\)"

command -nargs=+ HiLink hi def link <args>

HiLink cveStatus  Identifier
HiLink cveId      Keyword
HiLink comment    Number

syn region cveStrictField start="CVE-^[a-z/-]\+" end="$" contains=cveId,cveStatus,cveOwner  oneline

let b:current_syntax = "check-cves"
" vim: ts=8 sw=2
