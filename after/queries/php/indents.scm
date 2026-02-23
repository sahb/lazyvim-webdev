;; extends

[
  ; prevent double indent for `return new class ...`
  (return_statement
    (object_creation_expression))
  ; prevent double indent for `return function() { ... }`
  (return_statement
    ; changed as recommended by https://github.com/nvim-treesitter/nvim-treesitter-textobjects/pull/673
    (anonymous_function))
] @indent.dedent
