(TeX-add-style-hook
 "replicate_ch7"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("geometry" "margin=1.2in")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref"
    "geometry"
    "setspace"
    "parskip")
   (LaTeX-add-labels
    "sec:orgdb43dbc"
    "sec:orge237783"
    "sec:org2155f83"
    "sec:org6ec6808"
    "sec:org3d97d0a"
    "sec:org095d50c"
    "sec:org9e5b78c"
    "sec:orgc73d934"
    "sec:orgb650517"
    "sec:org7c007cd"
    "sec:orgd802de6"
    "sec:org1742529"
    "sec:org59b7564"
    "sec:org95e2b5d"
    "sec:org34239d1"
    "sec:orgfe3f7dc"
    "table:tbl71"
    "sec:orgcfa22ab"))
 :latex)

