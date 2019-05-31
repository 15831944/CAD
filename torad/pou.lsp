(defun c:pouguanxian()
	(setvar0)
	(setq fl(open (strcat (getvar "DWGPREFIX") "pou.dat") "r"))
	(setq dclist(read(read-line fl)))
	(setq ptstart(getpoint "specify the starting point:"))
	(setq nameList(mapcar '(lambda(x) (car x)) dclist))
	(setq argulist(mapcar '(lambda(x) (strcat (cadr x) "   " (caddr x))) dclist))
	(setq distList(mapcar '(lambda(x) (cadddr x)) dclist))
	(setq gxList(read(read-line fl)))
	(setq jkList(read(read-line fl)))
	(setq dibuList(read(read-line fl)))
	(close fl)
	(setq gxname (car gxList)
		gxdia(cadr gxList)
		gxdeep(caddr gxList)
		dispdeep(cadddr gxList)
		dist1(cadddr(cdr gxList))
		dist2(cadddr(cdr(cdr gxList)))		
	)
	(setq distm(* 0.6 gxdia))
	(setq zcdeep(cadr(car jkList))
		pilename(car(cadr jkList))
		pilelength(cadr(cadr jkList))
	)
	(setq dcdeep(cadr(car dibuList)))
	(setq cldeep(cadr(cadr dibuList)))
	(setq jkwide(+ dist1 dist2 (* 2.0 distm)))
	(setq ptrad(polar ptstart (/ pi 2) (+ dcdeep distm)))
	(setq pilelength(* 1000.0 pilelength))
	(if(> (apply '+ distList) 15.0) 
		(progn
			(setq templist(cdr(reverse distList)))
			(setq k(- 15.0 (apply '+ templist)))
			(setq k(max k 2.0))
			(setq distList(reverse (cons k templist)))
		)
	)
	(setq vdir(getvar "VIEWDIR"))
	(setq ptstart(trans ptstart 1 vdir))
	;(setq ptstart(trans ptstart 0 1))
	(setq distList(mapcar '(lambda(x) (* x 1000.0)) distList))
	(setq i 0 pt(ptxy ptstart (- (+ 3140 dist1 distm)) gxdeep))
	;(setq i 0 pt (list (- (car ptstart) 3140 dist1 distm) (+ (cadr ptstart) gxdeep); (caddr ptstart));)
	(command "layer" "m" "diceng" "c" 8 "" "")
	(AddLine pt (polar pt (- (/ pi 2.0)) (apply '+ distList)))
	;(command "line" pt (polar pt (- (/ pi 2.0)) (apply '+ distList)) "")
	(repeat (length distList)
		;(command "line" pt (polar pt (- pi) 2300) "")
		(AddLine pt (polar pt (- pi) 2300))
		(setq pt1(ptxy pt -1150.0 (- (/ (nth i distList) 2.0))))
		;(setq pt1(list (- (car pt) 1150.0)  
		; (- (cadr pt) (/ (nth i distList)2.0)) (caddr pt)))
		(setq pt1up(polar pt1 (/ pi 2) 200.0))
		(setq pt1down(polar pt1 (- (/ pi 2)) 200.0))
		(AddText pt1up (nth i nameList) "ZWbrg" 300 0.75)
		(AddText pt1down(nth i argulist) "ZWbrg" 300 0.75)
		;(command "TEXT" "j" "m" pt1up 300 0 (nth i nameList) "")
		;(command "TEXT" "j" "m" pt1down 300 0 (nth i argulist) "")
		(setq pt(polar pt (-(/ pi 2)) (nth i distList)))
		(setq i(1+ i))
	)
	(command "LAYER" "m" "��ʵ��" "")
	(setq mid(polar ptstart 0 (/ (- dist2 dist1) 2)))
	(setq midup(polar mid (/ pi 2) 100))
	(setq ptleft(list (- (car ptstart) distm dist1) (+ (cadr ptstart) gxdeep) (caddr ptstart)))
	(setq ptleft(trans ptleft 1 vdir))
	(command "RECTANG"
		ptleft
		(ptxy ptleft -340.0 (- pilelength))
	)
	(command "MIRROR" (entlast) "" mid midup "N")
	;(command "INSERT" "gyl"  
	;	(ptxy ptleft 137.0 -1000.0)
	;	(list (+ (car ptleft) 137.0) (- (cadr ptleft) 1000.0) (caddr ptleft))
	;	"1" "" "0"
	;)
	(AddBlkRef "gyl" (ptxy ptleft 137.0 (- zcdeep)))
	(command "MIRROR" (entlast) "" mid midup "N")
	(setq ptzc(ptxy ptleft 274.0 (- (/ 273 2.0) zcdeep)))
	;(setq ptzc(list (+ (car ptleft) 274.0)(- (cadr ptleft) 863.5) (caddr ptleft) ))
	;(setq ptzc2(list (+ (car ptzc) (- jkwide 548.0)) (- (cadr ptzc) 273.0) (caddr ptzc)))
	(setq ptzc2(ptxy ptzc (- jkwide 548.0) -273.0))
	(command "RECTANG" ptzc ptzc2)
	
	(command "LAYER" "m" "ϸʵ��" "")
	(AddBlkRef "weilan" (ptxy ptleft -340.0 0.0))
	(command "MIRROR" (entlast) "" mid midup "N")
	(AddBlkRef "dbg" (ptxy ptstart (+ dist2 distm 340.0) 0.0))
	;(command "line" (ptxy ptstart (- (+ dist1 distm)) 0)
	;	(ptxy ptstart (+ distm dist2) 0) ""
	;)
	(AddLine (ptxy ptstart (- (+ dist1 distm)) 0) (ptxy ptstart (+ distm dist2) 0))
	(setq e1(entlast))
	(command "OFFSET"  dcdeep e1  ptrad "")
  (if (equal 0.0 cldeep)
		(progn
			;(AddRectang (ptxy ptstart (-(+ distm (/ dist1 2.0) 100.0)) 0)
			;	(ptxy ptstart (-(+ distm (/ dist1 2.0) -100.0)) -200.0) 0
			;)
			(setq p1(ptxy ptstart (-(+ distm (/ dist1 2.0) 100.0)) 0))
			(setq p2(ptxy ptstart (-(+ distm (/ dist1 2.0) -100.0)) -200.0))
			(command "RECTANG" p1 p2 )
			(AddText (ptxy ptstart (-(+ dist1 distm 1340.0)) -1000.0) 
				"��ʯä��200x200" "ZWbrg" 300 0.75)		
			(setq ptx(cdr(assoc 10 (entget(entlast)))))
			(setq dist3(caadr(textbox(entget(entlast))))) 
	  	(AddPLpts (list ptx (ptxy ptx dist3 0)
									(ptxy ptstart (-(+ distm (/ dist1 2.0))) -100.0)) 0)
		)
		(progn
			(command "OFFSET" cldeep e1 (ptxy ptstart 0 -100) "")
			;(AddRectang (ptxy ptstart (- (+ dist1 distm)) (- cldeep))
			;	(ptxy ptstart (+ dist2 distm) 0) 0
			;)
			(AddPLpts (list (ptxy ptstart (- (+ dist1 distm)) (- cldeep))
									(ptxy ptstart (+ dist2 distm) (- cldeep))
									(ptxy ptstart (+ dist2 distm) 0)
									(ptxy ptstart (- (+ distm dist1))0)
									(ptxy ptstart (- (+ dist1 distm)) (- cldeep))
								) 0)
			(setq e3(entlast))
			(command "HATCH" "gravel" 10 0 e3 "")
			(command "ERASE" e3 "")
			;(command "BHATCH" (ptxy ptstart 0 -100.0) "p" "gravel" 10 0 "")
			(AddText (ptxy ptstart (-(+ dist1 distm 1340.0)) (- (/ cldeep 2.0)))
				(strcat (rtos (/ cldeep 1000.0) 2) "m��ɰʯ�ϻ���") "ZWbrg" 300 0.75
			)
			(setq ptx(cdr(assoc 10 (entget(entlast)))))
			(setq dist3(caadr(textbox(entget(entlast))))) 
			(AddLine ptx (ptxy ptx (+ 1340 dist3) 0))
		)
	)
	(setq txtpt1(ptxy mid 0 (+ gxdeep 3100.0)))
	(setq txtpt2(ptxy mid 0 (+ gxdeep 3500.0)))
	(setq txtpt3(ptxy mid 0 (+ gxdeep 4200.0)))
	(setq txtpt4(ptxy ptleft (- 2050.0) 2150.0 ))
	(setq txtpt5(ptxy ptleft (+ dist1 dist2 (* 2 distm) 2050.0) 2150.0))
	;(command "TEXT" "j" "m" txtpt1 300 0 "������W1-W2����" "")
	;(command "TEXT" "j" "m" txtpt2 300 0 "1:100" "")
	;(command "TEXT" "j" "m" txtpt3 300 0 "�ܵ����۸ְ�׮֧����׼�����ͼ(һ)" "")
	
	;(command "TEXT" "j" "m" txtpt4 300 0 "Χ��" "")
	;(command "TEXT" "j" "m" txtpt5 300 0 "Χ��" "")
	;(apply 'AddText (list (txtpt1 "������W1-W2����" 300) (txtpt2 "1:100" 300)
	;				(txtpt3 "�ܵ����۸ְ�׮֧����׼�����ͼ(һ)" 300) ))
	(AddText txtpt1 "������W1-W2����"  "ZWbrg" 300  0.75)
	(AddText txtpt2 "1:100"  "ZWbrg" 300  0.75)
	(AddText txtpt3 "�ܵ����۸ְ�׮֧����׼�����ͼ(һ)"  "ZWbrg" 500  0.75)
	(setq txte1(entlast))
	(AddText txtpt4 "Χ��"  "ZWbrg"  300  0.75)
	(AddText txtpt5 "Χ��"  "ZWbrg"  300  0.75)
	(AddText (ptxy ptrad (- (+ dist1 distm 340.0 850.0)) 800.0)
		(strcat gxname "d=" (itoa gxdia)) "ZWbrg" 300 0.75
	)
	;(setq da(entget(entlast)))
	(setq ptx(cdr(assoc 10 (entget(entlast)))))
	(setq dist3(caadr(textbox(entget(entlast)))))
  (AddPLpts (list ptx (ptxy ptx dist3 0) ptrad) 0.0)
	(AddText (ptxy ptstart (- (+ dist1 distm 340.0 1300.0)) -2500.0)
		pilename "ZWbrg" 300 0.75
	)
	(setq ptx(cdr(assoc 10 (entget(entlast)))))
	(setq dist3(caadr(textbox(entget(entlast)))))
  (AddPLpts (list ptx (ptxy ptx dist3 0) (ptxy ptx (+ dist3 500.0) 300.0)) 0.0)	
	(AddText (ptxy ptstart (- (+ dist1 distm 340.0 1300.0)) -2800.0)
		(strcat "׮��" (itoa (fix (/ pilelength 1000))) "m") "ZWbrg" 300 0.75
	)
	(AddText (ptxy ptstart (+ dist2 distm 340.0 1500.0) -2500.0)
		pilename "ZWbrg" 300 0.75
	)
	
	(setq ptx(cdr(assoc 10 (entget(entlast)))))
	(setq dist3(caadr(textbox(entget(entlast)))))
	(AddPLpts (list (ptxy ptx (- 700.0) 300.0) ptx (ptxy ptx dist3 0.0)) 0.0)
	(AddText (ptxy ptstart (+ dist2 distm 340.0 1500.0) -2800.0)
		(strcat "׮��" (itoa (fix (/ pilelength 1000))) "m") "ZWbrg" 300 0.75
	)
	; (AddDimensionH (ptxy ptstart (- (+ dist1 distm)) 0)
	;	(ptxy ptstart (- distm) 0) (ptxy ptstart (- (+ distm (/ dist1 2.0))) 0)
	;) 
	(command "DIMLINEAR" (ptxy ptstart (-(+ dist1 distm)) 0)
		(ptxy ptstart (- distm) 0) "h" "@-1500,-2000"
	)
	(command "DIMLINEAR" (ptxy ptstart (- distm) 0)
		(ptxy ptstart (+ distm ) 0) "h" "@-1500,-2000"
	)
	(command "DIMLINEAR" (ptxy ptstart  distm 0)
		(ptxy ptstart (+ dist2 distm) 0) "h" "@1500,-2000"
	)
	(command "DIMLINEAR" (ptxy ptstart (-(+ dist1 distm)) 0)
		(ptxy ptstart (+ distm dist2) 0) "h" "@-2500,-2500"
	)
	(command "DIMLINEAR" (ptxy ptleft -340 0)
		(ptxy ptleft -1340 0) "h" "@-500,-500"
	)
	(command "DIMLINEAR" (ptxy ptleft (+ dist1 dist2 distm distm 340)0)
		(ptxy ptleft (+ dist1 dist2 distm distm 1340)0) "h" "@500,-500"
	)
	(command "DIMLINEAR" (ptxy ptleft (+ dist1 dist2 distm distm 340.0) 0)
		(ptxy ptstart (+ dist2 distm 340.0) 0) "T" dispdeep "v" "@1300,3000"
	)
	(command "DIMLINEAR" ptleft
		(ptxy ptleft 0 (- zcdeep)) "v" (strcat "@-1500," (rtos (/ zcdeep 2.0)))
	)
	(guanxian ptrad (/ gxdia 2.0))
	(command "LAYER" "m" "�㻮��" "")
	(AddLine (ptxy ptleft 0 (- zcdeep)) 
		(ptxy ptleft (+ dist1 dist2 distm distm) (- zcdeep)))
	(resetvar0)
	(txtline txte1)
	distList
)
(setq kkk 1.0)
(setq maoganchang 8)
(setq maosuoa 8 maosuob 8)
(defun chmgan(a ,b)
	(setq kkk a 
		maoganchang b
	)
)
(defun chmsuo(a,b,c)
	(setq kkk a 
		maosuoa b maosuob c
	)
)
(defun mid(a b)
	(setq pt(polar a (angle a b) (/ (distance a b) 2.0)))
)
(defun c:mgan()
	(setq p1(getpoint "�ײ����: \n"))
	(setq p2(getpoint "�ϲ�����: \n"))
	(setq dist(distance p1 p2)
		ang(angle p1 p2)
	)
	(setq maoganchang1(* kkk maoganchang))
	(setq dist1(/ dist 25.0) dist2(/ dist 3.0))
	(setq pt1(polar p1 ang (/ dist1 2.0))
		pt2(polar pt1 ang dist2)
		pt3(polar pt2 ang dist2)
		ptmid(mid p1 p2)
	)
	(if (>= ang (/ pi 2))
		(progn(setq pt11(polar ptmid (- ang (/ pi 2)) (* dist 0.16))
						pt12(ptxy pt11 (* dist 0.5) 0)
						ang1(dtor 200)
					)
			;(AddText (ptxy pt11 0 (/ 1.25 2.0)) "ê�˿����" "Standard" 1.25 0.7)
			;(AddText (ptxy pt11 0 (- (/ 1.25 2.0))) (strcat "ƽ������" (rtos maoganchang) "m") "Standard" 1.25 0.7)
			
		)
		(progn(setq pt11(polar ptmid (+ ang (/ pi 2)) (* dist 0.16))
						pt12(ptxy pt11 (- (* dist 0.5)) 0)
						ang1(- (dtor 20))
					)
			;(AddText (ptxy pt12 0 (/ 1.25 2.0)) "ê�˿����" "Standard" 1.25 0.7)
			;(AddText (ptxy pt12 0 (- (/ 1.25 2.0))) (strcat "ƽ������" (rtos maoganchang) "m") "Standard" 1.25 0.7)
		)
	)
	(AddText (ptxy (mid pt11 pt12) 0 (/ 1.25 1.1)) "ê�˿����" "Standard" 1.25 0.7)
	(AddText (ptxy (mid pt11 pt12) 0 (- (/ 1.25 1.1))) (strcat "ƽ������" (rtos maoganchang) "m") "Standard" 1.25 0.7)
	(addmaogan pt1 dist1 ang maoganchang1)
	(addmaogan pt2 dist1 ang maoganchang1)
	(addmaogan pt3 dist1 ang maoganchang1)
	(AddPLpts (list ptmid pt11 pt12) 1.0)
	
	
)
(defun addmaogan(pt dist1 ang mgchang)
	(if (>= ang (/ pi 2))
		(setq p1(polar pt (+ ang pi) (/ dist1 2.0))
			p4(polar pt ang (/ dist1 2.0))
			p2(polar p1 (+ ang (/ pi 2)) dist1)
			p3(polar p4 (+ ang (/ pi 2)) dist1)
		)
		(setq p1(polar pt (- ang pi) (/ dist1 2.0))
			p4(polar pt ang (/ dist1 2.0))
			p2(polar p1 (- ang (/ pi 2)) dist1)
			p3(polar p4 (- ang (/ pi 2)) dist1)
		)
	)
	(AddPLpts (list p1 p2 p3 p4) 1.0)
	(AddPL2pt pt (polar pt ang1 mgchang) 0.15)	
)