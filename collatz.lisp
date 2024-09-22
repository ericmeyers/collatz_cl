(ql:quickload :alexandria)

;;
;; just make the sequence for now
(defun collatz-conjecture (n)
	  (cond
	    ((= n 1) '(1))
	    ((= (mod n 2) 0) (cons n (collatz-conjecture (/ n 2))))
	    (t (cons n (collatz-conjecture (+ 1 (* n 3)))))))

;;
;; list length
(defun collatz-length (n)
	(list-length (collatz-conjecture n)))


;;
;;
(defparameter xs (alexandria:iota 10000 :start 1 :step 1))
(time (defparameter ys (mapcar #'collatz-length xs)))
