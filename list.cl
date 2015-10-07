(load "logic.cl")

(defun cons. (x y)
    #'(lambda (p) (cond. p x y))
)
(defun car. (x)
    (funcall x #'true)
)
(defun cdr. (x)
    (funcall x #'false)
)

(defun nil. (f) #'true)

