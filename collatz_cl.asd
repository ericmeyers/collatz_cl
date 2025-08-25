(asdf:defsystem "collatz_cl"
  :depends-on ("alexandria" "data-frame" "plot/vega")
  :serial t
  :components (
        (:module "src"
                  :components ((:file "package")
                               (:file "collatz"))))
  :build-operation "program-op"
  :build-pathname "./collatz_cl"
  :entry-point "collatz_cl:doit")


