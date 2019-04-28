(defparameter *locations* '((riverbank
                             (You are on a chilly riverbank surrounded by a light fog.
                              your clothes are soaked from being in the river. It
                              is dark but the moon is bright and full. You can see
                              relatively well. Near your feel there is palm-sized stone))

                            (village-green
                             (The village green is more than a little brown. You are
                              standing in its center.))

                            (river-walk
                             (You are on the river walk. During the day\, it must be
                              tranquil\, but at night there is something almost
                              sinister about it.))

                            (bridge
                             (You are on an old wooden bridge. A stream runs beneath it
                              before turning south and pouring itself into the river.))

                            (dilapidated-house
                             (You are standing in the foyer of house. On table next
                              to you stands an unlit candle.))

                            (well
                             (You are in a well. The walls a slimy. It appears it has
                              been recently drained.))))

(defparameter *location* 'riverbank)

(defparameter *paths* '((riverbank
                         (river-walk west path))

                        (river-walk
                         (bridge north path)
                         (riverbank east path))

                        (bridge
                         (village-green north path)
                         (river-walk south path))))

(defparameter *items* '(stone candle key letter))

(defparameter *item-locations* '((stone riverbank)
                                   (candle foyer)
                                   (key well)
                                   (letter bedroom)))

(defun describe-location (loc locs)
  (cadr (assoc loc locs)))

(defun describe-path (path)
  `(There is a ,(caddr path) going ,(cadr path) from here.))

(defun describe-paths (loc paths)
  (apply #'append (mapcar #'describe-path (cdr (assoc loc paths)))))

(defun items-at (loc items item-loc)
  (labels ((at-loc-p (item)
             (eq (cadr (assoc item pitem-loc)) loc)))
    (remove-if-not #'at-loc-p items)))

(defun describe-items (loc items item-loc)
  (labels ((describe-item (item)
             `(You see a ,item on the floor.)))
    (apply #'append (mapcar #'describe-item (items-at loc items item-loc)))))

(defun walk (direction)
  (let ((next (find direction
                    (cdr (assoc *location* *paths*))
                    :key #'cadr)))
    (if next
        (progn (setf *location* (car next))
               (look))
        '(You cannot go that way.))))

(defun look ()
  (append (describe-location *location* *locations*)
          (describe-paths *locations* *paths*)
          (describe-items *location* *items* *items-locations*)))

(defun take (item)
  (cond ((member item
                 (items-at *location* *items* *item-locations*))
         (push `(,item body) *item-locations*)
         `(You are now carrying the ,item))
        (t '(You cannot take that.))))

;; (defun prompt-read (lst)
;;   (format *query-io* "~{~A ~}~%>>> " lst)
;;   (force-output *query-io*)
;;   (read-line *query-io*))

;; (defun run-command (command)
;;   (cond ((member command '("north" "n" "east" "e" "south" "s" "west" "w")
;;                  :test #'string=)
;;          (walk command))
;;         ((string= command "look") (look))
;;         ((string= command "take") (take))))

;; (defun game-loop ()
;;   (loop (parse-command (prompt-read) *dictionary*)
;;         (if (eq *query-io* "quit") (return))))

;; (defun save-data ()
;;   `((inventory (,*inventory*))
;;     (location (,*location*))))

;; (defun save ()
;;   (with-open-file (out "save-data.lisp"
;;                        :direction :output
;;                        :if-exists :supersede)
;;     (with-standard-io-syntax
;;       (print (save-data) out))))

;; (defun restore-game (save-data)
;;   (setf *location* (assoc 'location save-data)))

;; (defun load-save ()
;;   (with-open-file (in "save-data.lisp")
;;     (with-standard-io-syntax
;;       (restore-game (read in)))))
