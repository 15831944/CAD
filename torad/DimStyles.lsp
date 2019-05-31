;-------------------------------------------------------------------------------
; Program Name: DimStyles.lsp [DimStyles R3]
; Created By:   Terry Miller (Email: terrycadd@yahoo.com)
;               (URL: http://web2.airmail.net/terrycad)
; Date Created: 1-20-05
; Function:     Creates and sets Dimension Styles for Linear, Angular, Diameter,
;               Ordinate and Radial styles. DimStyles.lsp may be easily
;               customized by editing the SetDimVars function and in the
;               "Exceptions to SetDimVars" areas.
; Note:         Edit the lines ending with "<--Change to your Dim layer info"
;               as required.  DimStyles requires functions inside of GetIcon.lsp
;               and Dcl_Tiles.lsp.  Also change your LTSCALE back to 0.25 or
;               your default setting when plotting layouts.
;-------------------------------------------------------------------------------
; Revision History
; Rev  By     Date    Description
;-------------------------------------------------------------------------------
; 1    TM   1-20-05   Initial version
; 2    TM   3-20-05   Revised to include the dimscales of other Dim Styles.
; 3    TM   7-20-05   Revised dialog to include Architectural scales.  Also
;                     added c:DD, dim diameter, and c:DR, dim radius functions.
;-------------------------------------------------------------------------------
; Note: Edit the line below to change your default TextSize
;-------------------------------------------------------------------------------
(setq *DimTextSize~ 0.0625);<--Change to your default TextSize
;-------------------------------------------------------------------------------
; c:DimStyles - Dimension Styles
;-------------------------------------------------------------------------------
(defun c:DS ()(c:DimStyles)(princ));Shortcut
(defun c:DimStyles (/ ArchScales@ Chk_Value: DimScale$ DimScale~ DimScales@
  List@ List001@ Other001@ Return# Var001$ Var002$ Var003$ Var004$)
  (setvar "CMDECHO" 0)
  (princ "\nDimension Styles ")
  (DimStyles_Support)
  ;-----------------------------------------------------------------------------
  ; Chk_Value: - Check dialog values
  ;-----------------------------------------------------------------------------
  (defun Chk_Value: ($key $value / KeyName$ NumKey$ SaveVar$ TitleBar$ VarNum$)
    (setq NumKey$ (substr $key (- (strlen $key) 2))   ; Last 3 digits
          VarNum$ (strcat "Var" NumKey$ "$")          ; Variable name
          SaveVar$ (eval (read VarNum$))              ; Previous value
          KeyName$ (substr $key 1 (- (strlen $key) 3)); Key name
    );setq
    (if (= NumKey$ "001")
      (setq TitleBar$ "Other Dim Scale")
    );if
    (Set_Value $key $value)
    ;---------------------------------------------------------------------------
    ; Exceptions to Set_Value
    ;---------------------------------------------------------------------------
    (if (and (= NumKey$ "001") (<= (atof Var001$) 0))
      (GetOK "Invalid Value" "Dim Scale must be greater than 0!" "exclam")
    );if
    (if (and (= NumKey$ "001") (<= (atof Var001$) 0))
      (setq Var001$ SaveVar$)
    );if
    (setq Var001$ (rtosr (atof Var001$))
          List001@ DimScales@
          Other001@ List001@
          DimScale~ (atof Var001$)
          Var003$ (rtosr (* *DimTextSize~ DimScale~))
          Var004$ (strcat "1/" Var001$ "xp")
    );setq
    (if (member Var001$ DimScales@)
      (setq Var002$ (FindInList Var001$ DimScales@ ArchScales@))
      (setq Var002$ (strcat "1\" = " (ArchOrReal Var001$)))
    );if
    (if (not (member Var001$ List001@))
      (progn
        (setq Cnt# 0 List001@ (cons "0" List001@))
        (foreach Item List001@
          (if (and (> (atof Var001$) (atof Item)) (/= Item "Other"))
            (setq List@ (Insert_nth (1+ Cnt#) Var001$ List001@))
          );if
          (setq Cnt# (1+ Cnt#))
        );foreach
        (setq List001@ (Delete_nth 0 List@))
      );progn
    );if
    (set_tile_list "ListReal001" List001@ Var001$)
    (set_tile "Edit002" Var002$)
    (set_tile "Edit003" Var003$)
    (set_tile "Edit004" Var004$)
    (princ)
  );defun Chk_Value:
  ;-----------------------------------------------------------------------------
  ; Set Variables and List Values
  ;-----------------------------------------------------------------------------
  (setq ArchScales@ (list "1\" = 1/2\"" "1\" = 1\"" "6\" = 1'-0\"" "3\" = 1'-0\"" "1\" = 6\"" "1 1/2\" = 1'-0\"" "1\" = 10\"" "1\" = 1'-0\"" "1\" = 1'-2\"" "3/4\" = 1'-0\"" "1\" = 1'-8\"" "1/2\" = 1'-0\"" "1\" = 2'-4\"" "3/8\" = 1'-0\"" "1\" = 3'-4\"" "1/4\" = 1'-0\"" "1\" = 4'-8\"" "3/16\" = 1'-0\"" "1\" = 6'-0\"" "1\" = 6'-8\"" "1\" = 7'-4\"" "1/8\" = 1'-0\"" "1\" = 8'-8\"" "1\" = 9'-4\"" "1\" = 10'-0\"" "3/32\" = 1'-0\"")
        DimScales@  (list "0.5"         "1"         "2"            "4"            "6"         "8"                "10"         "12"           "14"           "16"             "20"           "24"             "28"           "32"             "40"           "48"             "56"           "64"              "72"           "80"           "88"           "96"             "104"          "112"          "120"           "128"             "Other")
        List001@ DimScales@
        Other001@ List001@
        DimScale~ (getvar "DIMSCALE")
  );setq
  (if (<= DimScale~ 0) (setq DimScale~ 1))
  (setq Var001$ (rtosr DimScale~)
        Var003$ (rtosr (* *DimTextSize~ DimScale~))
        Var004$ (strcat "1/" Var001$ "xp")
  );setq
  (if (member Var001$ DimScales@)
    (setq Var002$ (FindInList Var001$ DimScales@ ArchScales@))
    (setq Var002$ (strcat "1\" = " (ArchOrReal Var001$)))
  );if
  (if (not (member Var001$ List001@))
    (progn
      (setq Cnt# 0 List001@ (cons "0" List001@))
      (foreach Item List001@
        (if (and (> (atof Var001$) (atof Item)) (/= Item "Other"))
          (setq List@ (Insert_nth (1+ Cnt#) Var001$ List001@))
        );if
        (setq Cnt# (1+ Cnt#))
      );foreach
      (setq List001@ (Delete_nth 0 List@))
    );progn
  );if
  ;-----------------------------------------------------------------------------
  ; Load Dialog
  ;-----------------------------------------------------------------------------
  (setq Dcl_Id% (load_dialog "DimStyles.dcl"))
  (new_dialog "DimStyles" Dcl_Id%)
  ;-----------------------------------------------------------------------------
  ; Set Dialog Initial Settings
  ;-----------------------------------------------------------------------------
  (set_tile "Title" " Dimension Styles")
  (set_tile "Text001" "Dim Scale")
  (set_tile_list "ListReal001" List001@ Var001$)
  (set_tile "Text002" "Arch Scale")
  (set_tile "Edit002" Var002$)
  (set_tile "Text003" "Text Height")
  (set_tile "Edit003" Var003$)
  (set_tile "Text004" "Zoom Scale")
  (set_tile "Edit004" Var004$)
  ;-----------------------------------------------------------------------------
  ; Dialog Actions
  ;-----------------------------------------------------------------------------
  (action_tile "ListReal001" "(Chk_Value: $key $value)")
  (action_tile "Edit002"     "(Chk_Value: $key $value)")
  (action_tile "Edit003"     "(Chk_Value: $key $value)")
  (action_tile "Edit004"     "(Chk_Value: $key $value)")
  (setq Return# (start_dialog))
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (exit))
  (DS (atof Var001$))
  (princ (strcat "\nDimension Style DS-" Var001$ " set."))
  (princ)
);defun c:DimStyle
;-------------------------------------------------------------------------------
; DS - Creates Dimension Styles
; Arguments: 1
;   DimScale~ = DimScale value
; Syntax: (DS 16)
; Returns: Creates and sets the DS-16 dimension style.
;-------------------------------------------------------------------------------
(defun DS (DimScale~ / BaseDimStyle$ RegenMode# SubDimStyle$)
  (setvar "DIMSCALE" DimScale~)
  (setq RegenMode# (getvar "REGENMODE"))
  (setvar "REGENMODE" 0)
  (command "STYLE" "ROMANS" "ROMANS.shx" "0.0" "0.8" "" "" "" "")
  (setq BaseDimStyle$ (strcat "DS-" (rtosr DimScale~)))
  ;Linear dimensions -----------------------------------------------------------
  (SetDimVars);Exceptions to SetDimVars
  (if (tblsearch "DIMSTYLE" BaseDimStyle$)
    (command "DIMSTYLE" "S" BaseDimStyle$ "Y")
    (command "DIMSTYLE" "S" BaseDimStyle$)
  );if
  ;Angular dimensions ----------------------------------------------------------
  (setq SubDimStyle$ (strcat BaseDimStyle$ "$2"))
  (SetDimVars);Exceptions to SetDimVars
  (setvar "DIMBLK" ".") ;Arrow block name
  (if (tblsearch "DIMSTYLE" SubDimStyle$)
    (command "DIMSTYLE" "S" SubDimStyle$ "Y")
    (command "DIMSTYLE" "S" SubDimStyle$)
  );if
  ;Diameter dimensions ---------------------------------------------------------
  (setq SubDimStyle$ (strcat BaseDimStyle$ "$3"))
  (SetDimVars);Exceptions to SetDimVars
  (setvar "DIMBLK" ".") ;Arrow block name
  (setvar "DIMFIT" 3)       ;Fit text and arrows, replaced with DIMATFIT
  (setvar "DIMTAD" 0);Off   ;Place text above the dimension line
  (setvar "DIMTIH" 1);On    ;Text inside extensions is horizontal
  (setvar "DIMTIX" 0);Off   ;Place text inside extensions
  (if (>= AcadVer# 15)
    (setvar "DIMTMOVE" 0)   ;Dimension text movement
  );if
  (setvar "DIMTOFL" 0);Off  ;Force line inside extension lines
  (setvar "DIMTOH" 1);On    ;Text outside horizontal
  (if (tblsearch "DIMSTYLE" SubDimStyle$)
    (command "DIMSTYLE" "S" SubDimStyle$ "Y")
    (command "DIMSTYLE" "S" SubDimStyle$)
  );if
  ;Ordinate dimensions ---------------------------------------------------------
  (setq SubDimStyle$ (strcat BaseDimStyle$ "$6"))
  (SetDimVars);Exceptions to SetDimVars
  (setvar "DIMTAD" 0);Off   ;Place text above the dimension line
  (if (tblsearch "DIMSTYLE" SubDimStyle$)
    (command "DIMSTYLE" "S" SubDimStyle$ "Y")
    (command "DIMSTYLE" "S" SubDimStyle$)
  );if
  ;Radial dimensions -----------------------------------------------------------
  (setq SubDimStyle$ (strcat BaseDimStyle$ "$4"))
  (SetDimVars);Exceptions to SetDimVars
  (setvar "DIMBLK" ".") ;Arrow block name
  (setvar "DIMFIT" 3)       ;Fit text and arrows, replaced with DIMATFIT
  (setvar "DIMTAD" 0);Off   ;Place text above the dimension line
  (setvar "DIMTIH" 1);On    ;Text inside extensions is horizontal
  (setvar "DIMTIX" 0);Off   ;Place text inside extensions
  (if (>= AcadVer# 15)
    (setvar "DIMTMOVE" 0)   ;Dimension text movement
  );if
  (setvar "DIMTOFL" 0);Off  ;Force line inside extension lines
  (setvar "DIMTOH" 1);On    ;Text outside horizontal
  (if (tblsearch "DIMSTYLE" SubDimStyle$)
    (command "DIMSTYLE" "S" SubDimStyle$ "Y")
    (command "DIMSTYLE" "S" SubDimStyle$)
  );if
  (command "DIMSTYLE" "R" BaseDimStyle$)
  (setvar "TEXTSIZE" (* *DimTextSize~ (getvar "DIMSCALE")))
  (setvar "REGENMODE" RegenMode#)
  (command "REGEN")
  (princ)
);defun DS
;-------------------------------------------------------------------------------
; SetDimVars - Set default dimension settings
;-------------------------------------------------------------------------------
(defun SetDimVars (/ AcadVer#)
  (setq AcadVer# (atoi (getvar "ACADVER")))
  (setvar "DIMADEC" 0)               ;Angular decimal places
  (setvar "DIMALT" 0);Off            ;Alternate units selected
  (setvar "DIMALTD" 2)               ;Alternate unit decimal places
  (setvar "DIMALTF" 1)               ;Alternate unit scale factor
  (if (>= AcadVer# 15)
    (setvar "DIMALTRND" 0)           ;Alternate units rounding value
  );if
  (setvar "DIMALTTD" 0)              ;Alternate tolerance decimal places
  (setvar "DIMALTTZ" 0)              ;Alternate tolerance zero suppression
  (setvar "DIMALTU" 2)               ;Alternate units
  (setvar "DIMALTZ" 0)               ;Alternate unit zero suppression
  (setvar "DIMAPOST" "\"")           ;Prefix and suffix for alternate text
  (if (>= AcadVer# 16)
    (setvar "DIMASSOC" 2)            ;Associative dimension
    (setvar "DIMASO" 1)
  );if
  (setvar "DIMASZ" *DimTextSize~)    ;Arrow size
  (if (>= AcadVer# 15)
    (setvar "DIMATFIT" 3)            ;Fit text and arrows
  );if
  (setvar "DIMAUNIT" 0)              ;Angular unit format
  (if (>= AcadVer# 15)
    (setvar "DIMAZIN" 0)             ;Zeros suppression for angular dimensions
  );if
  (setvar "DIMBLK" "Oblique")        ;Arrow block name
  (setvar "DIMBLK1" ".")             ;First arrow block name
  (setvar "DIMBLK2" ".")             ;Second arrow block name
  (setvar "DIMCEN" (* *DimTextSize~ 0.5));Center mark size
  (setvar "DIMCLRD" 256)             ;Dimension line and leader color
  (setvar "DIMCLRE" 256)             ;Extension line color
  (setvar "DIMCLRT" 256)             ;Dimension text color
  (setvar "DIMDLE" 0)                ;Dimension line extension
  (setvar "DIMDLI" (* *DimTextSize~ 3));Dimension line spacing between dimensions
  (setvar "DIMDSEP" ".")             ;Decimal dimension character separator
  (setvar "DIMEXE" (* *DimTextSize~ 0.5));Extension above dimension line
  (setvar "DIMEXO" (* *DimTextSize~ 0.5));Extension line origin offset
  (setvar "DIMFIT" 3)                ;Fit text and arrows, replaced with DIMATFIT
  (if (>= AcadVer# 15)
    (setvar "DIMFRAC" 0)             ;Fraction format for Architectural dimensions
  );if
  (setvar "DIMGAP" (* *DimTextSize~ 0.5));Gap from dimension line to text
  (setvar "DIMJUST" 0)               ;Justification of text on dimension line
  (if (>= AcadVer# 15)
    (setvar "DIMLDRBLK" "")          ;Arrow type for leaders
  );if
  (setvar "DIMLFAC" 1)               ;Linear measurements scale factor
  (setvar "DIMLIM" 0);Off            ;Generate dimension limits
  (if (>= AcadVer# 15)
    (progn
      (setvar "DIMLUNIT" 4)          ;Dimension units
      (setvar "DIMLWD" -3)           ;Assigns lineweight to dimension lines
      (setvar "DIMLWE" -3)           ;Assigns lineweight to extension lines
    );progn
  );if
  (setvar "DIMPOST" ".")             ;Prefix and suffix for dimension text
  (setvar "DIMRND" 0.0625)           ;Rounding value
  (setvar "DIMSAH" 0);Off            ;Separate arrow blocks
  (setvar "DIMSD1" 0);Off            ;Suppress the first dimension line
  (setvar "DIMSD2" 0);Off            ;Suppress the second dimension line
  (setvar "DIMSE1" 0);Off            ;Suppress the first extension line
  (setvar "DIMSE2" 0);Off            ;Suppress the second extension line
  (setvar "DIMSHO" 1);On             ;Update dimensions while dragging
  (setvar "DIMSOXD" 0);Off           ;Suppress outside dimension lines
  (setvar "DIMTAD" 1);On             ;Place text above the dimension line
  (setvar "DIMTDEC" 2)               ;Tolerance decimal places
  (setvar "DIMTFAC" 0.75)            ;Tolerance text height scaling factor
  (if (>= AcadVer# 15)
    (command "TSTACKSIZE" 75)        ;Mtext stacked text height
  );if
  (setvar "DIMTIH" 0);Off            ;Text inside extensions is horizontal
  (setvar "DIMTIX" 1);On             ;Place text inside extensions
  (setvar "DIMTM" 0)                 ;Minus tolerance
  (if (>= AcadVer# 15)
    (setvar "DIMTMOVE" 2)            ;Dimension text movement
  );if
  (setvar "DIMTOFL" 1);On            ;Force line inside extension lines
  (setvar "DIMTOH" 0);Off            ;Text outside horizontal
  (setvar "DIMTOL" 0);Off            ;Tolerance dimensioning
  (setvar "DIMTOLJ" 1)               ;Tolerance vertical justification
  (setvar "DIMTP" 0)                 ;Plus tolerance
  (setvar "DIMTSZ" 0)                ;Tick size
  (setvar "DIMTVP" 0)                ;Text vertical position
  (setvar "DIMTXSTY" "ROMANS")       ;Text style
  (setvar "DIMTXT" *DimTextSize~)    ;Text height
  (setvar "DIMTZIN" 3)               ;Tolerance zero suppression
  (setvar "DIMUNIT" 4)               ;Unit format
  (setvar "DIMUPT" 0);Off            ;User positioned text
  (setvar "DIMZIN" 3)                ;Zero suppression for feet and inches
  (setvar "LTSCALE" (* (getvar "DIMSCALE") 0.25));Linetype scale for Dimstyle
  ;Note: Change your LTSCALE back to 0.25 when plotting layouts.
);defun SetDimVars
;-------------------------------------------------------------------------------
; c:DD - Dim Diameter
;-------------------------------------------------------------------------------
(defun c:DD (/ Dimfit Dimtad Dimtih Dimtix Dimtofl Dimtoh)
  (princ "\nDIM Diameter")
  (command "LAYER" "M" "DimText" "C" "2" "" "");<--Change to your Dim layer info
  (setq Dimfit (getvar "DIMFIT")
        Dimtad (getvar "DIMTAD")
        Dimtih (getvar "DIMTIH")
        Dimtix (getvar "DIMTIX")
        Dimtofl (getvar "DIMTOFL")
        Dimtoh (getvar "DIMTOH")
  );setq
  (setvar "DIMFIT" 3)       ;Fit text and arrows, replaced with DIMATFIT
  (setvar "DIMTAD" 0);Off   ;Place text above the dimension line
  (setvar "DIMTIH" 1);On    ;Text inside extensions is horizontal
  (setvar "DIMTIX" 0);Off   ;Place text inside extensions
  (setvar "DIMTOFL" 0);Off  ;Force line inside extension lines
  (setvar "DIMTOH" 1);On    ;Text outside horizontal
  (command "DIMDIAMETER")
  (setvar "DIMFIT" Dimfit)
  (setvar "DIMTAD" Dimtad)
  (setvar "DIMTIH" Dimtih)
  (setvar "DIMTIX" Dimtix)
  (setvar "DIMTOFL" Dimtofl)
  (setvar "DIMTOH" Dimtoh)
  (princ)
);defun c:DD
;-------------------------------------------------------------------------------
; c:DR - Dim Radius
;-------------------------------------------------------------------------------
(defun c:DR (/ Dimfit Dimtad Dimtih Dimtix Dimtofl Dimtoh)
  (princ "\nDIM Radius")
  (command "LAYER" "M" "DimText" "C" "2" "" "");<--Change to your Dim layer info
  (setq Dimfit (getvar "DIMFIT")
        Dimtad (getvar "DIMTAD")
        Dimtih (getvar "DIMTIH")
        Dimtix (getvar "DIMTIX")
        Dimtofl (getvar "DIMTOFL")
        Dimtoh (getvar "DIMTOH")
  );setq
  (setvar "DIMFIT" 3)       ;Fit text and arrows, replaced with DIMATFIT
  (setvar "DIMTAD" 0);Off   ;Place text above the dimension line
  (setvar "DIMTIH" 1);On    ;Text inside extensions is horizontal
  (setvar "DIMTIX" 0);Off   ;Place text inside extensions
  (setvar "DIMTOFL" 0);Off  ;Force line inside extension lines
  (setvar "DIMTOH" 1);On    ;Text outside horizontal
  (command "DIMRADIUS")
  (setvar "DIMFIT" Dimfit)
  (setvar "DIMTAD" Dimtad)
  (setvar "DIMTIH" Dimtih)
  (setvar "DIMTIX" Dimtix)
  (setvar "DIMTOFL" Dimtofl)
  (setvar "DIMTOH" Dimtoh)
  (princ)
);defun c:DR
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
; DimStyles_Support - Checks to see if supporting functions are loaded
;-------------------------------------------------------------------------------
(defun DimStyles_Support ()
  (if (or (not GetOK)(not EditBox)(not Set_Value)(not ArchReal))
    (progn
      (if (or (not GetOK)(not EditBox))
        (if (findfile "GetIcon.lsp")
          (load "GetIcon.lsp")
          (if (findfile "Blk_Lib.lsp")
            (load "Blk_Lib.lsp")
          );if
        );if
      );if
      (if (or (not Set_Value)(not ArchReal))
        (if (findfile "Dcl_Tiles.lsp")
          (load "Dcl_Tiles.lsp")
        );if
      );if
      (if (or (not GetOK)(not EditBox)(not Set_Value)(not ArchReal))
        (progn
          (alert (strcat "DimStyles requires the functions inside of GetIcon.lsp"
            "\nand Dcl_Tiles.lsp.  Download the latest versions from"
            "\nAutoLISP Exchange, (URL: http://web2.airmail.net/terrycad).")
          );alert
          (exit)
        );progn
      );if
    );progn
  );if
);defun DimStyles_Support
;-------------------------------------------------------------------------------
(princ);End of DimStyles.lsp