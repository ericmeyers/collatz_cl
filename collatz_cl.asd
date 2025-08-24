(asdf:defsystem "collatz_cl"
  :depends-on ("alexandria" "py4cl")
  :components (
        (:module "src"
                  :components ((:file "package")
                               (:file "collatz")))))
