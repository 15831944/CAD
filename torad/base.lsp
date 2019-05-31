(defun C:trans2d ()
    (setq AcadObject (vlax-get-acad-object))
    (setq AcadDocument (vla-get-ActiveDocument Acadobject))
    (setq mSpace (vla-get-ModelSpace Acaddocument))
  
    (Prompt "\n选择要转换的三维多段线: ")
    (setq ss (ssget '((0 . "POLYLINE")))
          i  0
    )
    (while (setq ee (ssname ss i))
      (setq obj (vlax-ename->vla-object ee))
      (setq pts (vlax-variant-value (vla-get-coordinates obj)))
      (vla-AddPolyline mSpace pts)
      (setq i (1+ i))
    )
    (princ)
)
(defun ukword(bit kwd msg def / inp)
	(if (and def (/= def " "))
		(setq msg(strcat "\n" msg "<" def ">:")
			bit(- bit (boole 1 bit 1))
		)
		(if (= " "　(substr msg (strlen msg) 1))
			(setq msg(strcat "\n" (substr msg 1 (1- (strlen msg))) ":"))
			(setq msg(strcat "\n" msg ":"))
		);消除string末尾空格，典型的脱裤子放屁
	)
	(initget bit kwd)
	(setq inp(getkword msg))
	(if inp inp def)
)
(defun online(en pt)
	(setq anyway 1)
	(cond 
		((equal pt (vlax-curve-getClosestPointTo en pt) 1e-6) (setq anyway 1));在线上
		((equal (angle pt (vlax-curve-getStartPoint en)) (angle pt (vlax-curve-getEndPoint en)) 1e-6) (setq anyway 0));在延长线上
		(T (setq anyway -1));不在线上
	)
	anyway
)
(defun tan(a)
	(/ (sin a) (cos a))
)

(defun c:bklist()
	;(setq ent(car (entsel "specify the block:")))
	(while
		(progn
			(setq ent(car(entsel "\n specify the block:")))
			(and ent 
				(/= "INSERT" (dxf 0 (entget ent)))
			)
		)
	)
	(setq data(entget ent))
  (setq name(cdr(assoc 2 data)))
	(setq ss(ssget "X" (list (cons 0 "INSERT") (cons 2 name))))
	(setq i 0 alist nil)
	;(setq dimzin1(getvar "DIMZIN"))
	;(setvar "DIMZIN" 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq data(entget ssi))
		(setq alist(cons (dxf 10 data) alist))
		(setq i(1+ i))
	)
	;(princ (length alist))
	(foreach pt alist
		(princ(strcat
						(strcat "X=" (rtos (car pt) 2 4))
						(strcat "Y=" (rtos (cadr pt) 2 4))
						;(strcat "Z=" (rtos (caddr pt) 2 4))
						"\n"
					))
	)
	;(setvar "DIMZIN" dimzin1)
	;alist
)
;
; -- Function MeGetInters
; Returns all intersection points between two objects.
; Copyright:
;   ?2000 MENZI ENGINEERING GmbH, Switzerland
; Arguments [Type]:
;   Fst = First object [VLA-OBJECT]
;   Nxt = Second object [VLA-OBJECT]
;   Mde = Intersection mode [INT]
;         Constants:
;         - acExtendNone           Does not extend either object.
;         - acExtendThisEntity     Extends the Fst object.
;         - acExtendOtherEntity    Extends the Nxt object.
;         - acExtendBoth           Extends both objects.
; Return [Type]:
;   > List of points '((1.0 1.0 0.0)... [LIST]
;   > Nil if no intersection found
; Notes:
;   - None
; 
(defun c:fangsong()
	(setq styleList(tnlist "Style"))
	(vl-remove "FSDB" styleList)
	(vl-remove "Standard" styleList)
	(vl-remove "Annotative" styleList)
	(foreach x  styleList
		(command "STYLE" x "FANGSONG_GB2312_0.ttf" 0 0.75 0 "N" "N" "N")
	)
)
(defun c:t075()
	(setq ss(ssget "x" (list (cons 0 "TEXT"))))
	(setq i 0)
	(repeat (sslength ss)
		(setq ssi(ssname ss i))
		(setq olddata(entget ssi))
		(setq newdata(subst (cons 41 0.75) (assoc 41 olddata) olddata))
		(entmod newdata)
		(setq i(1+ i))
	)
)
(defun GetInters(Fst,Nxt,Mde / IntLst PntLst)
	(setq IntLst(vlax-invoke Fst 'IntersectWith Nxt Mde))
	(cond 
		(IntLst
			(repeat (/ (length IntLst) 3)
				(setq PntLst(cons (list (car IntLst) (cadr IntLst) (caddr IntLst) PntLst))
					IntLst(cdddr IntLst)
				)
			)
			(reverse PntLst)
		)
		(T nil)
	)
)
;删除以str开头的layout
(defun dello(str)
	(setq nlen(strlen str) alist nil)
	(foreach ilo (layoutlist)
		(progn
			(if (= str (substr ilo 1 nlen)) 
				(command "LAYOUT" "d" ilo "" "")
			)
		)
	)
	
)
(defun kplo(strlist)
	(setq b(layoutlist))
	(foreach ilo (layoutlist)		
		(foreach str strlist
			(progn
				(setq nlen(strlen str))
				(if (= (strcase str) (substr (strcase ilo) 1 nlen))
					(setq b (vl-remove ilo b))
				)
			)
		)		
	)
	
	(foreach i b 
		(command "LAYOUT" "d" i "")
	)
)

(defun c:sl2()
	(mlayer "EXTERNAL" 1 "continuous")
	(mlayer "MATERIAL" 2 "continuous")
	(mlayer "NONCIRC_SURFACE" 3 "continuous")
	(mlayer "ANCHOR" 4 "continuous")
)
(defun c:LWP2P()
	(setq LWP(ssget "x" (list (cons 0 "LWPOLYLINE"))))
	(command "CONVERTPOLY" "h" LWP "")
)
(defun tnlist(tbname / xyy-tdata tblist)
	(while(setq xyy-tdata(tblnext tbname (not xyy-tdata)))
		(setq tblist(append tblist (list (cdr(assoc 2 xyy-tdata)))))
	)
)
(defun bnames()
	;(setq lista(tnlist "block"))
	(vl-remove-if '(lambda(x) (wcmatch x "*D*,*X*,*U*")) (tnlist "block"))
)
(defun tdlist(tbname / xyy-tdata tblist)
	(while (setq xyy-tdata(tblnext tbname (not xyy-tdata)))
		(setq tblist(append tblist (list xyy-tdata)))
	)
)
(defun ptxy(basePt xdist ydist)
	(list (+ (car basePt) xdist) (+ (cadr basePt) ydist) (caddr basePt))
)
(defun mlayer(name color lstyle)
	;(command "LAYER" "m" name "c" color  name "l" lstyle name "")
	(if(tblsearch "layer" name) 
		(command "layer" "s" name "")
		(progn
			(command "LAYER" "m" name)
			(if color (command "c" color name))
			(if lstyle (command "lt" lstyle name))
			(command "")
		)
	)
	(princ)
)
(defun mdim(name)
	(if(tblsearch "dimstyle" name)
		(command "DIMSTYLE" "R" name)
		(command "dim" "dimadec" "0"
			"dimalt" "off"
			;;
			"save"  name 
			"exit"
		)
	)
)
(defun dxf(code edata)
	(cdr(assoc code edata))
)
(defun txtdis(txtelist)
	(caadr(textbox txtelist))
)
(defun dtor(angle)
	(/ (* angle pi) 180)
)
(defun rtod(angle)
	(/ (* angle 180) pi)
)
(defun AddLine(pt1 pt2)
	(entmakex(list (cons 0 "LINE") (cons 10 pt1) (cons 11 pt2)))
)
(defun AddPL2pt(pt1 pt2 pwidth)
	(entmakex(list(cons 0 "LWPOLYLINE")(cons 100 "AcDbEntity")(cons 100 "AcDbPolyline")
						 (cons 90 2)(cons 40 pwidth)(cons 41 pwidth)(cons 43 pwidth) (cons 10 pt1)(cons 10 pt2)))
)
;(defun AddRectang(pt1 pt2 pwidth)
;	(AddPLpts (list pt1 (list (car pt2) (cadr pt1) (caddr pt1)) pt2 
;											(list (car pt1) (cadr pt2) (caddr pt2) pt1)) pwidth)
;)  dxf组码不对
(defun AddPLpts(ptlst pwidth)
	(entmakex (append (list (cons 0 "LWPOLYLINE") (cons 100 "AcDbEntity")
											(cons 40 pwidth)(cons 41 pwidth)(cons 43 pwidth)
											(cons 100 "AcDbPolyline") (cons 90 (length ptlst)))
							(mapcar '(lambda (pt) (cons 10 pt)) ptlst)))
)
(defun AddCircle(pt r)
	(entmakex(list (cons 0 "CIRCLE") (cons 10 pt) (cons 40 r)))
)
(defun AddArc(pt r ang1 ang2)
	(entmakex(list (cons 0 "ARC") (cons 10 pt) (cons 40 r)
						 (cons 50 ang1) (cons 51 ang2)))
)
(defun AddText(pt str txtstyle  height pwidth)
	(entmakex(list (cons 0 "TEXT") (cons 1 str)(cons 10 pt)(cons 40 height)(cons 7 txtstyle)
						 (cons 41 pwidth)(cons 11 pt) (cons 72 1)(cons 73 2)))
);创建文字72水平居中 73垂直居中
(defun AddMText(pt str)
	(entmakex(list (cons 0 "MTEXT") (cons 100 "AcDbEntity") (cons 100 "AcDbMText")
						 (cons 10 pt) (cons 1 str)))
)
(defun AddRadial(cen pt)
	(entmakex(list(cons 0 "DIMENSION") (cons 100 "AcDbEntity") (cons 100 "AcDbDimension")
						 (cons 100 cen) (cons 70 36) (cons 100 "AcDbRadialDimension") (cons 15 pt)))
)
(defun AddDiametric(p1 p2 txtpt)
	(entmakex(list (cons 0 "DIMENSION") (cons 100 "AcDbEntity")(cons 100 "AcDbDimension")
						 (cons 10 p1)(cons 11 txtpt)(cons 70 163)(cons 100 "AcDbDiametricDimension")
						 (cons 15 p2)))
)
(defun AddDimensionH(p1 p2 txtpt)
	(entmakex(list (cons 0 "DIMENSION")(cons 100 "AcDbEntity")(cons 100 "AcDbDimension")
						 (cons 10 txtpt) (cons 70 32) (cons 1 "") (cons 100 "AcDbAlignedDimension")
						 (cons 13 p1)(cons 14 p2)(cons 100 "AcDbRotateDimension")))
)
(defun AddDimensionV(p1 p2 txtpt)
	(entmakex(list (cons 0 "DIMENSION")(cons 100 "AcDbEntity")(cons 100 "AcDbDimension")
						 (cons 10 txtpt) (cons 70 32) (cons 1 "") (cons 100 "AcDbAlignedDimension")
						 (cons 13 p1)(cons 14 p2)(cons 50 1.5708)(cons 100 "AcDbRotatedDimension")))
);1.5708=pi/2
(defun AddAlignedDim(p1 p2 txtpt)
	(entmakex (list(cons 0 "DIMENSION")(cons 100 "AcDbEntity")(cons 100 "AcDbDimension")
							(cons 10 txtpt)(cons 70 33)(cons 1 "")(cons 100 "AcDbAlignedDimension")
							(cons 13 p1)(cons 14 p2)))
)
(defun AddBlkRef(name pt)
	(entmakex(list (cons 0 "INSERT")(cons 2 name)(cons 10 pt)))
)