
;;; graphviz-dot-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'graphviz-dot-mode "graphviz-dot-mode"
  "Major mode for the dot language." t)
(add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode))
