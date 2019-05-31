(defun c:ppa()
	(command "purge" "a" "*" "N")
	(command "purge" "a" "*" "N")
	(command "purge" "a" "*" "N")
	(command "audit" "Y")
	(command "purge" "a" "*" "N")
	(command "QSAVE")
)
(defun LM:vl-getattributevalue ( blk tag )
	(setq tag (strcase tag))
	(vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'vla-getattributes))
)
(defun c:bxy2xls()
	;(setq ent(car (entsel "specify the block:")))
	(while
		(progn
			(setq ent(car(entsel "\n specify the block:")))
			(and ent 
				(/= "INSERT" (dxf 0 (setq el(entget ent))))
			)
		)
	)
  (setq name(dxf 2 el))
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 name)(cons 410 (getvar "CTAB")))))
	(setq xylist nil i 0)
	(OpenExcel nil "抗滑桩坐标" t)
	(PutCell "A1" (list "抗滑桩编号" "坐标x" "坐标y" "高程(m)"))
	;(vlax-for obj(vla-Item
	;							 (vla-get-Blocks(vla-get-ActiveDocument(vlax-get-acad-object)))
	;							 name)
	;	(setq objname(vla-get-TagString obj "1#"))
	;	(princ (strcat "**" objname "**"))
	;)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq obj(vlax-ename->vla-object ssi))
		(setq elist(entget ssi))
		(setq objname(vla-getattributes obj ))
		;(setq objxx(vla-get-TagString objname))
		(setq objvalue(vlax-variant-value objname))
		(setq objvalue2(vlax-safearray->list objvalue))
		(setq objvalue3(car objvalue2))
		(setq objxx(vla-get-TextString objvalue3))
		(setq ptx(car(dxf 10 elist)))
		(setq ptx(rtos ptx 2 4))
		(setq pty(cadr(dxf 10 elist)))
		(setq pty(rtos pty 2 4))
		(setq xylist(cons (list objxx pty ptx) xylist))
		(setq i(1+ i))
	)
	(setq i 0)
	(repeat (length xylist)
		(setq alist(nth i xylist))
		(PutCell (Row+n "A1" (1+ i)) alist)
		(setq i(1+ i))
	)
	xylist
)
(defun c:bxy2xls2()
	;(setq ent(car (entsel "specify the block:")))
	(while
		(progn
			(setq ent(car(entsel "\n specify the block:")))
			(and ent 
				(/= "INSERT" (dxf 0 (setq el(entget ent))))
			)
		)
	)
	(setq b(getreal "\n 抗滑桩宽度(m):"))
	(setq h(getreal "\n 抗滑桩高度(m):"))
	(setq r(/ (sqrt (+(* b b)(* h h))) 2.0))
	(setq ang1(atan (/ h b)))
  (setq name(dxf 2 el))
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 name)(cons 410 (getvar "CTAB")))))
	(setq xylist nil i 0)
	(OpenExcel nil "抗滑桩坐标" t)
	(PutCell "A1" (list "抗滑桩编号" "中心坐标x" "中心坐标y" 
									"角点1坐标x" "角点1坐标y" "角点2坐标x" "角点2坐标y"
									"角点3坐标x" "角点3坐标y" "角点4坐标x" "角点4坐标y"
									"高程(m)"))
	;(vlax-for obj(vla-Item
	;							 (vla-get-Blocks(vla-get-ActiveDocument(vlax-get-acad-object)))
	;							 name)
	;	(setq objname(vla-get-TagString obj "1#"))
	;	(princ (strcat "**" objname "**"))
	;)
	(setq ptlist nil)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq obj(vlax-ename->vla-object ssi))
		(setq elist(entget ssi))
		(setq objname(vla-getattributes obj ))
		;(setq objxx(vla-get-TagString objname))
		(setq objvalue(vlax-variant-value objname))
		(setq objvalue2(vlax-safearray->list objvalue))
		(setq objvalue3(car objvalue2))
		(setq objxx(vla-get-TextString objvalue3))
		(setq ptx(car(dxf 10 elist)))
		(setq ptx(rtos ptx 2 4))
		(setq pty(cadr(dxf 10 elist)))
		(setq pty(rtos pty 2 4))
		(setq xylist(cons (list objxx pty ptx) xylist))		
		(setq ptlist(cons (dxf 10 elist) ptlist))
		(setq i(1+ i))
	)
	(setq i 0 xylist2 nil)
	;(repeat (length xylist)
	;	(setq pt1(cadr(nth i xylist)))
	;	(setq pt2(cadr(nth (1+ i)xylist)))
	;	(setq thera(angle pt1 pt2))
	;)
	
	(repeat (1- (length xylist))
		(setq pt1(nth i ptlist))
		(setq pt2(nth (1+ i) ptlist))
		(setq thera(angle pt1 pt2))
		(setq ptj1(polar pt1 (+ thera ang1) r))
		(setq ptj2(polar pt1 (+ thera (- pi ang1)) r))
		(setq ptj3(polar pt1 (+ pi thera ang1) r))
		(setq ptj4(polar pt1 (+ (* 2 pi) (- thera ang1)) r))
		(setq xylist2(cons 
									 (list (car (nth i xylist))
										 (rtos (cadr pt1) 2 4) (rtos (car pt1) 2 4)
										 (rtos (cadr ptj1) 2 4) (rtos (car ptj1) 2 4)
										 (rtos (cadr ptj2) 2 4) (rtos (car ptj2) 2 4)
										 (rtos (cadr ptj3) 2 4) (rtos (car ptj3) 2 4)
										 (rtos (cadr ptj4) 2 4) (rtos (car ptj4) 2 4)	 
									 )
									 xylist2))
		(setq i(1+ i))
	)
	(setq pt1(nth (1- (length ptlist)) ptlist))
	(setq ptj1(polar pt1 (+ thera ang1) r))
	(setq ptj2(polar pt1 (+ thera (- pi ang1)) r))
	(setq ptj3(polar pt1 (+ pi thera ang1) r))
	(setq ptj4(polar pt1 (+ (* 2 pi) (- thera ang1)) r))
	(setq xylist2(cons 
								 (list (car (nth (1- (length xylist)) xylist))
									 (rtos (cadr pt1) 2 4) (rtos (car pt1) 2 4)
									 (rtos (cadr ptj1) 2 4) (rtos (car ptj1) 2 4)
									 (rtos (cadr ptj2) 2 4) (rtos (car ptj2) 2 4)
									 (rtos (cadr ptj3) 2 4) (rtos (car ptj3) 2 4)
									 (rtos (cadr ptj4) 2 4) (rtos (car ptj4) 2 4) 	 
								 )
								 xylist2))
	(setq xylist2(reverse xylist2))
	(setq i 0)
	(repeat (length xylist2)
		(setq alist(nth i xylist2))
		(PutCell (Row+n "A1" (1+ i)) alist)
		(setq i(1+ i))
	)
	xylist
)
(defun sibo()
	(setq pstart(getpoint "The start point:"))
	(setq pend(getpoint "The end Point:"))
	(setq baseline(entget (car(entsel "Pick a line:"))))
)
(defun c:Export-CSV (/ count csv lst txt )
	(setq lst '("ITEM" "QUANTITY")) ; given list 
	(setq count 1)
	(setq csv (open(strcat(getvar"dwgprefix")(getvar"dwgname")".csv")"w")) ; create a csv file using drawing prefix & name with .csv file type
	(setq txt (nth 0 lst)) ; place into a text string the first element of the list
	(repeat (1- (length lst)) (setq txt (strcat txt "," (nth count lst))) (setq count (1+ count)))
	; loop through the length of the list and place into a long text string separated by a comma
	(write-line txt csv) ; write the long text string to the csv file
	(close csv) ; close the csv file
) ; defun command Export-CSV

(defun c:tz()
	(setq ent(car (entsel "specify the Text:")))
	(setq data(entget ent))
	(setq name(cdr(assoc 1 data)))
	(setq ss(ssget "x" (list (cons 0 "TEXT") (cons 1 name))))
	(sssetfirst ss ss)
)
(defun c:blksel()
	(setq ent(car (entsel "specify the block:")))
	(setq data(entget ent))
	(setq name(cdr(assoc 2 data)))
	(setq ss(ssget "X" (list (cons 0 "INSERT") (cons 2 name))))
	(sssetfirst ss ss)
)
(defun c:vpall()
	(setvar "TILEMODE" 0)
	(setq ss(ssget "X" (list (cons 0 "VIEWPORT") )))
	(command "VPORTS" "on" ss "")
)
(defun c:fsdb()
	(if(not (tblsearch "style" "fsdb"))
		(command "STYLE" "fsdb" "fsdb_e,fsdb" 0 0.75 0 "N" "N" "N")
	)
	(setq ss(ssget "x" (list (cons 0 "TEXT"))))
	
	;(repeat(sslength ss)
	;	(setq i 0 ssi(ssname ss i))
	;	(if (/= "fsdb" (dxf 7 (entget ssi)))
	;		(progn
	;			(subst (cons 7 "fsdb") (assoc 7 (entget ssi)) (entget ssi))
	;			(entmod (entget ssi))
	;		)
	;		
	;	)
	;)
)
(defun c:tssd()
	(if(not(tblsearch "style" "tssd"))
		(command "STYLE" "tssd" "tssdeng,tssdchn" 0 0.75 0 "N" "N" "N")
	)	
)
(defun c:data1()
	(setq data(getdata))
)
(defun getdata()
	(setq data(entget (car (entsel "specify the entity:"))))
	(terpri)
	data
)
(defun setvar0()
	(setq cmho(getvar "CMDECHO"))
	(setq hiht(getvar "HIGHLIGHT"))
	(setq blde(getvar "BLIPMODE"))
	;(setq snde(getvar "SNAPMODE"))
	(setq osde(getvar "OSMODE"))
	;(setq pist(getvar "PICKFIRST"))
	(setvar "CMDECHO" 0)
	(setvar "HIGHLIGHT" 0)
	(setvar "BLIPMODE" 0)
	(setvar "SNAPMODE" 0)
	(setvar "OSMODE" 0)
)
(defun resetvar0()
	(setvar "CMDECHO" cmho)
	(setvar "HIGHLIGHT" hiht)
	(setvar "BLIPMODE" blde)
	;(setvar "SNAPMODE" snde)
	(setvar "OSMODE" osde)
	;(setvar "PICKFIRST" pist)
)

(defun guanxian(pt rad)
	;(setvar0)	
	(command "layer" "m" "中实线" "")
	(AddCircle pt rad)
	;(command "CIRCLE" pt rad)
	;(vl-cmdf "CIRCLE" pt (* rad 1.1))
	;(setq rad2(* 1.1 rad))
	(AddCircle pt (* rad 1.2))
	;(command "CIRCLE" pt (* rad 1.2))
	(setq pt1(polar pt 0 (* 1.35 rad)))
	(setq pt2(polar pt (/ pi 2) (* 1.35 rad)))
	(setq pt3(polar pt (- pi) (* 1.35 rad)))
	(setq pt4 (polar pt (-(/ pi 2)) (* 1.35 rad)))
	;(command ".LINE" pt1 pt3 "")
	;(command ".LINE" pt2 pt4 "")
	(command "layer" "m" "点划线" "")
	(AddLine pt1 pt3)
	(AddLine pt2 pt4)
	;(vl-cmdf "line" pt1 pt3 "")
	;(vl-cmdf "line" pt2 pt4 "")
	;(princ)
	;(resetvar0)
)
(defun c:pipe()
	;(setvar0)
	(setq pt(getpoint "pick the point:"))
	(initget 7)
	(setq dia(getreal "specify the Diameter of the pipe<1000>:"))
	
	(guanxian pt (/ dia 2.0))
	;(resetvar0)
)
(defun c:dim100()
	(if(not (tblsearch "dimstyle" "dim100"))
		(progn
			(command "DIMSTYLE" "s" "dim100")
			(setdim 100)
			(command "DIMSTYLE" "s" "dim100" "Y")
		)
	)
)
(defun c:dim50()
	(if(not (tblsearch "dimstyle" "dim50"))
		(progn
			(command "DIMSTYLE" "s" "dim50")
			(setdim 50)
			(command "DIMSTYLE" "s" "dim50" "Y")
		)
	)
)
(defun c:txtLine()
	(setq ent(car(entsel "specify a text to line:")))
	(setq elist(entget ent))
	(if (eq (cdr(assoc 0 elist)) "TEXT")
		(progn
			
			(setvar0)
			(setq lay(getvar "clayer"))
			(setq th(cdr(assoc 40 elist)))；字高
			(command "ucs" "entity" ent);改成实体elist坐标系
			;(setq tang(cdr(assoc 50 elist)))
			(setq ptlist(textbox elist))；左下角右上角点位list
			(setq pt1(car ptlist))；左下角
			(setq pt2(cadr ptlist))；右上角
			(setq pt1x(polar pt1 (-  pi) (* 0.1 th)))
			(setq pt2x(list (car pt2) (cadr pt1) (caddr pt2)))
			(setq pt2x(polar pt2x 0 (* 0.1 th)))
			(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.15 th)))
			(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.15 th)))
			(command "layer" "m" "中实线" "")
			(setvar "CECOLOR" "BYLAYER")
			;(setq pt1x(trans pt1x 2 0))
			;(setq pt2x(trans pt2x 2 0))
			;(AddPL2pt pt1x pt2x (* 0.1 th))
			(command "PLINE" pt1x "w" (* 0.1 th) "" pt2x  "")
			(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.2 th)))
			(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.2 th)))
			(command "line" pt1x pt2x "")
			;(AddLine pt1x pt2x)
			(command "ucs" "w")
			(resetvar0)
			(setvar "CLAYER" lay)
		)
		(princ "No text is selected!")
	)
)
(defun c:txtline2()
	(while(setq ent(car(entsel "specify the text:")))
		(terpri)
		(setq elist(entget ent))
		(if(eq (dxf 0 elist) "TEXT")
			(progn
				(setq lay(getvar "CLAYER"))
				(setq th(dxf 40 elist))
				(command "LAYER" "m" "中实线" "")
				(command "ucs" "entity" ent);改成实体elist坐标系
				(setq ptx(dxf 10 elist))
				(setq ptx(ptxy ptx (- (* 0.15 th)) (- (* 0.15 th))))
				(setq dist(txtdis elist))
				
				(AddPL2pt ptx (ptxy ptx (+ dist (* 0.3 th)) 0) (* 0.1 th))
				(setq ptx(ptxy ptx 0 (-(* 0.2 th))))
				(AddLine ptx (ptxy ptx (+ dist (* 0.3 th)) 0))
				(setvar "CLAYER" lay)
				(command "ucs" "p")
			)
		)
	)
	(princ)
)

(defun txtline(txt)
	
	(setvar0)
	(setq elist(entget txt))
	(setq lay(getvar "clayer"))
	(setq th(cdr(assoc 40 elist)))；字高
	(command "ucs" "entity" txt);改成实体elist坐标系
	;(setq tang(cdr(assoc 50 elist)))
	(setq ptlist(textbox elist))；左下角右上角点位list
	(setq pt1(car ptlist))；左下角
	(setq pt2(cadr ptlist))；右上角
	(setq pt1x(polar pt1 (-  pi) (* 0.1 th)))
	(setq pt2x(list (car pt2) (cadr pt1) (caddr pt2)))
	(setq pt2x(polar pt2x 0 (* 0.1 th)))
	(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.15 th)))
	(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.15 th)))
	(command "layer" "m" "中实线" "")
	(setvar "CECOLOR" "BYLAYER")
	;(setq pt1x(trans pt1x 1 0))
	;(setq pt2x(trans pt2x 1 0))
	;(AddPL2pt pt1x pt2x (* 0.1 th))
	(command "PLINE" pt1x "w" (* 0.1 th) "" pt2x  "")
	(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.2 th)))
	(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.2 th)))
	(command "line" pt1x pt2x "")
	
	;(AddLine pt1x pt2x)
	(command "ucs" "w")
	(resetvar0)
	(setvar "CLAYER" lay)
)
(defun c:laytxtline();当前图层text全部划线
	(setq ss(ssget "x" (list (cons 8 (getvar "CLAYER")) (cons 0 "TEXT"))))
	(setq i 0 )
	;(setvar0)
	(setq lay(getvar "CLAYER"))
	(repeat (sslength ss)
		(progn
			(setq ssi(ssname ss i))
			(setq elist(entget ssi))
			(setq th(cdr(assoc 40 elist)))；字高
			(command "ucs" "entity" ssi);改成实体elist坐标系
			;(setq tang(cdr(assoc 50 elist)))
			(setq ptlist(textbox elist))；左下角右上角点位list
			(setq pt1(car ptlist))；左下角
			(setq pt2(cadr ptlist))；右上角
			(setq pt1x(polar pt1 (-  pi) (* 0.1 th)))
			(setq pt2x(list (car pt2) (cadr pt1) (caddr pt2)))
			(setq pt2x(polar pt2x 0 (* 0.1 th)))
			(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.15 th)))
			(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.15 th)))
			(command "layer" "s" "中实线" "")
			(setvar "CECOLOR" "bylayer")
			(AddPL2pt pt1x pt2x (* 0.1 th))
			;(command "PLINE" pt1x "w" (* 0.1 th) "" pt2x  "")
			(setq pt1x(polar pt1x (- (/ pi 2)) (* 0.2 th)))
			(setq pt2x(polar pt2x (- (/ pi 2)) (* 0.2 th)))
			(AddLine pt1x pt2x)
			;(command "line" pt1x pt2x "")
			(setq i(1+ i))
		)
	)
	;(resetvar0)
	(setvar "CLAYER" lay)
)
(defun c:tkList()
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 "TK"))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(setq pt(cdr(assoc 10 elist)))
		(setq ptlist(cons pt ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (car e1) (car e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr e1) (cadr e2)))))
	;(setvar0)
	;(foreach pt ptlist
	;	(command "-plot" "y" "" "Adobe PDF" "A3" "M" "L" "N" "W" 
	;		pt (list (+ (car pt) 420.0) (+ (cadr pt) 297.0) (caddr pt))
	;		"1:1" "C" "Y" "xixian.ctb" "Y" "N" "N" "N" "N" 
	;		"N" "Y" 
	;	)
	;	(princ)
	;)
	;(resetvar0)
	ptlist
)

(defun c:pdflay2(/ ss ptlist i ssi pt fname)
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 "TK-A3") (cons 410 (getvar "CTAB")))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(setq pt(cdr(assoc 10 elist)))
		(setq ptlist(cons pt ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (car e1) (car e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr e1) (cadr e2)))))
	(setvar0)
	(setq i 0)
	(setvar "TILEMODE" 0)
	(setvar "BACKGROUNDPLOT" 0)
	(repeat (length ptlist)
		(setq pt(nth i ptlist))
		(if (equal "17.0s (LMS Tech)" (getvar "ACADVER"))
			(setq pt(list (+ 1.0 (car pt)) (+ 2.0 (cadr pt)) (caddr pt)))
		)
		(setq fname(strcat (getvar "DWGPREFIX") (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-" (itoa (1+ i)) ".pdf"))
		(if(findfile fname) (vl-file-delete fname))
		(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
			pt (list (+ (car pt) 420.0) (+ (cadr pt) 297.0) (caddr pt))
			"1:1" "C" "Y" "xixian.ctb" "Y" "N" "N" "N" fname
			"N" "Y" 
		)
		;(write-line fname scrfile)
		(princ)
		(setq i(1+ i))
	)
	(resetvar0)
)
(defun c:b2p(/ ss ptlist i ssi pt fname)
	(if (= 0 (getvar "TILEMODE"))
		(pdflay)
		(2pdf)
	)
)
(defun ActLay ()
  (vla-get-ActiveLayout
    (vla-get-activedocument
      (vlax-get-acad-object)
    )
  )
)
(defun PlotStyleTableNamesList ()
  (vla-RefreshPlotDeviceInfo (ActLay))
  (vlax-safearray->list
    (vlax-variant-value
      (vla-GetPlotStyleTableNames
        (ActLay)
      )
    )
  )
)
(defun LM:Unique ( l / x r )
	(while l
		(setq x (car l)
			l (vl-remove x (cdr l))
			r (cons x r)
		)
	)
	(reverse r)
)
(defun pdflay(/ ss ptlist i ssi pt fname)
	
	(setq ent(car (entsel "specify the block:")))
	(setq data(entget ent))
	(setq name(cdr(assoc 2 data)))
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 name)(cons 410 (getvar "CTAB")))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(vla-GetBoundingBox (vlax-ename->vla-object ssi) 'minp 'maxp)
		(setq ptx(vlax-safearray->list minp))
		(setq pty(vlax-safearray->list maxp))
		(setq ptlist(cons (list ptx pty) ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (caar e1) (caar e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr(car e1)) (cadr(car e2))))))
	
	
	(if (not *MyPopupLists@);Unique global variable name to store dialog info
    (setq *MyPopupLists@ (list nil "acad.ctb" ))
  );if
  (setq Value1$ (nth 1 *MyPopupLists@)     
		List1@ (LM:Unique (PlotStyleTableNamesList))     
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "pdfdlg" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "txt1" (strcat (itoa (sslength ss) ) " Blocks named" name " were selected!"))
  (set_tile_list "pop1" List1@ Value1$);*Included
	
  (action_tile "pop1" "(set_list_value \"List1@\" \"Value1$\")");*Included
  (action_tile "accept" "(done_dialog)(setq user_click T)")
	(action_tile "cancel" "(done_dialog)(setq user_click nil)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyPopupLists@ (list nil Value1$ ))
  (princ)
	(if user_click
		(progn
			(setvar0)
			(setq i 0)
			(setvar "TILEMODE" 0)
			(setvar "BACKGROUNDPLOT" 0)
			(repeat (length ptlist)
				(setq pt(nth i ptlist))
				(setq p1(car pt) p2(cadr pt))
				(if (equal "17.0s (LMS Tech)" (getvar "ACADVER"))
					(progn
						(setq p1(list (+ 1.0 (car p1)) (+ 2.0 (cadr p1)) (caddr p1)))
						(setq p2(list (+ 1.0 (car p2)) (+ 2.0 (cadr p2)) (caddr p2)))
					)
					
				)
				;(setq fname(strcat (getvar "DWGPREFIX")  (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-" (getvar "CTAB") "-" name "-" (itoa (1+ i)) ".pdf"))
				;(if(findfile fname) (vl-file-delete fname))
				(setq fdir(strcat (getvar "DWGPREFIX") "b2p-" (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-" (getvar "CTAB")))
				(if (null (vl-file-directory-p fdir))(vl-mkdir fdir))
				(setq fname(strcat fdir "\\" name "-" (itoa (1+ i)) ".pdf"))
				(if(findfile fname) (vl-file-delete fname))
				;(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
				;	p1 p2
				;	"f" "C" "Y" "xixian.ctb" "Y" "N" "N" "N" fname
				;	"N" "Y" 
				;)
				(if (equal "23.0s (LMS Tech)" (getvar "ACADVER"))
					(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
						p1 p2
						"f" "C" "Y" (nth 1 *MyPopupLists@) "Y" "A" fname
						"N" "Y" 
					)
					(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
						p1 p2
						"f" "C" "Y" (nth 1 *MyPopupLists@) "Y" "N" "N" "N" fname
						"N" "Y" 
					)
				)
				;(write-line fname scrfile)
				(princ)
				(setq i(1+ i))
			)
			(resetvar0)
		)
	)
)
(defun 2pdf(/ ss ptlist i ssi pt fname)
	
	(setq ent(car (entsel "specify the block:")))
	(setq data(entget ent))
	(setq name(cdr(assoc 2 data)))
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 name)(cons 410 (getvar "CTAB")))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(vla-GetBoundingBox (vlax-ename->vla-object ssi) 'minp 'maxp)
		(setq ptx(vlax-safearray->list minp))
		(setq pty(vlax-safearray->list maxp))
		(setq ptlist(cons (list ptx pty) ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (caar e1) (caar e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr(car e1)) (cadr(car e2))))))
	
	(if (not *MyPopupLists@);Unique global variable name to store dialog info
    (setq *MyPopupLists@ (list nil "acad.ctb" ))
  );if
  (setq Value1$ (nth 1 *MyPopupLists@)     
		List1@ (LM:Unique (PlotStyleTableNamesList))     
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "pdfdlg" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "txt1" (strcat (itoa (sslength ss)) " Blocks named" name " were selected!"))
  (set_tile_list "pop1" List1@ Value1$);*Included
	
  (action_tile "pop1" "(set_list_value \"List1@\" \"Value1$\")");*Included
  
	(action_tile "accept" "(done_dialog)(setq user_click T)")
	(action_tile "cancel" "(done_dialog)(setq user_click nil)")
	
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyPopupLists@ (list nil Value1$ ))
  (princ)
	
	
	(if user_click
		(progn
			(setvar0)
			(setq i 0)
			(setvar "TILEMODE" 1)
			(setvar "BACKGROUNDPLOT" 0)
			(repeat (length ptlist)
				(setq pt(nth i ptlist))
				(setq p1(car pt) p2(cadr pt))
				(if (equal "17.0s (LMS Tech)" (getvar "ACADVER"))
					(progn
						(setq p1(list (+ 0.01 (car p1)) (+ 0.02 (cadr p1)) (caddr p1)))
						(setq p2(list (+ 0.01 (car p2)) (+ 0.02 (cadr p2)) (caddr p2)))
					)
				)
				;(setq fname(strcat (getvar "DWGPREFIX") (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-"  name  "-" (itoa (1+ i)) ".pdf"))
				;(if (findfile fname) (vl-file-delete fname))
				
				(setq fdir(strcat (getvar "DWGPREFIX") "b2p-" (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-" (getvar "CTAB") ))
				(if (null (vl-file-directory-p fdir))(vl-mkdir fdir))
				(setq fname(strcat fdir "\\" name "-" (itoa (1+ i)) ".pdf"))
				(if(findfile fname) (vl-file-delete fname))
				;(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
				;	p1 p2
				;	"f" "C" "Y" "xixian.ctb" "Y" "N" "N" "N" fname
				;	"N" "Y" 
				;)
				(if (equal "23.0s (LMS Tech)" (getvar "ACADVER"))
					(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
						p1 p2
						"f" "C" "Y" (nth 1 *MyPopupLists@) "Y" "A" fname
						"N" "Y" 
					)
					(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
						p1 p2
						"f" "C" "Y" (nth 1 *MyPopupLists@) "Y" "a"  fname
						"N" "Y" 
					)
				)
				;(write-line fname scrfile)
				(princ)
				(setq i(1+ i))
			)
			(resetvar0)
		)
	)
)
(defun c:pdf4()
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 "tk")(cons 410 (getvar "CTAB")))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(vla-GetBoundingBox (vlax-ename->vla-object ssi) 'minp 'maxp)
		(setq ptx(vlax-safearray->list minp))
		(setq pty(vlax-safearray->list maxp))
		(setq ptlist(cons (list ptx pty) ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (caar e1) (caar e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr(car e1)) (cadr(car e2))))))
	(setvar0)
	(setq i 0)
	(setvar "TILEMODE" 1)
	;(setvar "BACKGROUNDPLOT" 0)
	(repeat (length ptlist)
		(setq pt(nth i ptlist))
		(setq p1(car pt) p2(cadr pt))
		(if (equal "17.0s (LMS Tech)" (getvar "ACADVER"))
			(progn
				(setq p1(list (+ 0.01 (car p1)) (+ 0.02 (cadr p1)) (caddr p1)))
				(setq p2(list (+ 0.01 (car p2)) (+ 0.02 (cadr p2)) (caddr p2)))
			)
		)
		(setq fname(strcat (getvar "DWGPREFIX") (vl-string-right-trim ".dwg" (getvar "DWGNAME")) "-" (itoa (1+ i)) ".pdf"))
		(if (findfile fname) (vl-file-delete fname))
		
		;(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
		;	p1 p2
		;	"f" "C" "Y" "xixian.ctb" "Y" "N" "N" "N" fname
		;	"N" "Y" 
		;)
		(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
			p1 p2
			"f" "C" "Y" "xixian.ctb" "Y" "a"  fname
			"N" "Y" 
		)
		;(write-line fname scrfile)
		(princ)
		(setq i(1+ i))
	)
	(resetvar0)
)
(defun c:pdfmodel(/ ss ptlist ssi elist i pt fname )
	(setq ss(ssget "x" (list (cons 0 "INSERT") (cons 2 "tk") (cons 410 (getvar "CTAB")))))
	(setq ptlist nil i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq elist(entget ssi))
		(setq pt(cdr(assoc 10 elist)))
		;(setq pt(trans pt 2 1))
		(setq ptlist(cons pt ptlist))
		(setq i(1+ i))
	)
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (< (car e1) (car e2)))))
	(setq ptlist(vl-sort ptlist '(lambda (e1 e2) (> (cadr e1) (cadr e2)))))
	;(setvar0)
	(setq i 0)
	(setvar "TILEMODE" 1)
	(repeat (length ptlist)
		(setq pt(nth i ptlist))
		(setq p1(car pt) p2(cadr pt))
		;(if (equal "17.0s (LMS Tech)" (getvar "ACADVER"))
		;	(setq p1(list (+ 1.0 (car p1)) (+ 2.0 (cadr p1)) (caddr p1)))
		;	(setq p2(list (+ 1.0 (car p2)) (+ 2.0 (cadr p2)) (caddr p2)))
		;)
		;(setq pt(list (+ 100.0 (car pt)) (+ 200.0 (cadr pt)) (caddr pt)))
		(setq fname(strcat (getvar "DWGPREFIX") (vl-string-trim ".dwg" (getvar "DWGNAME")) "-" (itoa (1+ i)) ".pdf"))
		;(command "-plot" "y" "模型" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
		;	pt (list (+ (car pt) 420.0) (+ (cadr pt) 297.0) (caddr pt))
		;	"1:1" "C" "Y" "xixian.ctb" "Y" "W"  fname
		;	"N" "Y" 
		;)
		(command "-plot" "y" "" "DWG To PDF.pc3" "ISO A3 (420.00 x 297.00 毫米)" "M" "L" "N" "W" 
			p1 p2
			"f" "C" "Y" "xixian.ctb" "Y" "a"  fname
			"N" "Y" 
		)
		;(write-line fname scrfile)
		;(princ)
		(setq i(1+ i))
	)
	;(resetvar0)
)

(defun setdim(ds /)
	
	;(command "STYLE" "fsdb" "fsdb_e,fsdb" 0 0.75 0 "N" "N" "N")
	;About lines:
	(SETVAR "DIMCLRD" 256) 
	(setvar "DIMLTYPE" "bylayer")
	(setvar "DIMLWD" -1);enum bylayer,-2 byblock
	(setvar "DIMDLE" 0)
	(setvar "DIMDLI" 7)	
	(setvar "DIMSD1" 0)
	(setvar "DIMSD2" 0)
	(setvar "DIMCLRE" 256)
	(setvar "DIMLTEX1" "bylayer")
	(setvar "DIMLTEX2" "bylayer")
	(setvar "DIMLWE" -1);enum bylayer,-2 byblock
	(setvar "DIMSE1" 0)
	(setvar "DIMSE2" 0)
	(setvar "DIMEXE" 1)
	(setvar "DIMEXO" 1)
	(setvar "DIMFXLON" 1)
	(setvar "DIMFXL" 4)
	; End lines;
	
	;About Symbols and Arrows 
	(setvar "DIMBLK" "_OBLIQUE")
	(setvar "DIMBLK1" "_OBLIQUE");_ is necessary
	(setvar "DIMBLK2" "_OBLIQUE");_ is necessary
	(setvar "DIMLDRBLK" "_BOXFILLED");_ is necessary
	(setvar "DIMASZ" 1.5)
	(setvar "DIMCEN" 0);no center mark or line are drawn
	(setvar "DIMARCSYM" 0)
	;(setvar "DIMJOGANG" 90)
	(command "dimjogang" 90)
	;*******************************************************
	;break size
	;*******************************************************
	;jog height factor
	;End Symbols
	
	;About Text
	(setvar "DIMTXSTY" "fsdb")
	(setvar "DIMCLRT" 256)
	(setvar "DIMTFILL" 0)
	(setvar "DIMTXT" 2.5)
	(setvar "DIMTFAC" 1)
	(setvar "DIMGAP" 0.5)
	
	(setvar "DIMTAD" 1)
	(setvar "DIMJUST" 0)
	;(setvar "dimtxtdirection" 0);left to right
	(setvar "DIMTIH" 0);which I frankly don't understand
	(setvar "DIMTOH" 0);the same as above
	;End Text 
	
	;About Fit
	;(setvar "DIMATFIT" )
	(setvar "DIMTIX" 1)
	(setvar "DIMSOXD" 0)
	(setvar "DIMTMOVE" 2)
	(setvar "DIMSCALE" ds)
	(setvar "DIMUPT" 0)
	(setvar "DIMTOFL" 1)	
	;End Fit 
	
	;About Primary Unit
	(setvar "DIMLUNIT" 2)
	(setvar "DIMDEC" 1);the primary of the dimension
	(setvar "DIMFRAC" 0);0 Horizontal stacking 1 Diagonal stacking 2 Not stacked (for example, 1/2)
	(setvar "DIMDSEP" ".")
	(setvar "DIMRND" 0.0000)
	(setvar "DIMPOST" "<>")
	(setvar "DIMLFAC" 1)
	(setvar "DIMZIN" 8)
	(setvar "DIMAUNIT" 0)
	(setvar "DIMADEC" 1)
	(setvar "DIMAZIN" 3)
	;End Primary Unit 
	
	;Alternate Units 
	(setvar "DIMALT" 0)
	;(setvar "DIMALTU" )
	;(setvar "DIMALTD" )
	;(setvar "DIMALTF" )
	;(setvar "DIMALTRND" )
	;(setvar "DIMALTZ" )
	;(setvar "DIMAPOST" )
	;End Alternate Units
	
	;Tolerances
	(setvar "DIMTOL" 0)
	;(setvar "DIMTDEC" )
	;(setvar "DIMTP" )
	;(setvar "DIMTM" )
	;(setvar "DIMTFAC" )
	(setvar "DIMTOLJ" 1)
	;(setvar "DIMTZIN" )
	;(setvar "DIMALTTD" )
	;(setvar "DIMALTTZ" )
	;End Tolerances
	
)
(defun c:rxw()
	(setq pa(getpoint "first point:"))
	(terpri)
	(setq pb(getpoint "middle point:"))
	(terpri)
	(setq pc(getpoint "third point:"))
	(terpri)
	(setq pc(polar pb (angle pb pc) 100))//单位mm
	(command "PLINE" pa pb pc "")
)

(defun c:695()
	(setvar "OSMODE" 695)
)
(vl-load-com)