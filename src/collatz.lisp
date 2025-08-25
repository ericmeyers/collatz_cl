;; got rid of quicklisp calls. moved to asdf
;;(ql:quickload :alexandria)
;;(ql:quickload :vgplot)
;;(py4cl2:defpymodule "matplotlib.pyplot" t  :lisp-package "plt")



(in-package :collatz_cl)

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
      (labels
        ((helper (m cum)
	      (cond
	        ((= m 1) (+ 1 cum))
	        ((= (mod m 2) 0) (helper (/ m 2) (+ 1 cum)))
	        (t (helper (+ 1 (* m 3)) (+ 1 cum))))))
;;      (write n)
;;      (terpri)
      (helper n 0)))

;
(defun iota (n &key (start 0) (step 1))
  "iota using DO iteration macro"
  (when (minusp n)
    (error "Invalid number of items specified"))
  (do ((i 0 (1+ i))
       (item start (+ item step))
       (result nil (push item result)))
      ((= i n) (nreverse result))))

(defparameter xs (alexandria:iota 100000  :start 1 :step 1))
(defparameter ys (time (mapcar #'collatz-length-brian xs)))
(defparameter df (ls-user:plist-df `(:xx ,(coerce xs '(vector fixnum)) :yy ,(coerce ys '(vector fixnum)))))


(defun doit ()
 (let* ()
;;   ((xs (alexandria:iota 11  :start 1 :step 1))
;;    (ys (time (mapcar #'collatz-length-brian xs)))
;;    (df (ls-user:plist-df `(:xx ,xs :yy ,ys))))
;;    (ys (time (mapcar '1+ xs))))
;; make plot
;;

  (plot:plot
    (vega:defplot scatterplot
    `(:title "Collatz Fun From Common Lisp"
      :data (:values ,df)
      :mark :point
      :width 800
      :height 600
      :encoding (:x (:field :xx :type "quantitative")
                 :y (:field :yy :type "quantitative")
                 :color (:field "item" :type "nominal" :legend nil))
      :selection (:brush (:type "interval" :bind "scales" )))))
;    (vgplot:xlabel "Value")
;;    (vgplot:ylabel "Steps")
;;    (vgplot:plot xs ys "ko;Collatz Fun in Common Lisp;")
;;    (plt::scatter xs ys :s 1)
;;    (plt::grid :which "both" :axis "both" :color "0.8" :linestyle "--")
;;    (plt::show)
    ))
;;))
