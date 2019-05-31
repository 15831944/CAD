(defun C:XLCR (/ *error* GetXlRangeByMatch address filename gruppen sheetname x xlapp xlbook xldata xlrange)
	(vl-load-com)
	(defun *error* (msg)    
    (if xlbook 
			(vl-catch-all-apply 'vlax-invoke-method (list xlbook 'Close :vlax-false)))
    (gc)
    (if xlapp (vl-catch-all-apply 'vlax-invoke-method (list xlapp 'Quit)))
    (gc)
    (cond ((not msg))
			((member msg '("Function cancelled" "quit / exit abort")))
			((princ (strcat "\n** Error: " msg " ** ")))) 
    (princ)
	)                                                                 
	
	(defun GetXlRangeByAddress(filename sheetname address / xlbook xlrange xlsheet xlapp skv_records)
		
    (setq xlapp(vlax-get-or-create-object "Excel.Application"))
    
		(vla-put-visible xlapp :vlax-true)
    (vlax-put-property xlapp 'DisplayAlerts :vlax-false)
		(if (zerop 
					(vlax-get-property(vlax-get-property xlapp 'workbooks) 'count))
			(setq xlbook (vl-catch-all-apply 'vla-open
										 (list (vlax-get-property xlapp 'WorkBooks) fileName))
				
			)
			(setq xlbook (vl-catch-all-apply 'vlax-get-property (list xlapp 'activeworkbook))))
		;;__________________________________________________________________________________;;
		(if (numberp sheetname)
			(setq xlsheet (vl-catch-all-apply 'vlax-get-property  (list (vlax-get-property xlbook 'Sheets)
																															'Item
																															sheetname ;|"Sheet1" or 1 maybe|;;< --- sheet name or number
																														) 
										)
			)
			(progn
				(vlax-for sht (vlax-get-property xlbook 'Sheets)
					(if (eq (vlax-get-property sht 'Name) sheetname)
						(setq xlsheet sht))
					
				)
				
			)
			
		)
		;;_____________________________________________________________________________________;;
    (vlax-invoke-method xlsheet 'Activate)
    (setq xlrange (vlax-get-property (vlax-get-property xlsheet 'Cells) 'Range address))
    (if (eq :vlax-true (vlax-variant-value(vlax-get-property xlrange 'HasFormula)))
			(setq xldata (vlax-get-property xlrange 'formulalocal))
			(setq xldata(vlax-get-property xlrange 'value2)))
		
		
		(setq xldata (mapcar '(lambda(x)
														(mapcar 'vlax-variant-value x))
									 (vlax-safearray->list
										 (vlax-variant-value  xldata)))
		)
		(if (eq 1(length (car xldata)))
			(setq xldata (vl-remove-if 'not(mapcar 'car xldata)))
			(setq xldata (vl-remove-if 'not  xldata)))
		
		
		(vl-catch-all-apply 'vlax-invoke-method (list xlbook 'close :vlax-false))
		(vlax-put-property xlapp 'DisplayAlerts :vlax-true)
		(gc);; before QUIT
    
		(vl-catch-all-apply 'vlax-invoke-method (list xlapp 'quit))
		(mapcar '(lambda(x)(if (and x (not (vlax-object-released-p x)))        
												 (progn(vlax-release-object x)(setq x nil))))
			(list xlrange xlsheet xlbook xlapp))  
		(gc);; after QUIT
		
		xldata
  )
	
	;;  group with sum elements in list
	;; fixo () 2006 * all rights released
	(defun suminlist  (lst)
		(if (car lst)
			(cons (cons	(car lst)
							(length	(vl-remove-if-not
												'(lambda (x) (equal (car lst) x 0.001))
												lst)
							)
						)
				(suminlist (vl-remove-if
										 '(lambda	(x)
												(equal (car lst) x 0.001))
										 lst)
				)
			)
    )
  )
  ;;___________________________  main part  _______________________;;
	
	
  ;; e.g.: 
  (setq filename (getfiled "Select Excel file : "
									 "Dpipke"; (getvar "dwgprefix")
									 "xlsx;xls"
									 4
								 )
		sheetname "Sheet1"
		address "B1:B1000");<-- also you're could to put exact address , say B10:B23 etc
  (setq xlData (GetXlRangeByAddress filename sheetname address))
	
  ;;;   ---   rest your mojo with acad is goes here   ---   ;;;
  
  (setq gruppen (suminlist xldata))
  (alert (strcat "Return column data with count:\n"(vl-princ-to-string gruppen)))
  (*error* nil)
  (princ)
)
(princ 
	"\n\t\t---\tStart command with XLCR\t---")
(prin1)
(or 
	(vl-load-com)(princ))