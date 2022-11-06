; Format sql in sqlx::query!
(
 (macro_invocation
  (scoped_identifier
     path: (identifier) @_path
     name: (identifier) @_identifier)

  (token_tree (raw_string_literal) @sql))

 (#eq? @_path "sqlx")
 (#eq? @_identifier "query")
 (#offset! @sql 1 0 0 0)
)

;(
 ;(macro_invocation
  ;(scoped_identifier
     ;name: (identifier) @_identifier)

  ;(token_tree (raw_string_literal) @html))

 ;(#eq? @_identifier "html")
 ;(#offset! @html 1 0 0 0)
;)
