(in-package :terminal)
(in-readtable :qtools)

(define-widget terminal (QWidget) ())

(define-subwidget (terminal name) (q+:make-qlineedit terminal)
    (setf (q+:placeholder-text name) "Your name please."))

(define-subwidget (terminal go) (q+:make-qpushbutton "Go!" terminal))

(defun run-terminal ()
  (with-main-window (window (make-instance 'terminal))))
