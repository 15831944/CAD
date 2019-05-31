;-------------------------------------------------------------------------------
; Program Name: DPL - Dimension Polylines
; Created By:   Terry Miller (Email: terrycadd@yahoo.com)
;               (URL: http://web2.airmail.net/terrycad)
; Date Created: 5-20-08
; Function:     Dimensions Polyline shapes
;-------------------------------------------------------------------------------
; Revision History
; Rev  By     Date    Description
;-------------------------------------------------------------------------------
; 1    TM   5-20-08   Initial version
;-------------------------------------------------------------------------------
; c:DPL - Dimensions Polyline
;-------------------------------------------------------------------------------
(defun c:DPL (/ EntName^ EntPick@)
  (setvar "CMDECHO" 0)
  (if (setq EntPick@ (entsel "\nSelect Polyline to dimension: "))
    (if (= (cdr (assoc 0 (entget (car EntPick@)))) "LWPOLYLINE")
      (progn
        (setq EntName^ (cdr (assoc -1 (entget (car EntPick@)))))
        (DimPL EntName^)
      );progn
    );if
  );if
  (if (not EntName^)
    (princ "\nNo Polyline selected.")
  );if
  (princ)
);defun c:DPL
;-------------------------------------------------------------------------------
; DimPL - Function to dimension Polyline
; Arguments: 1
;   EntName^ = Polyline entity name
; Returns: Dimensions Polyline
;-------------------------------------------------------------------------------
(defun DimPL (EntName^ / Bottom@ Clayer$ CW# DiffAng DimPts: DimSpace~ EntList@
  Item LastAng~ LastPt Left@ List@ NW@ Osmode# P0 P1 P2 Pt Pts@ PtsLen Right@ SE@
  Top@ X~ X1~ X1Y1 X1Y2 X1Ys@ X2~ X2Y1 X2Y2 X2Ys@ XPts@ Y~ Y1~ Y1X1 Y1X2 Y1Xs@ Y2~
  Y2X1 Y2X2 Y2Xs@ YPts@)
  ;-----------------------------------------------------------------------------
  (defun DimPts: (Pts@ StartPt EndPt Type$ / Add Num1~ Num2~ Nums1@ Nums2@ P1 P2
    Pt Return@)
    (setq Add t)
    (foreach Pt (member StartPt (append Pts@ Pts@))
      (if Add
        (setq Return@ (append Return@ (list Pt)))
      );if
      (if (equal Pt EndPt)
        (setq Add nil)
      );if
    );foreach
    (foreach Pt Return@
      (if (member Type$ (list "Left" "Right"))
        (setq Nums1@ (append Nums1@ (list (cadr Pt))))
        (setq Nums1@ (append Nums1@ (list (car Pt))))
      );if
    );foreach
    (foreach Num1~ (vl-sort Nums1@ '<)
      (setq Nums2@ nil)
      (foreach Pt Return@
        (if (member Type$ (list "Left" "Right"))
          (if (= (cadr Pt) Num1~)
            (setq Nums2@ (append Nums2@ (list (car Pt))))
          );if
          (if (= (car Pt) Num1~)
            (setq Nums2@ (append Nums2@ (list (cadr Pt))))
          );if
        );if
      );foreach
      (if (member Type$ (list "Left" "Bottom"))
        (setq Nums2@ (vl-sort Nums2@ '<))
        (setq Nums2@ (reverse (vl-sort Nums2@ '<)))
      );if
      (foreach Num2~ (cdr Nums2@)
        (if (member Type$ (list "Left" "Right"))
          (setq Pt (list Num2~ Num1~))
          (setq Pt (list Num1~ Num2~))
        );if
        (setq Return@ (vl-remove Pt Return@))
      );foreach
    );foreach
    (cond
      ((= Type$ "Left")
        (vl-sort Return@ (function (lambda (P1 P2)(< (cadr P1)(cadr P2)))))
      );case
      ((= Type$ "Top")
        (vl-sort Return@ (function (lambda (P1 P2)(< (car P1)(car P2)))))
      );case
      ((= Type$ "Right")
        (vl-sort Return@ (function (lambda (P1 P2)(> (cadr P1)(cadr P2)))))
      );case
      ((= Type$ "Bottom")
        (vl-sort Return@ (function (lambda (P1 P2)(> (car P1)(car P2)))))
      );case
    );cond
  );defun DimPts:
  ;-----------------------------------------------------------------------------
  (setq EntList@ (entget EntName^))
  (if (= (cdr (assoc 0 EntList@)) "LWPOLYLINE")
    (progn
      (foreach List@ EntList@
        (if (= (car List@) 10)
          (if (not (equal (cdr List@) LastPt))
            (progn
              (setq Pts@ (append Pts@ (list (cdr List@))))
              (if (> (length Pts@) 2)
                (if (/= (angle LastPt (cdr List@)) LastAng~) (setq DiffAng t))
              );if
              (if (> (length Pts@) 1)
                (setq LastAng~ (angle LastPt (cdr List@)))
              );if
              (setq LastPt (cdr List@))
            );progn
          );if
        );if
      );foreach
      (if (equal (car Pts@) (last Pts@))
        (setq Pts@ (reverse (cdr (reverse Pts@))))
      );if
      (setq PtsLen (length Pts@))
    );progn
    (exit)
  );if
  (foreach Pt Pts@
    (setq X~ (atof (rtos (car Pt) 2 8))
          Y~ (atof (rtos (cadr Pt) 2 8))
          XPts@ (append XPts@ (list X~))
          YPts@ (append YPts@ (list Y~))
          Pts@ (cdr (append Pts@ (list (list X~ Y~))))
    );setq
  );foreach
  (setq XPts@ (vl-sort XPts@ '<)
        YPts@ (vl-sort YPts@ '<)
        X1~ (car XPts@)
        X2~ (last XPts@)
        Y1~ (car YPts@)
        Y2~ (last YPts@)
  );if
  (foreach Pt Pts@
    (if (= (car Pt) X1~) (setq X1Ys@ (append X1Ys@ (list (cadr Pt)))))
    (if (= (car Pt) X2~) (setq X2Ys@ (append X2Ys@ (list (cadr Pt)))))
    (if (= (cadr Pt) Y1~) (setq Y1Xs@ (append Y1Xs@ (list (car Pt)))))
    (if (= (cadr Pt) Y2~) (setq Y2Xs@ (append Y2Xs@ (list (car Pt)))))
  );foreach
  (setq X1Ys@ (vl-sort X1Ys@ '<)
        X2Ys@ (vl-sort X2Ys@ '<)
        Y1Xs@ (vl-sort Y1Xs@ '<)
        Y2Xs@ (vl-sort Y2Xs@ '<)
        X1Y1 (list X1~ (car X1Ys@))
        X1Y2 (list X1~ (last X1Ys@))
        X2Y1 (list X2~ (car X2Ys@))
        X2Y2 (list X2~ (last X2Ys@))
        Y1X1 (list (car Y1Xs@) Y1~)
        Y1X2 (list (last Y1Xs@) Y1~)
        Y2X1 (list (car Y2Xs@) Y2~)
        Y2X2 (list (last Y2Xs@) Y2~)
        Pts@ (member X1Y1 (append Pts@ Pts@))
  );setq
  (while (> (length Pts@) PtsLen)
    (setq Pts@ (reverse (cdr (reverse Pts@))))
  );while
  (setq SE@ (member X2Y2 Pts@) NW@ Pts@)
  (foreach Item SE@
    (setq NW@ (vl-remove Item NW@))
  );foreach
  (setq SE@ (append SE@ (list X1Y1))
        NW@ (append NW@ (list X2Y2))
        CW# 0
  );setq
  (foreach Pt (list Y2X1 Y2X2)
    (if (member Pt NW@) (setq CW# (1+ CW#)))
    (if (member Pt SE@) (setq CW# (1- CW#)))
  );foreach
  (foreach Pt (list Y1X1 Y1X2)
    (if (member Pt SE@) (setq CW# (1+ CW#)))
    (if (member Pt NW@) (setq CW# (1- CW#)))
  );foreach
  (if (< CW# 0)
    (setq Pts@ (append (list (car Pts@))(reverse (cdr Pts@))))
  );if
  (setq Left@ (DimPts: Pts@ Y1X1 Y2X1 "Left"))
  (setq Top@ (DimPts: Pts@ X1Y2 X2Y2 "Top"))
  (setq Right@ (DimPts: Pts@ Y2X2 Y1X2 "Right"))
  (setq Bottom@ (DimPts: Pts@ X2Y1 X1Y1 "Bottom"))
  ;-----------------------------------------------------------------------------
  (command "UNDO" "BEGIN")
  (setq DimSpace~ (* (getvar "DIMSCALE") (getvar "DIMTXT") 3))
  (setq Osmode# (getvar "OSMODE")) (setvar "OSMODE" 0)
  (setq Clayer$ (getvar "CLAYER"))
  (command "LAYER" "S" (GetDimLayer) "");<--Change to your Dim layer info
  (setq P0 (polar X1Y1 pi (* DimSpace~ 1.5))
        P1 (car Left@)
  );setq
  (foreach P2 (cdr Left@)
    (command "DIM1" "VER" P1 P2 P0 "")
    (setq P1 P2)
  );foreach
  (if (> (length Left@) 2)
    (progn
      (setq P0 (polar P0 pi DimSpace~))
      (command "DIM1" "VER" (car Left@) (last Left@) P0 "")
    );progn
  );if
  (setq P0 (polar Y2X1 (* pi 0.5) (* DimSpace~ 1.5))
        P1 (car Top@)
  );setq
  (foreach P2 (cdr Top@)
    (command "DIM1" "HOR" P1 P2 P0 "")
    (setq P1 P2)
  );foreach
  (if (> (length Top@) 2)
    (progn
      (setq P0 (polar P0 (* pi 0.5) DimSpace~))
      (command "DIM1" "HOR" (car Top@) (last Top@) P0 "")
    );progn
  );if
  (setq P0 (polar X2Y2 0 (* DimSpace~ 1.5))
        P1 (car Right@)
  );setq
  (if (and (> (length Right@) 2) DiffAng)
    (foreach P2 (cdr Right@)
      (command "DIM1" "VER" P1 P2 P0 "")
      (setq P1 P2)
    );foreach
  );if
  (setq P0 (polar Y1X2 (* pi 1.5) (* DimSpace~ 1.5))
        P1 (car Bottom@)
  );setq
  (if (and (> (length Bottom@) 2) DiffAng)
    (foreach P2 (cdr Bottom@)
      (command "DIM1" "HOR" P1 P2 P0 "")
      (setq P1 P2)
    );foreach
  );if
  (setvar "CLAYER" Clayer$)
  (setvar "OSMODE" Osmode#)
  (command "UNDO" "END")
  (princ)
);defun DimPL
;-------------------------------------------------------------------------------
; GetDimLayer - Returns the layer name that's on and has the most dimensions,
; or the current layer name if there's no dimensions.
;-------------------------------------------------------------------------------
(defun GetDimLayer (/ DimLayer$ EntList@ Index# Layer$ LayerInfo@ LayerList@ List@ Num# SS&)
  (setq Layer$ (getvar "CLAYER"))
  (if (setq SS& (ssget "X" '((0 . "DIMENSION"))))
    (progn
      (setq Index# -1)
      (while (< (setq Index# (1+ Index#)) (sslength SS&))
        (setq EntList@ (entget (ssname SS& Index#))
              DimLayer$ (cdr (assoc 8 EntList@))
              LayerInfo@ (tblsearch "LAYER" DimLayer$)
        );setq
        (if (and (= (cdr (assoc 70 LayerInfo@)) 0)(> (cdr (assoc 62 LayerInfo@)) 0))
          (if (assoc DimLayer$ LayerList@)
            (setq Num# (1+ (cdr (assoc DimLayer$ LayerList@)))
                  LayerList@ (subst (cons DimLayer$ Num#) (assoc DimLayer$ LayerList@) LayerList@)
            );setq
            (setq LayerList@ (append LayerList@ (list (cons DimLayer$ 1))))
          );if
        );if
      );while
      (if LayerList@
        (progn
          (setq Layer$ (car (car LayerList@))
                Num# (cdr (car LayerList@))
          );setq
          (foreach List@ (cdr LayerList@)
            (if (> (cdr List@) Num#)
              (setq Layer$ (car List@)
                    Num# (cdr List@)
              );setq
            );if
          );foreach
        );progn
      );if
    );progn
  );if
  Layer$
);defun GetDimLayer
;-------------------------------------------------------------------------------
(princ);End of DPL.lsp