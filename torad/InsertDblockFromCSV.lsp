(defun C:ESJ (/ doc _trim _delimiter l2p allTheDataNeeded namelist format dbporpnameFound pt
							 theCSVSoure openedCSVFile coordinates bname curretnStateOfDBlock ColumNnames)
	
	;;;				pBe July 2017	      			;;;
	;;;									;;;
	
	(setq aDoc     (vla-get-ActiveDocument (vlax-get-acad-object))
		*mspace* (vla-get-ModelSpace aDoc)
		namelist
		'("Name"
			 "CODIGO"
			 "COOR_F-X"
			 "COOR_F-Y"
			 "COOR_I-X"
			 "COOR_I-Y"))
	
	(defun _trim (str)
		(foreach func '(vl-string-right-trim vl-string-left-trim)
			(setq str ((eval func)  " " str))) str)      
	(defun _delimiter (str md / d l str)
		(while (setq d (vl-string-position md str nil T))
			(setq	l   (cons (_trim (substr str (+ 2 d))) l)
				str (substr str 1 d)
			)
		)
		(cons str l)	
	)
	
  (defun l2p (l)
    (if (>=  (length l) 2)
      (cons (list (distof (car l))
							(distof (cadr l)) 0.0) (l2p (cddr l)))
    )
  )
	(defun _InsertBlock (spc  p bname )
		(vlax-invoke spc 'InsertBlock p bname 1 1 1 0))
	
	(if (setq allTheDataNeeded nil
				format nil
				theCSVSoure (getfiled "Select CSV file" (getvar 'dwgprefix)  "csv" 16)
			)
		(progn
			(setq openedCSVFile (open theCSVSoure "r"))
			(setq ColumNnames (read-line openedCSVFile))
			(setq ColumNnames (_delimiter ColumNnames 44))
			(while (setq a (read-line openedCSVFile))
				(setq b (_delimiter a 44))
				(setq allTheDataNeeded (cons b allTheDataNeeded))
			)
			(close openedCSVFile)
			(setq n (length ColumNnames))
			(foreach itm (reverse ColumNnames)
				(setq n (1-  n))
				(if (member (setq itm (_trim itm)) namelist)
					(setq format (cons (list itm n) format))))
			(foreach data (setq allTheDataNeeded (reverse allTheDataNeeded))
				(and
					(setq ndata (mapcar '(lambda (x)
																 (nth x data)) (mapcar 'cadr format)))
					(setq coordinates (L2P  (cddr ndata)))
					(snvalid (setq bname (car ndata)))
					(tblsearch "BLOCK"  bname)
					(setq Dblock (vlax-invoke *mspace*
												 'InsertBlock (Cadr coordinates)  bname  1 1 1 0))
					(not (vlax-put Dblock 'Rotation (angle  (Cadr coordinates) (Car coordinates))))
					(setq curretnStateOfDBlock
						(mapcar '(lambda (dbcs)
											 (cons  (vlax-get dbcs 'PropertyName) dbcs))
							(vlax-invoke Dblock 'GetDynamicBlockProperties)
						))
					(setq dbporpnameFound (cdr (assoc "LONGITUD" curretnStateOfDBlock)))
					(not (vlax-put dbporpnameFound 'Value
								 (distance (Cadr coordinates) (Car coordinates))))
					(vl-some '(lambda (atb)
											(if (equal (strcase (vla-get-tagstring atb)) "CODIGO")
												(null (Vla-put-textstring atb (Cadr data)))))
						(vlax-invoke Dblock 'getattributes))
					(setq allTheDataNeeded
						(subst
							(append
								(cdr ndata)
								(list (rtos (vlax-get dbporpnameFound 'Value) 2 0)))
							data
							allTheDataNeeded))
				)
			)
			
			(if (and  allTheDataNeeded
						Dblock
						(not (vla-getboundingbox Dblock 'll 'ur))
						(setq pt (vlax-safearray->list ll))
					)
				(progn
					(_InsertBlock *mspace* pt "ESJ_HEADER")
					(setq pt (polar pt  (* pi 1.5) 15.00))
					(While (setq dataforbody (car allTheDataNeeded))
						
						(setq body (_InsertBlock *mspace* pt "ESJ_DATA"))
						(mapcar '(lambda (a b)
											 (Vla-put-textstring a b))
							(vlax-invoke body 'GetAttributes) dataforbody)
						(setq pt (polar pt  (* pi 1.5) 12.00)
							allTheDataNeeded (cdr allTheDataNeeded))
					)
				)
			)
		)
	)
	(vla-regen aDoc acallviewports)
)