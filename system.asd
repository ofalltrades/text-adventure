(asdf:defsystem text-adventure
    :name                 "Text Adventure"
    :description          "text-adventure: a toy text adventure game"
    :version              "0.0.0"
    :author               "Jake Johnson"
    :licence              "Public Domain"
    :defsystem-depends-on (:qtools)
    :depends-on           (:qtcore :qtgui)
    :serial               t
    :components           ((:module     "src"
                            :components ((:file "packages")
                                         (:file "terminal")
                                         (:file "main"))))
    :build-operation      "qt-program-op"
    :build-pathname       "text-adventure"
    :entry-point          "terminal:run-terminal")
