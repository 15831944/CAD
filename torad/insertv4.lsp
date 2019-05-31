(defun c:InsertV4 (/ do sp bk bn f on st l)
	;; Tharwat, modified by Kling;;
	(setq do (vla-get-activedocument (vlax-get-acad-object))
		sp (vla-get-block (vla-get-activelayout do))
	)
	(cond
		((not (and (setq bn "FTF-Testanlage"
							 )
						(/= bn "")
						(tblsearch "BLOCK" bn)
					)
		 )
			(princ (strcat "\nEmpty value or Block name < "
							 bn
							 " > is not existed in current drawing !"
						 )
			)
		)
		((setq f (getfiled "Select Excel file :"
							 (getvar 'dwgprefix)
							 "csv"
							 16
						 )
		 )
			(setq on (open f "r"))
			(while (setq st (read-line on))
				(if (and (setq l (_parse st))
							(= (length l) 4)
							(setq bk (vla-insertblock
												 sp
												 (vlax-3d-point (read (car l)) (read (cadr l)))
												 bn
												 1.0
												 1.0
												 1.0
												 (read (caddr l))
											 )
							)
						)
					(progn
						(LM:vl-setattributevalue bk "ORIENT" (caddr l))
						(LM:setdynpropvalue bk "Winkel1" (read (cadddr l))))
				)
			)
			(close on)
		)
	)
	(princ)
)
;; Set Dynamic Block Property Value - Lee Mac
;; Modifies the value of a Dynamic Block property (if present)
;; blk - [vla] VLA Dynamic Block Reference object
;; prp - [str] Dynamic Block property name (case-insensitive)
;; val - [any] New value for property
;; Returns: [any] New value if successful, else nil
(defun LM:setdynpropvalue ( blk prp val )
	(setq prp (strcase prp))
	(vl-some
		'(lambda ( x )
			 (if (= prp (strcase (vla-get-propertyname x)))
				 (progn
					 (vla-put-value x (vlax-make-variant val (vlax-variant-type (vla-get-value x))))
					 (cond (val) (t))
				 )
			 )
		 )
		(vlax-invoke blk 'getdynamicblockproperties)
	)
)
;; Set Attribute Value - Lee Mac
;; Sets the value of the first attribute with the given tag found within the block, if present.
;; blk - [vla] VLA Block Reference Object
;; tag - [str] Attribute TagString
;; val - [str] Attribute Value
;; Returns: [str] Attribute value if successful, else nil.
(defun LM:vl-setattributevalue ( blk tag val )
	(setq tag (strcase tag))
	(vl-some
		'(lambda ( att )
			 (if (= tag (strcase (vla-get-tagstring att)))
				 (progn (vla-put-textstring att val) val)
			 )
		 )
		(vlax-invoke blk 'getattributes)
	)
)
(defun _parse (s / pos lst)
	(while (setq pos (vl-string-search ";" s 0))
		(progn (setq lst (cons (substr s 1 pos) lst))
			(setq s (substr s (+ pos 2) (strlen s)))
		)
	)
	(if (and s (/= s ""))
		(setq lst (cons s lst))
	)
	(setq lst (reverse lst))
)
(vl-load-com) (princ)