;-------------------------------------------------------------------------------
; Program Name: Text-Box.lsp [Text-Box R2]
; Created By:   Terry Miller (Email: terrycadd@yahoo.com)
;               (URL: http://web2.airmail.net/terrycad)
; Date Created: 9-19-97
; Function:     Draws a polyline Text Box outlining Text, Mtext and Dimensions.
;               The polyline can be offset a certain distance to use to trim
;               other objects. A label can be created by rounding the corners
;               of the rectangle. It can also be used to calculate the widths
;               for columns for a Bill of Material or a Table of information.
;-------------------------------------------------------------------------------
; Revision History
; Rev  By     Date    Description
;-------------------------------------------------------------------------------
; 1    TM   9-19-97   Initial version
; 2    TM   4-20-06   Revised to include Mtext and Dimensions
;-------------------------------------------------------------------------------
; c:Text-Box -  Draws a polyline Text Box outlining Text, Mtext and Dimensions.
;-------------------------------------------------------------------------------
(defun c:TB ( )(c:Text-Box));Shortcut
(defun c:Text-Box (/ Cnt# EntName^ Osmode# Pt PtsList@ SS&)
  (setq Osmode# (getvar "OSMODE"))
  (princ "\nSelect Text, Mtext or Dimension for Text Box")
  (if (setq SS& (ssget '((-4 . "<OR")(0 . "TEXT")(0 . "MTEXT")(0 . "DIMENSION")(-4 . "OR>"))))
    (progn
      (command "UNDO" "BEGIN")
      (setvar "OSMODE" 0)
      (setq Cnt# 0)
      (repeat (sslength SS&)
        (setq EntName^ (ssname SS& Cnt#))
        (setq PtsList@ (append (Text-Box EntName^) (list "C")))
        (command "PLINE" (foreach Pt PtsList@ (command Pt)))
        (setq Cnt# (1+ Cnt#))
      );repeat
      (command "UNDO" "END")
      (setvar "OSMODE" Osmode#)
    );progn
    (princ "\nNo Text, Mtext or Dimension selected.")
  );if
  (princ)
);defun c:Text-Box
;-------------------------------------------------------------------------------
; Text-Box - Function for Text, Mtext and Dimension entities
; Arguments: 1
;   Entity^ = Entity name of the Text, Mtext or Dimension to use
; Returns: A list of the four corners of the Text Box
;-------------------------------------------------------------------------------
(defun Text-Box (Entity^ / Ang~ AngEntity~ Corners: EntList@ EntNext^ EntType$
  First List@ MovePt NewPts@ Pt Return@ Textboxes@ X X1 X3 Y Y1 Y3 Zero)
  ;-----------------------------------------------------------------------------
  ; Corners: - Calculates the four corners of the Text Box
  ;-----------------------------------------------------------------------------
  (defun Corners: (Entity^ / Ang~ Corners@ Dist~ EntList@ Ins Pt Pt1 Pt2 Pt3 Pt4)
    (setq EntList@ (entget Entity^)
          Corners@ (textbox EntList@)
          Ang~ (cdr (assoc 50 EntList@))
          Ins (cdr (assoc 10 EntList@))
          Pt (mapcar '+ (car Corners@) Ins)
          Pt1 (polar Ins (+ Ang~ (angle Ins Pt)) (distance Ins Pt))
          Pt (mapcar '+ (cadr Corners@) Ins)
          Pt3 (polar Ins (+ Ang~ (angle Ins Pt)) (distance Ins Pt))
          Dist~ (* (distance (car Corners@) (cadr Corners@)) (cos (- (angle Pt1 Pt3) Ang~)))
          Pt2 (polar Pt1 Ang~ Dist~)
          Pt4 (polar Pt3 Ang~ (- Dist~))
    );setq
    (list Pt1 Pt2 Pt3 Pt4)
  );defun Corners:
  ;-----------------------------------------------------------------------------
  (setq EntList@ (entget Entity^)
        EntType$ (cdr (assoc 0 EntList@))
  );setq
  (cond
    ((= EntType$ "TEXT")
      (setq Return@ (Corners: Entity^))
    );case
    ((or (= EntType$ "MTEXT")(= EntType$ "DIMENSION"))
      (command "UNDO" "MARK")
      (setq EntNext^ (entlast))
      (command "EXPLODE" Entity^)
      (if (= EntType$ "DIMENSION")
        (command "EXPLODE" (entlast))
      );if
      (while (setq EntNext^ (entnext EntNext^))
        (if (= "TEXT" (cdr (assoc 0 (entget EntNext^))))
          (setq Textboxes@ (append Textboxes@ (list (Text-Box EntNext^))))
        );if
      );while
      (command "UNDO" "BACK")
      (setq AngEntity~ (angle (nth 0 (nth 0 Textboxes@))(nth 1 (nth 0 Textboxes@)))
            Zero (list 0 0)
            First t
      );setq
      (foreach List@ Textboxes@
        (foreach Pt List@
          (setq X (car Pt) Y (cadr Pt))
          (if First
            (setq First nil X1 X Y1 Y)
          );if
          (if (< X X1)(setq X1 X))
          (if (< Y Y1)(setq Y1 Y))
        );foreach
      );foreach
      (if (or (< X1 0)(< Y1 0))
        (progn
          (cond
            ((and (< X1 0)(< Y1 0))(setq MovePt (list X1 Y1)))
            ((< X1 0)(setq MovePt (list X1 0)))
            ((< Y1 0)(setq MovePt (list 0 Y1)))
          );cond
          (command "UCS" "M" MovePt)
        );progn
      );if
      (setq First t)
      (foreach List@ Textboxes@
        (foreach Pt List@
          (setq Ang~ (- (angle Zero Pt) AngEntity~))
          (setq Pt (polar Zero Ang~ (distance Zero Pt)))
          (setq X (car Pt) Y (cadr Pt))
          (if First
            (setq First nil X1 X X3 X Y1 Y Y3 Y)
          );if
          (if (< X X1)(setq X1 X))
          (if (< Y Y1)(setq Y1 Y))
          (if (> X X3)(setq X3 X))
          (if (> Y Y3)(setq Y3 Y))
        );foreach
      );foreach
      (command "UCS" "W")
      (setq NewPts@ (list (list X1 Y1)(list X3 Y1)(list X3 Y3)(list X1 Y3)))
      (foreach Pt NewPts@
        (setq Ang~ (+ (angle Zero Pt) AngEntity~))
        (setq Pt (polar Zero Ang~ (distance Zero Pt)))
        (setq Return@ (append Return@ (list Pt)))
      );foreach
    );case
  );cond
  Return@
);defun Text-Box
;-------------------------------------------------------------------------------
(princ)