(ql:quickload :alexandria)
;(ql:quickload :vgplot)
(ql:quickload :py4cl)
(py4cl:import-module "matplotlib.pyplot" :as "plt")
;;(py4cl:import-module "numpy" :as "np")
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
;; quick length
;; give function type runs faster
(declaim (ftype (function (fixnum) (unsigned-byte 32)) collatz-length-brian))
(defun collatz-length-brian (n)
	  (cond
	    ((= n 1) 1)
	    ((= (mod n 2) 0) (+ 1 (collatz-length-brian (/ n 2))))
	    (t (+ 1 (collatz-length-brian (+ 1 (* n 3)))))))


;;
;;
(let*
 ((xs (alexandria:iota 5000000 :start 1 :step 1))
  (ys (mapcar #'collatz-length-brian xs)))


;; make plot
;;

 (plt:scatter xs ys :s 1)
 (plt:grid :which "both" :axis "both" :color "0.8" :linestyle "--")
 (plt:show))
