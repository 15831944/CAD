;-------------------------------------------------------------------------------
; Program Name: DrawExcel.lsp [Draw Excel R4]
; Created By:   Terry Miller (Email: terrycadd@yahoo.com)
;               (URL: http://web2.airmail.net/terrycad)
; Date Created: 9-20-03
; Note:         DrawExcel.lsp is designed to draw basic spreadsheets without
;               merged cells. Adjust the range for the Starting and Ending cells
;               to not include merged cells. Headings and Titles can later be
;               added in AutoCAD. Save the Excel spreadsheet in the view that
;               you want to draw. Then close Excel. DrawExcel requires functions
;               inside of GetIcon.lsp. The associated files are DrawExcel.lsp
;               and DrawExcel.dcl.
;-------------------------------------------------------------------------------
; Revision History
; Rev  By     Date    Description
;-------------------------------------------------------------------------------
; 1    TM   9-20-03   Initial version. Created the GetExcel function.
; 2    TM   5-20-04   Added DrawExcel to draw an Excel spreadsheet.
; 3    TM   3-20-06   Revised program and rewrote DrawExcel with new dialogs.
; 2    TM   8-20-07   Rewrote GetExcel.lsp and added several new sub-functions
;                     including ColumnRow, Alpha2Number and Number2Alpha written
;                     by Gilles Chanteau from Marseille, France.
;-------------------------------------------------------------------------------
; c:DrawExcel - Draws an Excel Spreadsheet in AutoCAD
;-------------------------------------------------------------------------------
(defun c:DES ()(c:DrawExcel));Shortcut
(defun c:DrawExcel (/ Browse: CmdEcho# Cnt# Dcl_Id% ExcelApp% End@ Fill_Color:
  Info: List@ List001@ List002@ List003@ List004@ List101@ List102@ Passed Return#
  Set_Vars: Start@ Var001$ Var002$ Var003$ Var004$ Var005$ Var006$ Var007$ Var008$
  Var009$ Var010$ Var101$ Var102$ Verify_Info:)
  (princ "\nDraw Excel Spreadsheet ")(princ)
  (DrawExcel_Support)(gc)
  (if (setq ExcelApp% (vlax-get-object "Excel.Application"))
    (if (= (GetOkCancel "Draw Excel Message" "Close all Excel spreadsheets to continue!" "exclam") "Cancel")
      (exit)
      (progn (vlax-release-object ExcelApp%)(gc))
    );if
  );if
  (setq CmdEcho# (getvar "CMDECHO"))(setvar "CMDECHO" 0)
  ;-----------------------------------------------------------------------------
  ; Set_Vars: - Set dialog tiles and variables
  ;-----------------------------------------------------------------------------
  (defun Set_Vars: (ListName$ VarName$ / List@ SaveVar$ Text$)
    (setq SaveVar$ (eval (read VarName$)))
    (cond
      (ListName$
        (set_list_value ListName$ VarName$)
      );case
      ((or (= VarName$ "Var005$")(= VarName$ "Var006$"))
        (check_editreal VarName$)
      );case
      ((or (= VarName$ "Var007$")(= VarName$ "Var008$"))
        (setq List@ (ColumnRow $value))
        (setq Text$ (strcat (Number2Alpha (nth 0 List@))(itoa (nth 1 List@))))
        (if (/= (strcase $value) Text$)
          (GetOK "Invalid Value" "The format of the Cell ID is incorrect." "exclam")
        );if
        (set (read VarName$) Text$)
        (set_tile $key (eval (read VarName$)))
      );case
      ((= VarName$ "Var009$")
        (if (/= (strcase $value)(strcase SaveVar$))
          (setq $value (Capitals $value))
        );if
        (set (read VarName$) $value)
        (set_tile $key (eval (read VarName$)))
      );case
    );cond
    (if (= VarName$ "Var001$")
      (progn
        (setq Var101$ (FindInList Var001$ List001@ List101@))
        (Fill_Color: "Image101" Var101$)
      );progn
    );if
    (if (= VarName$ "Var002$")
      (progn
        (setq Var102$ (FindInList Var002$ List002@ List102@))
        (Fill_Color: "Image102" Var102$)
      );progn
    );if
    (if (= VarName$ "Var005$")
      (progn
        (setq Var006$ (rtosr (* (atof Var005$) 2)))
        (set_tile "EditReal006" Var006$)
      );progn
    );if
    (if (and (= VarName$ "Var006$")(< (atof Var006$) (atof Var005$)))
      (progn
        (GetOK "Invalid Value" "The Row Height cannot be\nless than the Text Height." "exclam")
        (setq Var006$ SaveVar$)
        (set_tile "EditReal006" Var006$)
      );progn
    );if
    (if (or (= VarName$ "Var007$")(= VarName$ "Var008$"))
      (progn
        (setq Start@ (ColumnRow Var007$)
              End@ (ColumnRow Var008$)
        );setq
        (if (or (< (nth 0 End@) (nth 0 Start@)) (< (nth 1 End@) (nth 1 Start@)))
          (progn
            (GetOK "Invalid Value" "The Ending Cell values must be equal\nor greater than the Starting Cell values." "exclam")
            (if (< (nth 0 End@) (nth 0 Start@))
              (setq Text$ (Number2Alpha (nth 0 Start@)))
              (setq Text$ (Number2Alpha (nth 0 End@)))
            );if
            (if (< (nth 1 End@) (nth 1 Start@))
              (setq Text$ (strcat Text$ (itoa (nth 1 Start@))))
              (setq Text$ (strcat Text$ (itoa (nth 1 End@))))
            );if
            (setq Var008$ Text$)
            (set_tile "EditCaps008" Var008$)
          );progn
        );if
      );progn
    );if
    (if (and (= VarName$ "Var009$")(/= Var009$ ""))
      (progn
        (setq Passed t)
        (if (> (strlen Var009$) 4)
          (if (= (strcase (substr Var009$ (- (strlen Var009$) 3)) t) ".xls")
            (if (not (findfile Var009$))
              (setq Passed nil)
            );if
            (setq Passed nil)
          );if
          (setq Passed nil)
        );if
        (if (not Passed)
          (GetOK "Invalid Value" "The Excel Filename cannot be found.\nTry to Browse to locate the Excel file." "exclam")
        );if
      );progn
    );if
  );defun Set_Vars:
  ;-----------------------------------------------------------------------------
  ; Browse: - Browse to select the Excel file
  ;-----------------------------------------------------------------------------
  (defun Browse: (/ PathFilename$ Pathname$)
    (if (findfile Var009$)
      (setq Pathname$ (getpath Var009$))
      (setq Pathname$ "")
    );if
    (if (setq PathFilename$ (getfiled " Select Excel File" Pathname$ "xls" 20))
      (progn
        (setq Var009$ PathFilename$)
        (set_tile "Edit009" Var009$)
      );progn
    );if
    (set_tile "Toggle010" "0")
  );defun Browse:
  ;-----------------------------------------------------------------------------
  ; Fill_Color: - Fills in layer color image
  ;-----------------------------------------------------------------------------
  (defun Fill_Color: (KeyName$ Color# / )
    (start_image KeyName$)
    (fill_image 0 0 (dimx_tile KeyName$) (dimy_tile KeyName$) Color#)
    (fill_image 0 0 (dimx_tile KeyName$) 6 -15)
    (vector_image 0 6 0 (1- (dimy_tile KeyName$)) 250)
    (vector_image 0 (1- (dimy_tile KeyName$)) (1- (dimx_tile KeyName$)) (1- (dimy_tile KeyName$)) 250)
    (vector_image (1- (dimx_tile KeyName$)) (1- (dimy_tile KeyName$)) (1- (dimx_tile KeyName$)) 6 250)
    (vector_image (1- (dimx_tile KeyName$)) 6 0 6 250)
    (end_image)
  );defun Fill_Color:
  ;-----------------------------------------------------------------------------
  ; Info: - Displays Draw Excel Information
  ;-----------------------------------------------------------------------------
  (defun Info: ()
    (GetOK "Draw Excel Information" (strcat
      "Draw Excel is designed to draw basic"
      "\nspreadsheets without merged cells."
      "\nAdjust the range for the Starting and"
      "\nEnding cells to not include merged"
      "\ncells.  Headings and Titles can later be"
      "\nadded in AutoCAD.  Save the Excel"
      "\nspreadsheet in the view that you want"
      "\nto draw. Then close Excel.") "")
  );defun Info:
  ;-----------------------------------------------------------------------------
  ; Verify_Info: - Verifies that the required information is correct
  ;-----------------------------------------------------------------------------
  (defun Verify_Info: (/ Message$)
    (setq Message$ ""
          Passed t
          Start@ (ColumnRow Var007$)
          End@ (ColumnRow Var008$)
    );setq
    (if (> (strlen Var009$) 4)
      (if (= (strcase (substr Var009$ (- (strlen Var009$) 3)) t) ".xls")
        (if (not (findfile Var009$))
          (setq Passed nil)
        );if
        (setq Passed nil)
      );if
      (setq Passed nil)
    );if
    (if (not Passed)
      (setq Message$ (strcat Message$ "The Excel Filename cannot be found.\nTry to Browse to locate the Excel file.\n"))
    );if
    (if (or (< (nth 0 End@) (nth 0 Start@)) (< (nth 1 End@) (nth 1 Start@)))
      (progn
        (setq Message$ (strcat Message$ "The Starting and Ending cell locations\nare incorrect or out of range."))
        (setq Passed nil)
      );progn
    );if
    (setq *DrawExcel@ (list Return# Var001$ Var002$ Var003$ Var004$ Var005$ Var006$ Var007$ Var008$ Var009$ Var010$))
    (if Passed
      (done_dialog 1)
      (GetOK "Invalid Values" Message$ "exclam")
    );if
  );defun Verify_Info:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables and List Values
  ;-----------------------------------------------------------------------------
  (setq List001@ (GetLayers)
        List101@ (GetLayerColors)
        List002@ List001@
        List102@ List101@
        List004@ (list "Left" "Center" "Right")
  );setq
  (setq List@ (GetFonts))
  (setq Cnt# 0)
  (foreach Item (GetStyles)
    (setq List003@ (append List003@ (list (strcat Item " - " (nth Cnt# List@)))))
    (setq Cnt# (1+ Cnt#))
  );foreach
  (if (not *DrawExcel@)
    (setq *DrawExcel@
      (list nil (nth 0 List001@) (nth 0 List002@) (nth 0 List003@)
      (nth 1 List004@) (rtosr (getvar "TEXTSIZE"))
      (rtosr (* (getvar "TEXTSIZE") 2)) "A1" "C3" "" "")
    );setq
  );if
  (setq Var001$ (nth 1 *DrawExcel@)
        Var002$ (nth 2 *DrawExcel@)
        Var003$ (nth 3 *DrawExcel@)
        Var004$ (nth 4 *DrawExcel@)
        Var005$ (nth 5 *DrawExcel@)
        Var006$ (nth 6 *DrawExcel@)
        Var007$ (nth 7 *DrawExcel@)
        Var008$ (nth 8 *DrawExcel@)
        Var009$ (nth 9 *DrawExcel@)
        Var010$ (nth 10 *DrawExcel@)
  );setq
  ;-----------------------------------------------------------------------------
  ; Load Dialog
  ;-----------------------------------------------------------------------------
  (setq Dcl_Id% (load_dialog "DrawExcel.dcl"))
  (new_dialog "DrawExcel" Dcl_Id%)
  ;-----------------------------------------------------------------------------
  ; Set Dialog Initial Settings
  ;-----------------------------------------------------------------------------
  (set_tile "Title"  " Draw Excel Spreadsheet")
  (set_tile "Text001" "Layer for Lines")
  (set_tile "Text002" "Layer for Text")
  (set_tile "Text003" "Text Style & Font")
  (set_tile "Text004" "Text Justification")
  (set_tile "Text005" "Text Height")
  (set_tile "Text006" "Row Height")
  (set_tile "Text007" "Starting Cell")
  (set_tile "Text008" "Ending Cell")
  (set_tile "Text009" "Excel Filename")
  (set_tile "Text010" "Browse")
  (set_tile_list "List001" List001@ Var001$)
  (set_tile_list "List002" List002@ Var002$)
  (set_tile_list "List003" List003@ Var003$)
  (set_tile_list "List004" List004@ Var004$)
  (set_tile "EditReal005" Var005$)
  (set_tile "EditReal006" Var006$)
  (set_tile "EditCaps007" Var007$)
  (set_tile "EditCaps008" Var008$)
  (set_tile "Edit009" Var009$)
  (setq Var101$ (FindInList Var001$ List001@ List101@))
  (Fill_Color: "Image101" Var101$)
  (setq Var102$ (FindInList Var002$ List002@ List102@))
  (Fill_Color: "Image102" Var102$)
  ;-----------------------------------------------------------------------------
  ; Dialog Actions
  ;-----------------------------------------------------------------------------
  (action_tile "List001"     "(Set_Vars: \"List001@\" \"Var001$\")")
  (action_tile "List002"     "(Set_Vars: \"List002@\" \"Var002$\")")
  (action_tile "List003"     "(Set_Vars: \"List003@\" \"Var003$\")")
  (action_tile "List004"     "(Set_Vars: \"List004@\" \"Var004$\")")
  (action_tile "EditReal005" "(Set_Vars: nil \"Var005$\")")
  (action_tile "EditReal006" "(Set_Vars: nil \"Var006$\")")
  (action_tile "EditCaps007" "(Set_Vars: nil \"Var007$\")")
  (action_tile "EditCaps008" "(Set_Vars: nil \"Var008$\")")
  (action_tile "Edit009"     "(Set_Vars: nil \"Var009$\")")
  (action_tile "Toggle010"   "(Browse:)")
  (action_tile "Info"        "(Info:)")
  (action_tile "accept"      "(Verify_Info:)")
  (setq Return# (start_dialog))
  (unload_dialog Dcl_Id%)
  (setq *DrawExcel@ (list Return# Var001$ Var002$ Var003$ Var004$ Var005$ Var006$ Var007$ Var008$ Var009$ Var010$))
  (setvar "CMDECHO" CmdEcho#)
  (if (= Return# 0) (exit))
  (DrawExcel Var001$ Var002$ Var003$ Var004$ (atof Var005$) (atof Var006$) Var007$ Var008$ Var009$)
  (princ)
);defun c:DrawExcel
;-------------------------------------------------------------------------------
; DrawExcel - Draws an Excel spreadsheet in AutoCAD
; Arguments: 9
;   LineLayer$ = Layer for Lines
;   TextLayer$ = Layer for Text
;   TextStyle$ = Text Style
;   Justify$ = Text Justification
;   TextHeight~ = Text Size
;   RowHeight~ = Row Height
;   Start$ = Starting Cell name
;   End$ = Ending Cell name
;   ExcelFile$ = Path and filename
; Returns: Draws an Excel spreadsheet in AutoCAD
;-------------------------------------------------------------------------------
(defun DrawExcel (LineLayer$ TextLayer$ TextStyle$ Justify$ TextHeight~ RowHeight~ Start$ End$ ExcelFile$ /
  CmdEcho# Cnt# Column# End@ EndColumn# EndRow# ExcelData@ Excel@ InsPt Item$ List@ Osmode# Pt Row#
  Start@ StartColumn# StartRow# Temp@ TextGap~ TlWidth~ TlHeight~ TxBox@ TxPt TxWidth@ TxWidth~)
  (setq CmdEcho# (getvar "CMDECHO"))(setvar "CMDECHO" 0)
  (command "UNDO" "BEGIN")
  (princ "\nWorking...")(princ)
  (setq TextGap~ (* TextHeight~ 0.5));Text to line gap
  (setq Excel@ (GetExcel ExcelFile$ nil End$))
  (princ "\nDraw Excel Spreadsheet\nWorking...")
  (while (not (setq InsPt (getpoint "\nSpecify insertion point: ")))
    (princ "\nDraw Excel Spreadsheet\nWorking...")
  );while
  (if (not InsPt) (setq InsPt (list 0 0)))
  (setq Osmode# (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  (setq Start@ (ColumnRow Start$)
        StartColumn# (nth 0 Start@)
        StartRow# (nth 1 Start@)
        End@ (ColumnRow End$)
        EndColumn# (nth 0 End@)
        EndRow# (nth 1 End@)
  );setq
  (setq EndRow# (- EndRow# StartRow#))
  (setq EndColumn# (- EndColumn# StartColumn#))
  (repeat (1- StartRow#)
    (setq Excel@ (Delete_nth 0 Excel@))
  );repeat
  (foreach List@ Excel@
    (repeat (1- StartColumn#)
      (setq List@ (Delete_nth 0 List@))
    );repeat
    (setq Temp@ (append Temp@ (list List@)))
  );foreach
  (setq Excel@ Temp@)
  (princ "\nWorking...")(princ)
  (setq TextStyle$ (nth 0 (CommaList (FindReplace TextStyle$ " - " ","))))
  (setvar "TEXTSTYLE" TextStyle$)
  (setq TextStyleHeight~ (FindInList TextStyle$ (GetStyles) (GetStyleHeights)))
  (if (/= TextStyleHeight~ 0)
    (command "STYLE" TextStyle$ "" 0 "" "" "" "" "")
  );if
  (setvar "TEXTSIZE" TextHeight~)
  (command "ZOOM" (polar (getvar "VIEWCTR") pi (* TextHeight~ 10)) (polar (getvar "VIEWCTR") 0 (* TextHeight~ 10)))
  (setq Column# 0 TlWidth~ 0 Cnt# 0)
  (command "LAYER" "T" LineLayer$ "U" LineLayer$ "ON" LineLayer$ "S" LineLayer$ "")
  (repeat (1+ EndColumn#)
    (setq Temp@ nil)
    (setq TxWidth@ (list 0))
    (foreach Item@ Excel@
      (setq Item$ (nth Column# Item@))
      (if (and (/= Item$ "") (not (member Item$ Temp@)))
        (progn
          (command "TEXT" "M" (getvar "VIEWCTR") "" "" Item$)
          (setq TxBox@ (textbox (entget (entlast))))
          (setq TxWidth~ (- (car (cadr TxBox@)) (car (car TxBox@))))
          (command "ERASE" (entlast) "")
          (setq TxWidth@ (append TxWidth@ (list TxWidth~)))
        );progn
      );if
      (setq Temp@ (append Temp@ (list Item$)))
    );foreach
    (setq TxWidth~ (+ (last (number_sort TxWidth@)) (* TextGap~ 2))); Column width
    (setq TlWidth~ (+ TlWidth~ TxWidth~))
    (setq Temp@ (Insert_nth 0 TxWidth~ Temp@))
    (setq ExcelData@ (append ExcelData@ (list Temp@)))
    (setq Column# (1+ Column#))
    (Whirl)
  );repeat
  (princ " ")
  (setq TlHeight~ (* (1+ EndRow#) RowHeight~)); Height of spreadsheet
  (setq Pt (polar InsPt 0 TlWidth~) Pt (polar Pt (dtr 270) TlHeight~))
  (command "ZOOM" InsPt Pt)
  (command "RECTANG" InsPt Pt)
  (setq Pt InsPt Cnt# 1)
  (foreach Item ExcelData@
    (setq Pt (polar Pt 0 (nth 0 Item)))
    (if (/= Cnt# (length ExcelData@))
      (command "LINE" Pt (polar Pt (dtr 270) TlHeight~) "")
    );if
    (setq Cnt# (1+ Cnt#))
  );foreach
  (setq Pt InsPt)
  (repeat EndRow#
    (setq Pt (polar Pt (dtr 270) RowHeight~)); Row height
    (command "LINE" Pt (polar Pt 0 TlWidth~) "")
  );repeat
  (command "LAYER" "T" TextLayer$ "U" TextLayer$ "ON" TextLayer$ "S" TextLayer$ "")
  (setq Pt (polar InsPt (dtr 270) (+ (* RowHeight~ 0.5) (* TextHeight~ 0.5)))); Locate text insertion point
  (foreach Item ExcelData@
    (setq Pt (polar Pt 0 (/ (nth 0 Item) 2.0)))
    (cond
      ((= Justify$ "Center")(setq TxPt Pt))
      ((= Justify$ "Left")(setq TxPt (polar Pt pi (- (/ (nth 0 Item) 2.0) TextGap~))))
      ((= Justify$ "Right")(setq TxPt (polar Pt 0 (- (/ (nth 0 Item) 2.0) TextGap~))))
    );cond
    (foreach Text$ Item
      (if (not (equal Text$ (nth 0 Item)))
        (progn
          (if (= Justify$ "Left")
            (command "TEXT" TxPt "" "" Text$)
            (command "TEXT" "J" Justify$ TxPt "" "" Text$)
          );if
          (setq TxPt (polar TxPt (dtr 270) RowHeight~)); Next text insertion point
        );progn
      );if
    );foreach
    (setq Pt (polar Pt 0 (/ (nth 0 Item) 2.0)))
    (Whirl)
  );foreach
  (princ " ")
  (princ "\nDraw Excel Complete!")
  (if (/= TextStyleHeight~ 0)
    (command "STYLE" TextStyle$ "" TextStyleHeight~ "" "" "" "" "")
  );if
  (command "UNDO" "END")
  (setvar "CMDECHO" CmdEcho#)
  (setvar "OSMODE" Osmode#)
  (princ)
);defun DrawExcel
;-------------------------------------------------------------------------------
; GetExcel - Stores the values from an Excel spreadsheet into *ExcelData@ list
; Arguments: 3
;   ExcelFile$ = Path and filename
;   SheetName$ = Sheet name or nil for not specified
;   MaxRange$ = Maximum cell ID range to include
; Syntax examples:
; (GetExcel "C:\\Temp\\Temp.xls" "Sheet1" "E19") = Open C:\Temp\Temp.xls on Sheet1 and read up to cell E19
; (GetExcel "C:\\Temp\\Temp.xls" nil "XYZ123") = Open C:\Temp\Temp.xls on current sheet and read up to cell XYZ123
;-------------------------------------------------------------------------------
(defun GetExcel (ExcelFile$ SheetName$ MaxRange$ / Column# ColumnRow@ Data@ ExcelRange^
  ExcelValue ExcelValue ExcelVariant^ MaxColumn# MaxRow# Range$ Row# Worksheet)
  (if (= (type ExcelFile$) 'STR)
    (if (not (findfile ExcelFile$))
      (progn
        (alert (strcat "Excel file " ExcelFile$ " not found."))
        (exit)
      );progn
    );if
    (progn
      (alert "Excel file not specified.")
      (exit)
    );progn
  );if
  (gc)
  (if (setq *ExcelApp% (vlax-get-object "Excel.Application"))
    (progn
      (alert "Close all Excel spreadsheets to continue!")
      (vlax-release-object *ExcelApp%)(gc)
    );progn
  );if
  (setq *ExcelApp% (vlax-get-or-create-object "Excel.Application"))
  (vlax-invoke-method (vlax-get-property *ExcelApp% 'WorkBooks) 'Open ExcelFile$)
  (if SheetName$
    (vlax-for Worksheet (vlax-get-property *ExcelApp% "Sheets")
      (if (= (vlax-get-property Worksheet "Name") SheetName$)
        (vlax-invoke-method Worksheet "Activate")
      );if
    );vlax-for
  );if
  (setq ColumnRow@ (ColumnRow MaxRange$))
  (setq MaxColumn# (nth 0 ColumnRow@))
  (setq MaxRow# (nth 1 ColumnRow@))
  (setq *ExcelData@ nil)
  (setq Row# 1)
  (repeat MaxRow#
    (setq Data@ nil)
    (setq Column# 1)
    (repeat MaxColumn#
      (setq Range$ (strcat (Number2Alpha Column#)(itoa Row#)))
      (setq ExcelRange^ (vlax-get-property *ExcelApp% "Range" Range$))
      (setq ExcelVariant^ (vlax-get-property ExcelRange^ 'Value))
      (setq ExcelValue (vlax-variant-value ExcelVariant^))
      (setq ExcelValue
        (cond
          ((= (type ExcelValue) 'INT) (itoa ExcelValue))
          ((= (type ExcelValue) 'REAL) (rtosr ExcelValue))
          ((= (type ExcelValue) 'STR) (vl-string-trim " " ExcelValue))
          ((/= (type ExcelValue) 'STR) "")
        );cond
      );setq
      (setq Data@ (append Data@ (list ExcelValue)))
      (setq Column# (1+ Column#))
    );repeat
    (setq *ExcelData@ (append *ExcelData@ (list Data@)))
    (setq Row# (1+ Row#))
  );repeat
  (vlax-invoke-method (vlax-get-property *ExcelApp% "ActiveWorkbook") 'Close :vlax-False)
  (vlax-invoke-method *ExcelApp% 'Quit)
  (vlax-release-object *ExcelApp%)(gc)
  (setq *ExcelApp% nil)
  *ExcelData@
);defun GetExcel
;-------------------------------------------------------------------------------
; GetCell - Returns the cell value from the *ExcelData@ list
; Arguments: 1
;   Cell$ = Cell ID
; Syntax example: (GetCell "E19") = value of cell E19
;-------------------------------------------------------------------------------
(defun GetCell (Cell$ / Column# ColumnRow@ Return Row#)
  (setq ColumnRow@ (ColumnRow Cell$))
  (setq Column# (1- (nth 0 ColumnRow@)))
  (setq Row# (1- (nth 1 ColumnRow@)))
  (setq Return "")
  (if *ExcelData@
    (if (and (>= (length *ExcelData@) Row#)(>= (length (nth 0 *ExcelData@)) Column#))
      (setq Return (nth Column# (nth Row# *ExcelData@)))
    );if
  );if
  Return
);defun GetCell
;-------------------------------------------------------------------------------
; OpenExcel - Opens an Excel spreadsheet
; Arguments: 3
;   ExcelFile$ = Excel filename or nil for new spreadsheet
;   SheetName$ = Sheet name or nil for not specified
;   Visible = t for visible or nil for hidden
; Syntax examples:
; (OpenExcel "C:\\Temp\\Temp.xls" "Sheet2" t) = Opens C:\Temp\Temp.xls on Sheet2 as visible session
; (OpenExcel "C:\\Temp\\Temp.xls" nil nil) = Opens C:\Temp\Temp.xls on current sheet as hidden session
; (OpenExcel nil "Parts List" nil) =  Opens a new spreadsheet and creates a Part List sheet as hidden session
;-------------------------------------------------------------------------------
(defun OpenExcel (ExcelFile$ SheetName$ Visible / Sheet$ Sheets@ Worksheet)
  (if (= (type ExcelFile$) 'STR)
    (if (findfile ExcelFile$)
      (setq *ExcelFile$ ExcelFile$)
      (progn
        (alert (strcat "Excel file " ExcelFile$ " not found."))
        (exit)
      );progn
    );if
    (setq *ExcelFile$ "")
  );if
  (gc)
  (if (setq *ExcelApp% (vlax-get-object "Excel.Application"))
    (progn
      (alert "Close all Excel spreadsheets to continue!")
      (vlax-release-object *ExcelApp%)(gc)
    );progn
  );if
  (setq *ExcelApp% (vlax-get-or-create-object "Excel.Application"))
  (if ExcelFile$
    (if (findfile ExcelFile$)
      (vlax-invoke-method (vlax-get-property *ExcelApp% 'WorkBooks) 'Open ExcelFile$)
      (vlax-invoke-method (vlax-get-property *ExcelApp% 'WorkBooks) 'Add)
    );if
    (vlax-invoke-method (vlax-get-property *ExcelApp% 'WorkBooks) 'Add)
  );if
  (if Visible
    (vla-put-visible *ExcelApp% :vlax-true)
  );if
  (if (= (type SheetName$) 'STR)
    (progn
      (vlax-for Sheet$ (vlax-get-property *ExcelApp% "Sheets")
        (setq Sheets@ (append Sheets@ (list (vlax-get-property Sheet$ "Name"))))
      );vlax-for
      (if (member SheetName$ Sheets@)
        (vlax-for Worksheet (vlax-get-property *ExcelApp% "Sheets")
          (if (= (vlax-get-property Worksheet "Name") SheetName$)
            (vlax-invoke-method Worksheet "Activate")
          );if
        );vlax-for
        (vlax-put-property (vlax-invoke-method (vlax-get-property *ExcelApp% "Sheets") "Add") "Name" SheetName$)
      );if
    );progn
  );if
  (princ)
);defun OpenExcel
;-------------------------------------------------------------------------------
; PutCell - Put values into Excel cells
; Arguments: 2
;   StartCell$ = Starting Cell ID
;   Data@ = Value or list of values
; Syntax examples:
; (PutCell "A1" "PART NUMBER") = Puts PART NUMBER in cell A1
; (PutCell "B3" '("Dim" 7.5 "9.75")) = Starting with cell B3 put Dim, 7.5, and 9.75 across
;-------------------------------------------------------------------------------
(defun PutCell (StartCell$ Data@ / Column# ExcelRange Row#)
  (if (= (type Data@) 'STR)
    (setq Data@ (list Data@))
  );if
  (setq Column# (nth 0 (ColumnRow StartCell$)))
  (setq Row# (nth 1 (ColumnRow StartCell$)))
  (setq ExcelRange (vlax-get-property *ExcelApp% "Cells"))
  (foreach Item Data@
    (vlax-put-property ExcelRange "Item" Row# Column# (vl-princ-to-string Item))
    (setq Column# (1+ Column#))
  );foreach
  (princ)
);defun PutCell
;-------------------------------------------------------------------------------
; CloseExcel - Closes Excel spreadsheet
; Arguments: 1
;   ExcelFile$ = Excel saveas filename or nil to close without saving
; Syntax examples:
; (CloseExcel "C:\\Temp\\Temp.xls") = Saveas C:\Temp\Temp.xls and close
; (CloseExcel nil) = Close without saving
;-------------------------------------------------------------------------------
(defun CloseExcel (ExcelFile$ / Saveas)
  (if ExcelFile$
    (if (= (strcase ExcelFile$) (strcase *ExcelFile$))
      (if (findfile ExcelFile$)
        (vlax-invoke-method (vlax-get-property *ExcelApp% "ActiveWorkbook") "Save")
        (setq Saveas t)
      );if
      (if (findfile ExcelFile$)
        (progn
          (vl-file-delete (findfile ExcelFile$))
          (setq Saveas t)
        );progn
        (setq Saveas t)
      );if
    );if
  );if
  (if Saveas
    (vlax-invoke-method (vlax-get-property *ExcelApp% "ActiveWorkbook")
      "SaveAs" ExcelFile$ -4143 "" "" :vlax-false :vlax-false nil
    );vlax-invoke-method
  );if
  (vlax-invoke-method (vlax-get-property *ExcelApp% "ActiveWorkbook") 'Close :vlax-False)
  (vlax-invoke-method *ExcelApp% 'Quit)
  (vlax-release-object *ExcelApp%)(gc)
  (setq *ExcelApp% nil *ExcelFile$ nil)
  (princ)
);defun CloseExcel
;-------------------------------------------------------------------------------
; ColumnRow - Returns a list of the Column and Row number
; Function By: Gilles Chanteau from Marseille, France
; Arguments: 1
;   Cell$ = Cell ID
; Syntax example: (ColumnRow "ABC987") = '(731 987)
;-------------------------------------------------------------------------------
(defun ColumnRow (Cell$ / Column$ Char$ Row#)
  (setq Column$ "")
  (while (< 64 (ascii (setq Char$ (strcase (substr Cell$ 1 1)))) 91)
    (setq Column$ (strcat Column$ Char$)
          Cell$ (substr Cell$ 2)
    );setq
  );while
  (if (and (/= Column$ "") (numberp (setq Row# (read Cell$))))
    (list (Alpha2Number Column$) Row#)
    '(1 1);default to "A1" if there's a problem
  );if
);defun ColumnRow
;-------------------------------------------------------------------------------
; Alpha2Number - Converts Alpha string into Number
; Function By: Gilles Chanteau from Marseille, France
; Arguments: 1
;   Str$ = String to convert
; Syntax example: (Alpha2Number "ABC") = 731
;-------------------------------------------------------------------------------
(defun Alpha2Number (Str$ / Num#)
  (if (= 0 (setq Num# (strlen Str$)))
    0
    (+ (* (- (ascii (strcase (substr Str$ 1 1))) 64) (expt 26 (1- Num#)))
       (Alpha2Number (substr Str$ 2))
    );+
  );if
);defun Alpha2Number
;-------------------------------------------------------------------------------
; Number2Alpha - Converts Number into Alpha string
; Function By: Gilles Chanteau from Marseille, France
; Arguments: 1
;   Num# = Number to convert
; Syntax example: (Number2Alpha 731) = "ABC"
;-------------------------------------------------------------------------------
(defun Number2Alpha (Num# / Val#)
  (if (< Num# 27)
    (chr (+ 64 Num#))
    (if (= 0 (setq Val# (rem Num# 26)))
      (strcat (Number2Alpha (1- (/ Num# 26))) "Z")
      (strcat (Number2Alpha (/ Num# 26)) (chr (+ 64 Val#)))
    );if
  );if
);defun Number2Alpha
;-------------------------------------------------------------------------------
; rtosr - Used to change a real number into a short real number string
; stripping off all trailing 0's.
; Arguments: 1
;   RealNum~ = Real number to convert to a short string real number
; Returns: ShortReal$ the short string real number value of the real number.
;-------------------------------------------------------------------------------
(defun rtosr (RealNum~ / DimZin# ShortReal$)
  (setq DimZin# (getvar "DIMZIN"))
  (setvar "DIMZIN" 8)
  (setq ShortReal$ (rtos RealNum~ 2 8))
  (setvar "DIMZIN" DimZin#)
  ShortReal$
);defun rtosr
;-------------------------------------------------------------------------------
; Start of DrawExcel Support Utility Functions
;-------------------------------------------------------------------------------
; Capitals - Capitalizes the first letter of each group of letters in a String.
; Arguments: 1
;   Str$ = String
; Returns: String with the first letter of each group of letters capitalized.
;-------------------------------------------------------------------------------
(defun Capitals (Str$ / Cnt# CapFlag Char$ Return$)
  (if (= (type Str$) 'STR)
    (progn
      (setq Str$ (strcase Str$ t))
      (setq Cnt# 1 Return$ "")
      (while (<= Cnt# (strlen Str$))
        (setq Char$ (substr Str$ Cnt# 1))
        (if (or (= Char$ ".") (and (>= Char$ "a") (<= Char$ "z")))
          (if CapFlag
            (setq Return$ (strcat Return$ Char$))
            (progn
              (setq Return$ (strcat Return$ (strcase Char$)))
              (setq CapFlag t)
            );progn
          );if
          (progn
            (setq Return$ (strcat Return$ Char$))
            (setq CapFlag nil)
          );progn
        );if
        (setq Cnt# (1+ Cnt#))
      );while
    );progn
  );if
  Return$
);defun Capitals
;-------------------------------------------------------------------------------
; CommaList - Returns a list of Strings
; Arguments: 1
;   Str$ = String to convert into a list strings
; Syntax: (CommaList "1,2,3,4") = (list "1" "2" "3" "4")
; Returns: List of strings that were seperated by commas
;-------------------------------------------------------------------------------
(defun CommaList (Str$ / List@ Num#)
  (while (setq Num# (vl-string-search "," Str$))
    (setq List@ (cons (substr Str$ 1 Num#) List@)
          Str$ (substr Str$ (+ Num# 2))
    );setq
  );while
  (reverse (cons Str$ List@))
);defun CommaList
;-------------------------------------------------------------------------------
; FindInList - Finds the associated Item from two lists
; Arguments: 3
;   Item = Item to find
;   SearchList@ = List to search in
;   InList@ = List used to return the nth where Item was found in SearchList@
; Returns: The associated Item in InList@
;-------------------------------------------------------------------------------
(defun FindInList (Item SearchList@ InList@)
  (nth (- (length SearchList@) (length (member Item SearchList@))) InList@)
);defun FindInList
;-------------------------------------------------------------------------------
; GetFonts - Gets the list of text fonts
;-------------------------------------------------------------------------------
(defun GetFonts (/ Font$ FontList@ Fonts@ List@ Styles@ Table@)
  (setq Table@ (tblnext "STYLE" t))
  (setq Styles@ (list (Capitals (cdr (assoc 2 Table@)))))
  (setq Font$ (FindReplace (Capitals (cdr (assoc 3 Table@))) ".shx" ""))
  (setq Fonts@ (list (FindReplace Font$ ".ttf" "")))
  (while (setq Table@ (tblnext "STYLE"))
    (setq Styles@ (append Styles@ (list (Capitals (cdr (assoc 2 Table@))))))
    (setq Font$ (FindReplace (Capitals (cdr (assoc 3 Table@))) ".shx" ""))
    (setq Fonts@ (append Fonts@ (list (FindReplace Font$ ".ttf" ""))))
  );while
  (setq List@ (acad_strlsort Styles@))
  (foreach Style$ List@
    (setq FontList@ (append FontList@ (list (FindInList Style$ Styles@ Fonts@))))
  );foreach
  FontList@
);defun GetFonts
;-------------------------------------------------------------------------------
; GetLayers - Gets the list of layers
;-------------------------------------------------------------------------------
(defun GetLayers (/ Layers@ Table@)
  (setq Table@ (tblnext "LAYER" t))
  (setq Layers@ (list (cdr (assoc 2 Table@))))
  (while (setq Table@ (tblnext "LAYER"))
    (setq Layers@ (append Layers@ (list (cdr (assoc 2 Table@)))))
  );while
  (acad_strlsort Layers@)
);defun GetLayers
;-------------------------------------------------------------------------------
; GetLayerColors - Gets the list of layer colors
;-------------------------------------------------------------------------------
(defun GetLayerColors (/ Colors@ Layer$ Layers@ LayerColors@ List@ Table@)
  (setq Table@ (tblnext "LAYER" t))
  (setq Layers@ (list (cdr (assoc 2 Table@))))
  (setq Colors@ (list (cdr (assoc 62 Table@))))
  (while (setq Table@ (tblnext "LAYER"))
    (setq Layers@ (append Layers@ (list (cdr (assoc 2 Table@)))))
    (setq Colors@ (append Colors@ (list (cdr (assoc 62 Table@)))))
  );while
  (setq List@ (acad_strlsort Layers@))
  (foreach Layer$ List@
    (setq LayerColors@ (append LayerColors@ (list (FindInList Layer$ Layers@ Colors@))))
  );foreach
  LayerColors@
);defun GetLayerColors
;-------------------------------------------------------------------------------
; GetPath - Used to get the path from the path and filename.
; Arguments: 1
;   PathFilename$ = Path and filename string
; Returns: Pathname string.
;-------------------------------------------------------------------------------
(defun GetPath (PathFilename$)
  (strcat (vl-filename-directory PathFilename$) "\\")
);defun GetPath
;-------------------------------------------------------------------------------
; GetStyles - Gets the list of text styles
;-------------------------------------------------------------------------------
(defun GetStyles (/ Styles@ Table@)
  (setq Table@ (tblnext "STYLE" t))
  (setq Styles@ (list (Capitals (cdr (assoc 2 Table@)))))
  (while (setq Table@ (tblnext "STYLE"))
    (setq Styles@ (append Styles@ (list (Capitals (cdr (assoc 2 Table@))))))
  );while
  (acad_strlsort Styles@)
);defun GetStyles
;-------------------------------------------------------------------------------
; GetStyleHeights - Gets the list of text style heights
;-------------------------------------------------------------------------------
(defun GetStyleHeights (/ HeightList@ Heights@ List@ Styles@ Table@)
  (setq Table@ (tblnext "STYLE" t))
  (setq Styles@ (list (Capitals (cdr (assoc 2 Table@)))))
  (setq Heights@ (list (cdr (assoc 40 Table@))))
  (while (setq Table@ (tblnext "STYLE"))
    (setq Styles@ (append Styles@ (list (Capitals (cdr (assoc 2 Table@))))))
    (setq Heights@ (append Heights@ (list (cdr (assoc 40 Table@)))))
  );while
  (setq List@ (acad_strlsort Styles@))
  (foreach Style$ List@
    (setq HeightList@ (append HeightList@ (list (FindInList Style$ Styles@ Heights@))))
  );foreach
  HeightList@
);defun GetStyleHeights
;-------------------------------------------------------------------------------
; number_sort - Sorts list of numbers
; Arguments: 1
;   List@ = List of numbers
; Returns: List of sorted numbers
;-------------------------------------------------------------------------------
(defun number_sort (List@ / High~ Item~ List1@ List2@ Low~ NewList@ Passed Swap~)
  (setq Passed t)
  (if (= (type List@) 'LIST)
    (foreach Item~ List@ (if (not (numberp Item~)) (setq Passed nil)))
    (setq Passed nil)
  );if
  (if (not Passed)
    (progn (princ "\nUsage: (number_sort <list of numbers>)") (exit))
  );if
  (repeat (/ (length List@) 2)
    (setq Low~ (car List@) High~ nil NewList@ nil)
    (foreach Item~ (cdr List@)
      (and (< Item~ Low~) (setq Swap~ Low~ Low~ Item~ Item~ Swap~))
      (and (> Item~ High~) (setq Swap~ High~ High~ Item~ Item~ Swap~))
      (setq NewList@ (cons Item~ NewList@))
    );foreach
    (setq List1@ (cons Low~ List1@) List2@ (cons High~ List2@) List@ (cdr (reverse NewList@)))
  );repeat
  (append (reverse List1@) List@ List2@)
);defun number_sort
;-------------------------------------------------------------------------------
; check_editreal - Function to verify if value is a real number
; Arguments: 1
;   SentVar$ = String of the variable name
; Syntax: (check_editreal "Variable")
;-------------------------------------------------------------------------------
(defun check_editreal (SentVar$ / Cnt# Loop Mid$ Passed Period# SubVar$)
  (setq SubVar$ (eval (read SentVar$)))
  (setq Cnt# 1 Passed t Period# 0)
  (repeat (strlen $value)
    (setq Mid$ (substr $value Cnt# 1))
    (if (not (member Mid$ (list "." "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
      (setq Passed nil)
    );if
    (if (= Mid$ ".")(setq Period# (1+ Period#)))
    (setq Cnt# (1+ Cnt#))
  );repeat
  (if (> Period# 1)(setq Passed nil))
  (if (not Passed)
    (progn
      (alert "Value must be a real number!")
      (set_tile $key SubVar$)
    );progn
    (if (= $value "")
      (set (read SentVar$) $value)
      (progn
        (setq Loop t Cnt# 8)
        (while Loop
          (setq $value (rtos (atof $value) 2 Cnt#))
          (if (= (atof $value) (atof (rtos (atof $value) 2 (1- Cnt#))))
            (setq Cnt# (1- Cnt#))
            (setq Loop nil)
          );if
          (if (= Cnt# 0) (setq Loop nil))
        );while
        (set (read SentVar$) $value)
        (set_tile $key $value)
      );progn
    );if
  );if
  (princ)
);defun check_editreal
;-------------------------------------------------------------------------------
; FindReplace - Returns Str$ with Find$ changed to Replace$
; Arguments: 3
;   Str$ = Text string
;   Find$ = Phrase string to find
;   Replace$ = Phrase to replace Find$ with
; Syntax: (FindReplace "TO SCALE" "TO" "NOT TO")
; Returns: Returns Str$ with Find$ changed to Replace$
;-------------------------------------------------------------------------------
(defun FindReplace (Str$ Find$ Replace$ / Len# Num# Start#)
  (setq Len# (strlen Replace$))
  (while (setq Num# (vl-string-search Find$ Str$ Start#))
    (setq Str$ (vl-string-subst Replace$ Find$ Str$ Num#)
          Start# (+ Num# Len#)
    );setq
  );while
  Str$
);defun FindReplace
;-------------------------------------------------------------------------------
; Delete_nth - Deletes the nth item from a list.
; Arguments: 2
;   Num# = Nth number in list to delete
;   OldList@ = List to delete the nth item
; Returns: A list with the nth item deleted.
;-------------------------------------------------------------------------------
(defun Delete_nth (Num# OldList@)
  (setq Num# (1+ Num#))
  (vl-remove-if '(lambda (x) (zerop (setq Num# (1- Num#)))) OldList@)
);defun Delete_nth
;-------------------------------------------------------------------------------
; Insert_nth - Inserts a new item value into the nth number in list.
; Arguments: 3
;   Num# = Nth number in list to insert item value
;   Value = Item value to insert
;   OldList@ = List to insert item value
; Returns: A list with the new item value inserted.
;-------------------------------------------------------------------------------
(defun Insert_nth (Num# Value OldList@ / Temp@)
  (if (< -1 Num# (1+ (length OldList@)))
    (progn
      (repeat Num#
        (setq Temp@ (cons (car OldList@) Temp@)
              OldList@ (cdr OldList@)
        );setq
      );repeat
      (append (reverse Temp@) (list Value) OldList@)
    );progn
    OldList@
  );if
);defun Insert_nth
;-------------------------------------------------------------------------------
; Whirl - Displays a whirl on the command line used during long delays while
; processing information. Use (princ " ") after loop to erase last Whirl symbol.
; Returns: Global variable *Whirl# is used for displaying whirls.
;-------------------------------------------------------------------------------
(defun Whirl ()
  (if *Whirl#
    (setq *Whirl# (1+ *Whirl#))
    (setq *Whirl# 1)
  );if
  (if (>= *Whirl# 5)
    (setq *Whirl# 1)
  );if
  (cond
    ((= *Whirl# 1)(princ "-"))
    ((= *Whirl# 2)(princ "\\"))
    ((= *Whirl# 3)(princ "|"))
    ((= *Whirl# 4)(princ "/"))
  );cond
  (princ "\010")
);defun Whirl
;-------------------------------------------------------------------------------
; DrawExcel_Support - Checks to see if supporting functions are loaded
;-------------------------------------------------------------------------------
(defun DrawExcel_Support ()
  (if (or (not GetOK)(not EditBox))
    (progn
      (if (or (not GetOK)(not EditBox))
        (if (findfile "GetIcon.lsp")
          (load "GetIcon.lsp")
        );if
      );if
      (if (or (not GetOK)(not EditBox))
        (progn
          (alert (strcat "DrawExcel requires the functions inside of GetIcon.lsp."
            "\nDownload the latest versions from AutoLISP Exchange,"
            "\n(URL: http://web2.airmail.net/terrycad).")
          );alert
          (exit)
        );progn
      );if
    );progn
  );if
  (if (not (findfile "C:\\Temp\\Temp.dcl"))
    (progn (vl-load-com)(vl-mkdir "C:\\Temp"))
  );if
);defun DrawExcel_Support
;-------------------------------------------------------------------------------
(princ);End of DrawExcel.lsp