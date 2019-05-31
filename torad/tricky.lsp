(defun ss2lst(ss / n l)
	(repeat (setq n(sslength ss))
		(setq n (1- n) l (cons (ssname ss n) l))
	)
)
(defun lst2ss(l / ss)
	(setq ss(ssadd))
	(foreach e l (ssadd e ss))
)
(defun get(k l)
	(if (atom (caar l))
		(cond 
			((atom k) (cdr(assoc k l)))
			((and (cdr k)(atom (cdr k))) 
				(cons (get (car k) l) (cdr(assoc (cdr k) l)))
			)
			(T (mapcar '(lambda(x)(get x l)) k))
		)
		(mapcar '(lambda(x) (get k x)) l)
	)
)
(defun cdnr(n l)
	(repeat n(setq l(cdr l)))
)
(defun isinstr(ssub sall / lsub lall i n ret)
	(setq lall(strlen sall) lsub(strlen ssub))
	(cond 
		((> lsub lall) nil)
		((< lsub lall)
			(setq i 1 n (1+ (- lall lsub)))
			(while(and (not ret) (<= i n))
				(if (= ssub (substr sall i lsub))
					(setq ret i)
					(setq i(1+ i))
				)
			)
		)
		(T (if(= ssub sall) 1))
	)
)
(defun strp(s)
	(and (= 'str (type s)) (/= s ""))
)
;;; ADJOIN - adds element to list, if not already in it
(defun adjoin (item l)
  (cond ((member item l) l)
		(t (cons item l))))

;;; TAIL - list l without the first n elements
(defun tail (l n)
  (cond ((zerop n) l)
		(t (tail (cdr l) (1- n)))))

;;; HEAD - list of only the first n elements
;;; (including) the n-th element, base 0
(defun head (l n) (head-rek l nil n))
(defun head-rek (l x n)
  (cond ((zerop n) (reverse x))
		(t (head-rek (cdr l) (cons (car l) x) (1- n))		
		)		
	)	
)

;;; POS - position of the first pt in pts, -1 if not found
(defun pos (pt pts)
  (- (length pts) (length (member pt pts))))

;;; RPOS - position of the last pt in pts, -1 if not found
(defun rpos (pt pts)
  (1- (length (member pt (reverse pts)))))

;;; MEMB - member with equal's uncertainty check (diff: real number)
(defun memb (ele lst diff)
  (if lst
    (if (equal ele (car lst) diff)
      lst
      (memb ele (cdr lst) diff)
		)	
	)	
)

;;; RPLACE - replaces the n-th element with new, base 0
(defun rplace (lst n new)
  (append (head lst (1- n)) (list new) (tail lst n)))

;;; REMOVE - Non-destructive way to remove an item from a list/tree.
;;; recursive, double elements allowed
(defun remove (item from)
  (cond
    ((atom from) from)
    ((equal (car from) item)
      (remove item (cdr from)))
    (T (cons (car from) 
				 (remove item (cdr from)))
		)
	)
)
(defun removeexp (expr lst)
   (apply 'append (subst nil (list expr) (mapcar 'list lst)))
)
;;; C:LWSTRIP
;;; Makes all lineweights 0 in the current drawing
;;;
;;; Copyright holders:
;;; 2008 Hubbard Enterprises, Inc. dba Hubbard Engineering Gilbert, Arizona
(DEFUN
   C:LWSTRIP (/ EG EN ICURRENTOBJECT SSALL)
  (SETQ
    SSALL
     (SSGET "X")
    ICURRENTOBJECT -1
  )
  ;;For every object in the selection set,
  (WHILE (SETQ EN (SSNAME SSALL (SETQ ICURRENTOBJECT (1+ ICURRENTOBJECT))))
    ;;Set the lineweight to 0
    (SETQ EG (ENTGET EN))
    ;;Entmod modifies the entity based on the new list after the substitution.
    (ENTMOD (SUBST (CONS 370 0) (ASSOC 370 EG) EG))
  )
  ;;Set various drawing settings to make sure lineweights don't appear unexpectedly.
  (SETVAR "celweight" -1)
  (SETVAR "dimlwd" -2)
  (SETVAR "dimlwe" -2)
  (SETVAR "lwdefault" 0)
  ;;Exit function silently
  (PRINC)
)