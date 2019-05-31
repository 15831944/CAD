;-------------------------------------------------------------------------------
; Program Name: MyDialogs.lsp [MyDialogs R3]
; Created By:   Terry Miller (Email: terrycadd@yahoo.com)
;               (URL: http://web2.airmail.net/terrycad)
; Date Created: 7-20-06
; Function:     Tutorial for Getting Started with Dcl Dialogs
;-------------------------------------------------------------------------------
; Revision History
; Rev  By     Date    Description
;-------------------------------------------------------------------------------
; 1    TM   7-20-06   Initial version
; 2    TM   5-20-07   Revised DclTextWidth to correctly include the characters
;                     from ascii 127 through ascii 255.
; 3   TM    7-20-09   Revised the variable *DclPathFilename$ in the ViewDcl
;                     function. If the AcadDoc.lsp file is not found the users
;                     may need to edit the filename as required.
;-------------------------------------------------------------------------------
; c:My - Shortcut to load MyDialogs.lsp and run MyDialogsMenu
;-------------------------------------------------------------------------------
(defun c:My ()
  (load "MyDialogs")
  (c:MyDialogsMenu)
  (princ)
);defun c:My
;-------------------------------------------------------------------------------
; c:MyFirst - You've got to start somewhere
; Syntax: MyFirst
;-------------------------------------------------------------------------------
(defun c:MyFirst (/ Dcl_Id%)
  (princ "\nMyFirst")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyFirst" Dcl_Id%)
  ; Dialog Actions
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ)
);defun c:MyFirst
;-------------------------------------------------------------------------------
; MyAlert1 - Alert dialog with one message line
; Arguments: 2
;   Title$ = Dialog Title
;   Message$ = Message line
; Syntax: (MyAlert1 " My Message" "I'm going to figure this out.")
;-------------------------------------------------------------------------------
(defun MyAlert1 (Title$ Message$ / Dcl_Id%)
  (princ "\nMyAlert1")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyAlert1" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" Title$)
  (set_tile "Text1" Message$)
  ; Dialog Actions
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ)
);defun MyAlert1
;-------------------------------------------------------------------------------
; MyAlert2 - Alert dialog with two message lines and a Help button
; Arguments: 3
;   Title$ = Dialog Title
;   Message1$ = Message line 1
;   Message2$ = Message line 2
; Syntax: (MyAlert2 " Attention AutoCAD" "Not only am I going to figure this out,"
;         "but I'm going to be good at it!")
;-------------------------------------------------------------------------------
(defun MyAlert2 (Title$ Message1$ Message2$ / Dcl_Id%)
  (princ "\nMyAlert2")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyAlert2" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" Title$)
  (set_tile "Text1" Message1$)
  (set_tile "Text2" Message2$)
  ; Dialog Actions
  (action_tile "Help" "(alert \"You don't need any help.\nYou're doing great!\")")
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ)
);defun MyAlert2
;-------------------------------------------------------------------------------
; c:MyBoldText - Two methods of displaying bold text
; Syntax: MyBoldText
;-------------------------------------------------------------------------------
(defun c:MyBoldText (/ Dcl_Id%)
  (princ "\nMyBoldText")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyBoldText" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Text1" "This is just text.")
  (set_tile "ImageText2" "This is image text.")
  ; Dialog Actions
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ)
);defun c:MyBoldText
;-------------------------------------------------------------------------------
; c:MyOkCancel - Customize Ok Cancel buttons and then princ the Return# you
; choose to associate with the buttons pressed.
; Syntax: MyOkCancel
;-------------------------------------------------------------------------------
(defun c:MyOkCancel (/ Dcl_Id% Return#)
  (princ "\nMyOkCancel")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyOkCancel" Dcl_Id%)
  ; Dialog Actions
  (action_tile "accept" "(done_dialog 1)");You can change the default Return#
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ "\n")(princ Return#);Optional
  (princ)
);defun c:MyOkCancel
;-------------------------------------------------------------------------------
; MyYesNo - Question dialog with one question line
; Arguments: 2
;   Title$ = Dialog Title
;   Question$ = Question line
; Syntax: (MyYesNo " My Yes No" "Do you like creating programs in AutoLISP?")
;-------------------------------------------------------------------------------
(defun MyYesNo (Title$ Question$ / Answer$ Dcl_Id% Return#)
  (princ "\nMyYesNo")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyYesNo" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" Title$)
  (set_tile "Text1" Question$)
  ; Dialog Actions
  (action_tile "Yes" "(done_dialog 1)")
  (action_tile "No" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 1)
    (setq Answer$ "Yes")
    (setq Answer$ "No")
  );if
  (princ "\n")(princ Answer$)(princ);Optional
  Answer$
);defun MyYesNo
;-------------------------------------------------------------------------------
; c:MyNext - Provides a way to goto the next dialog using the done_dialog Return#
; method. This will be covered again in the function c:MyBackNext, after we cover
; other tiles and how to save the dialog tiles information in a gobal variable
; list for later use.
; Syntax: MyNext
;-------------------------------------------------------------------------------
(defun c:MyNext (/ Dcl_Id% Return#)
  (princ "\nMyNext")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyNext" Dcl_Id%)
  ; Dialog Actions
  (action_tile "Next" "(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 1)
    (c:MyBack)
  );if
  (princ)
);defun c:MyNext
;-------------------------------------------------------------------------------
; c:MyBack - Provides a way to go back to a previous dialog using the done_dialog
; Return# method. This will be covered again in the function c:MyBackNext, after
; we cover other tiles and how to save the dialog tiles information in a gobal
; variable list for later use.
; Syntax: MyBack
;-------------------------------------------------------------------------------
(defun c:MyBack (/ Dcl_Id% Return#)
  (princ "\nMyBack")(princ)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyBack" Dcl_Id%)
  ; Dialog Actions
  (action_tile "Back" "(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 1)
    (c:MyNext)
  );if
  (princ)
);defun c:MyBack
;-------------------------------------------------------------------------------
; MyEditText - Dialog to edit text
; Arguments: 2
;   Title$ = Dialog Title
;   Edit1$ = Text to edit
; Syntax: (MyEditText " My Edit Text" "")
;-------------------------------------------------------------------------------
(defun MyEditText (Title$ Edit1$ / Dcl_Id% NewText$ Return#)
  (princ "\nMyEditText")(princ)
  ; Set Default Variables
  (setq NewText$ Edit1$)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyEditText" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" Title$)
  (set_tile "Prompt" "Text:")
  (set_tile "Edit1" Edit1$)
  ; Dialog Actions
  (action_tile "accept" "(setq NewText$ (get_tile \"Edit1\"))(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (setq NewText$ nil))
  NewText$
);defun MyEditText
;-------------------------------------------------------------------------------
; c:MyEditBoxes - Dialog to edit text, integers, and real numbers
; Syntax: MyEditBoxes
;-------------------------------------------------------------------------------
(defun c:MyEditBoxes (/ Dcl_Id% Edit1$ Edit2$ Edit3$ Return#)
  (princ "\nMyEditBoxes")(princ)
  ; Set Default Variables
  (if (not *MyEditBoxes@);Unique global variable name to store dialog info
    (setq *MyEditBoxes@ (list nil "" "" ""))
  );if
  (setq Edit1$ (nth 1 *MyEditBoxes@)
        Edit2$ (nth 2 *MyEditBoxes@)
        Edit3$ (nth 3 *MyEditBoxes@)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyEditBoxes" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Edit Boxes")
  (set_tile "Text1" "Enter First Name")
  (set_tile "Edit1" Edit1$)
  (set_tile "Text2" "Enter your Age")
  (set_tile "Edit2" Edit2$)
  (set_tile "Text3" "Enter a Real Number")
  (set_tile "Edit3" Edit3$)
  ; Dialog Actions
  (action_tile "Edit1" "(setq Edit1$ $value)")
  (action_tile "Edit2" "(check_editint \"Edit2$\")");*Included
  (action_tile "Edit3" "(check_editreal \"Edit3$\")");*Included
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyEditBoxes@ (list nil Edit1$ Edit2$ Edit3$))
  (princ)
);defun c:MyEditBoxes
;-------------------------------------------------------------------------------
; c:MyPopupLists - Dialog to select choices from popup lists
; Syntax: MyPopupLists
;-------------------------------------------------------------------------------
(defun c:MyPopupLists (/ Dcl_Id% List1@ List2@ Return# Value1$ Value2$)
  (princ "\nMyPopupLists")(princ)
  ; Set Default Variables
  (if (not *MyPopupLists@);Unique global variable name to store dialog info
    (setq *MyPopupLists@ (list nil "" ""))
  );if
  (setq Value1$ (nth 1 *MyPopupLists@)
        Value2$ (nth 2 *MyPopupLists@)
        List1@ (list "" "Red" "Orange" "Yellow" "Green" "Cyan" "Blue" "Magenta")
        List2@ (list "" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyPopupLists" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Popup Lists")
  (set_tile "Text1" "My Favorite Color")
  (set_tile_list "List1" List1@ Value1$);*Included
  (set_tile "Text2" "My Favorite Number")
  (set_tile_list "List2" List2@ Value2$);*Included
  ; Dialog Actions
  (action_tile "List1" "(set_list_value \"List1@\" \"Value1$\")");*Included
  (action_tile "List2" "(set_list_value \"List2@\" \"Value2$\")");*Included
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyPopupLists@ (list nil Value1$ Value2$))
  (princ)
);defun c:MyPopupLists
;-------------------------------------------------------------------------------
; c:MyOtherLists - Dialog to select or add other choices from popup lists,
; including text lists, integer lists, and real number lists.
; Syntax: MyOtherLists
;-------------------------------------------------------------------------------
(defun c:MyOtherLists (/ Dcl_Id% List1@ List2@ List3@ Return# Value1$ Value2$ Value3$)
  (princ "\nMyOtherLists")(princ)
  ; Set Default Variables
  (if (not *MyOtherLists@);Unique global variable name to store dialog info
    (setq *MyOtherLists@ (list nil "" "" ""))
  );if
  (setq Value1$ (nth 1 *MyOtherLists@)
        Value2$ (nth 2 *MyOtherLists@)
        Value3$ (nth 3 *MyOtherLists@);For list with Other add "" and "Other" to end
        List1@ (list "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "" "Other")
        List2@ (list "1950" "1960" "1970" "1980" "1990" "2000" "" "Other")
        List3@ (list "1.1" "2.2" "3.3" "4.4" "5.5" "6.6" "7.7" "8.8" "9.9" "" "Other")
  );setq
  (if (not (member Value1$ List1@));Add item if not a member of list
    (setq List1@ (insert_nth (- (length List1@) 2) Value1$ List1@))
  );if
  (if (not (member Value2$ List2@));Add item if not a member of list
    (setq List2@ (insert_nth (- (length List2@) 2) Value2$ List2@))
  );if
  (if (not (member Value3$ List3@));Add item if not a member of list
    (setq List3@ (insert_nth (- (length List3@) 2) Value3$ List3@))
  );if
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyOtherLists" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Other Lists")
  (set_tile "Text1" "My Favorite Day")
  (set_tile_list "List1" List1@ Value1$);*Included
  (set_tile "Text2" "My Favorite Decade")
  (set_tile_list "List2" List2@ Value2$);*Included
  (set_tile "Text3" "My Favorite Real Number")
  (set_tile_list "List3" List3@ Value3$);*Included
  ; Dialog Actions
  (action_tile "List1" "(set_other_list \"List1@\" \"Value1$\")");*Included
  (action_tile "List2" "(set_other_intlist \"List2@\" \"Value2$\")");*Included
  (action_tile "List3" "(set_other_reallist \"List3@\" \"Value3$\")");*Included
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyOtherLists@ (list nil Value1$ Value2$ Value3$))
  (princ)
);defun c:MyOtherLists
;-------------------------------------------------------------------------------
; c:MyMultiLists - Dialog for list_boxes with single and multi select examples
; Syntax: MyMultiLists
;-------------------------------------------------------------------------------
(defun c:MyMultiLists (/ Dcl_Id% List1@ List2@ Return# Value1$ Value2$)
  (princ "\nMyMultiLists")(princ)
  ; Set Default Variables
  (if (not *MyMultiLists@);Unique global variable name to store dialog info
    (setq *MyMultiLists@ (list nil "" ""))
  );if
  (setq Value1$ (nth 1 *MyMultiLists@)
        Value2$ (nth 2 *MyMultiLists@)
        List1@ (list "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")
        List2@ (list "January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyMultiLists" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Multi Lists")
  (set_tile_list "List1" List1@ Value1$);*Included
  (set_tile_list "List2" List2@ Value2$);*Included
  ; Dialog Actions
  (action_tile "List1" "(set_list_value \"List1@\" \"Value1$\")");*Included
  (action_tile "List2" "(set_multilist_value \"List2@\" \"Value2$\")");*Included
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyMultiLists@ (list nil Value1$ Value2$))
  (princ)
);defun c:MyMultiLists
;-------------------------------------------------------------------------------
; c:MyRadios - Dialog with radio_rows and radio_columns
; Syntax: MyRadios
;-------------------------------------------------------------------------------
(defun c:MyRadios (/ Dcl_Id% Radio1$ Radio2$ Return#)
  (princ "\nMyRadios")(princ)
  ; Set Default Variables
  (if (not *MyRadios@);Unique global variable name to store dialog info
    (setq *MyRadios@ (list nil "" ""))
  );if
  (setq Radio1$ (nth 1 *MyRadios@)
        Radio2$ (nth 2 *MyRadios@)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyRadios" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Radios")
  (set_tile "Radio1" Radio1$)
  (set_tile "Radio2" Radio2$)
  ; Dialog Actions
  (action_tile "Radio1" "(setq Radio1$ $value)")
  (action_tile "Radio2" "(setq Radio2$ $value)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyRadios@ (list nil Radio1$ Radio2$))
  (princ)
);defun c:MyRadios
;-------------------------------------------------------------------------------
; c:MyToggles - Dialog with toggles arranged in a row and a column
; Syntax: MyToggles
;-------------------------------------------------------------------------------
(defun c:MyToggles (/ Dcl_Id% Toggle1$ Toggle2$ Toggle3$ Toggle4$ Toggle5$ Return#)
  (princ "\nMyToggles")(princ)
  ; Set Default Variables
  (if (not *MyToggles@);Unique global variable name to store dialog info
    (setq *MyToggles@ (list nil "0" "0" "0" "0" "0"))
  );if
  (setq Toggle1$ (nth 1 *MyToggles@)
        Toggle2$ (nth 2 *MyToggles@)
        Toggle3$ (nth 3 *MyToggles@)
        Toggle4$ (nth 4 *MyToggles@)
        Toggle5$ (nth 5 *MyToggles@)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyToggles" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Toggles")
  (set_tile "Toggle1" Toggle1$)
  (set_tile "Toggle2" Toggle2$)
  (set_tile "Toggle3" Toggle3$)
  (set_tile "Toggle4" Toggle4$)
  (set_tile "Toggle5" Toggle5$)
  ; Dialog Actions
  (action_tile "Toggle1" "(setq Toggle1$ $value)")
  (action_tile "Toggle2" "(setq Toggle2$ $value)")
  (action_tile "Toggle3" "(setq Toggle3$ $value)")
  (action_tile "Toggle4" "(setq Toggle4$ $value)")
  (action_tile "Toggle5" "(setq Toggle5$ $value)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyToggles@ (list nil Toggle1$ Toggle2$ Toggle3$ Toggle4$ Toggle5$))
  (princ)
);defun c:MyToggles
;-------------------------------------------------------------------------------
; c:MyBackNext - This function demonstrates the method for going back or to the
; next dialog in a series, utilizing the global dialog variable lists to save
; the information. This function starts with the first dialog MyEdit_Lists,
; which cycles through MyList_Radios and MyEdit_Toggles.
; Syntax: MyBackNext
;-------------------------------------------------------------------------------
(defun c:MyBackNext (/ Text$)
  (princ "\nMyBackNext")(princ)
  ;=============================================================================
  ; Get data from other Global dialog lists that apply for the demo.
  ; Note: This section between the double lines is not required.
  (if (not *MyEdit_Lists@)
    (progn
      (setq *MyEdit_Lists@ (list nil "" ""))
      (if *MyEditBoxes@
        (setq *MyEdit_Lists@ (change_nth 1 (nth 1 *MyEditBoxes@) *MyEdit_Lists@));*Included
      );if
      (if *MyPopupLists@
        (setq *MyEdit_Lists@ (change_nth 2 (nth 1 *MyPopupLists@) *MyEdit_Lists@));*Included
      );if
    );progn
  );if
  (if (not *MyList_Radios@)
    (progn
      (setq *MyList_Radios@ (list nil "" ""))
      (if *MyPopupLists@
        (setq *MyList_Radios@ (change_nth 1 (nth 2 *MyPopupLists@) *MyList_Radios@));*Included
      );if
      (if *MyRadios@
        (setq *MyList_Radios@ (change_nth 2 (nth 1 *MyRadios@) *MyList_Radios@));*Included
      );if
    );progn
  );if
  ;=============================================================================
  ; Start with first dialog MyEdit_Lists
  (MyEdit_Lists)
  (setq Text$ "\nYour favorite software is ")
  (cond
    ((and (= (nth 2 *MyEdit_Toggles@) "1")(= (nth 3 *MyEdit_Toggles@) "1"))
      (setq Text$ (strcat Text$ "AutoCAD and Excel."))
    );case
    ((= (nth 2 *MyEdit_Toggles@) "1")
      (setq Text$ (strcat Text$ "AutoCAD."))
    );case
    ((= (nth 3 *MyEdit_Toggles@) "1")
      (setq Text$ (strcat Text$ "Excel."))
    );case
    (t (setq Text$ ""))
  );cond
  (alert (strcat (nth 1 *MyEdit_Lists@) " " (nth 1 *MyEdit_Toggles@);Your name
    "\nYour favorite color is " (nth 2 *MyEdit_Lists@) "."
    "\nYour favorite number is " (nth 1 *MyList_Radios@) "."
    "\nYour favorite paper size is " (nth 2 *MyList_Radios@) "-Size."
    Text$)
  );alert
);defun c:MyBackNext
;-------------------------------------------------------------------------------
; MyEdit_Lists - Dialog edit and list examples for c:MyBackNext
; Syntax: (MyEdit_Lists)
;-------------------------------------------------------------------------------
(defun MyEdit_Lists (/ Dcl_Id% Edit1$ List2@ Return# Value2$ Verify_Info:)
  (princ "\nMyEdit_Lists")(princ)
  ; Verify_Info: ---------------------------------------------------------------
  (defun Verify_Info: (/ Passed)
    (setq Passed t)
    (foreach Item *MyEdit_Lists@
      (if (= Item "") (setq Passed nil))
    );foreach
    (if (not Passed)
      (progn
        (alert "All information is required to be completed!")
        (MyEdit_Lists)
      );progn
    );if
  );defun Verify_Info:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables
  (if (not *MyEdit_Lists@);Unique global variable name to store dialog info
    (setq *MyEdit_Lists@ (list nil "" ""))
  );if
  (setq Edit1$ (nth 1 *MyEdit_Lists@)
        Value2$ (nth 2 *MyEdit_Lists@)
        List2@ (list "" "Red" "Orange" "Yellow" "Green" "Cyan" "Blue" "Magenta")
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyEdit_Lists" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Edit & List Tiles")
  (set_tile "Text1" "Enter First Name")
  (set_tile "Edit1" Edit1$)
  (set_tile "Text2" "My Favorite Color")
  (set_tile_list "List2" List2@ Value2$);*Included
  ; Dialog Actions
  (action_tile "Edit1" "(setq Edit1$ $value)")
  (action_tile "List2" "(set_list_value \"List2@\" \"Value2$\")");*Included
  (action_tile "Next" "(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (exit))
  (setq *MyEdit_Lists@ (list Return# Edit1$ Value2$))
  (if (= Return# 1) (Verify_Info:));Next
  (if (= Return# 1) (MyList_Radios));Next
  (princ)
);defun MyEdit_Lists
;-------------------------------------------------------------------------------
; MyList_Radios - Dialog list and radio examples for c:MyBackNext
; Syntax: (MyList_Radios)
;-------------------------------------------------------------------------------
(defun MyList_Radios (/ Dcl_Id% List1@ Return# Value1$ Radio2$ Verify_Info:)
  (princ "\nMyList_Radios")(princ)
  ; Verify_Info: ---------------------------------------------------------------
  (defun Verify_Info: (/ Passed)
    (setq Passed t)
    (foreach Item *MyList_Radios@
      (if (= Item "") (setq Passed nil))
    );foreach
    (if (not Passed)
      (progn
        (alert "All information is required to be completed!")
        (MyList_Radios)
      );progn
    );if
  );defun Verify_Info:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables
  (if (not *MyList_Radios@);Unique global variable name to store dialog info
    (setq *MyList_Radios@ (list nil "" ""))
  );if
  (setq Value1$ (nth 1 *MyList_Radios@)
        Radio2$ (nth 2 *MyList_Radios@)
        List1@ (list "" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyList_Radios" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My List & Radio Tiles")
  (set_tile "Text1" "My Favorite Number")
  (set_tile_list "List1" List1@ Value1$);*Included
  (set_tile "Radio2" Radio2$)
  ; Dialog Actions
  (action_tile "List1" "(set_list_value \"List1@\" \"Value1$\")");*Included
  (action_tile "Radio2" "(setq Radio2$ $value)")
  (action_tile "Back" "(done_dialog 2)")
  (action_tile "Next" "(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (exit))
  (setq *MyList_Radios@ (list Return# Value1$ Radio2$))
  (if (= Return# 1) (Verify_Info:));Next
  (if (= Return# 1) (MyEdit_Toggles));Next
  (if (= Return# 2) (MyEdit_Lists));Back
  (princ)
);defun MyList_Radios
;-------------------------------------------------------------------------------
; MyEdit_Toggles - Dialog edit and toggle examples for c:MyBackNext
; Syntax: (MyEdit_Toggles)
;-------------------------------------------------------------------------------
(defun MyEdit_Toggles (/ Dcl_Id% Edit1$ Return# Toggle2$ Toggle3$ Verify_Info:)
  (princ "\nMyEdit_Toggles")(princ)
  ; Verify_Info: ---------------------------------------------------------------
  (defun Verify_Info: (/ Passed)
    (setq Passed t)
    (foreach Item *MyEdit_Toggles@
      (if (= Item "") (setq Passed nil))
    );foreach
    (if (not Passed)
      (progn
        (alert "All information is required to be completed!")
        (MyEdit_Toggles)
      );progn
    );if
  );defun Verify_Info:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables
  (if (not *MyEdit_Toggles@);Unique global variable name to store dialog info
    (setq *MyEdit_Toggles@ (list nil "" "0" "0"))
  );if
  (setq Edit1$ (nth 1 *MyEdit_Toggles@)
        Toggle2$ (nth 2 *MyEdit_Toggles@)
        Toggle3$ (nth 3 *MyEdit_Toggles@)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyEdit_Toggles" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Edit & Toggle Tiles")
  (set_tile "Text1" "Enter Last Name")
  (set_tile "Edit1" Edit1$)
  (set_tile "Toggle2" Toggle2$)
  (set_tile "Toggle3" Toggle3$)
  ; Dialog Actions
  (action_tile "Edit1" "(setq Edit1$ $value)")
  (action_tile "Toggle2" "(setq Toggle2$ $value)")
  (action_tile "Toggle3" "(setq Toggle3$ $value)")
  (action_tile "Back" "(done_dialog 2)")
  (action_tile "accept" "(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (exit))
  (setq *MyEdit_Toggles@ (list Return# Edit1$ Toggle2$ Toggle3$))
  (if (= Return# 1) (Verify_Info:));OK
  (if (= Return# 2) (MyList_Radios));Back
  (princ)
);defun MyEdit_Toggles
;-------------------------------------------------------------------------------
; c:MyPickButton - Dialog example for hiding a dialog and picking an object and
; returning the information of the object selected.
; Syntax: MyPickButton
;-------------------------------------------------------------------------------
(defun c:MyPickButton (/ Dcl_Id% EntIns$ EntLayer$ EntList@ EntName^ EntPick@
  EntType$ EntXpt$ EntYpt$ Found Item Return# Text1$ Text2$ Text3$)
  (princ "\nMyPickButton")(princ)
  ; Set Default Variables
  (if (not *MyPickButton@);Unique global variable name to store dialog info
    (setq *MyPickButton@ (list nil "" "" ""))
  );if
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (setq Return# 2)
  (while (/= Return# 1)
    (new_dialog "MyPickButton" Dcl_Id%)
    ; Set Variables and Dialog Initial Settings
    (setq Text1$ (nth 1 *MyPickButton@)
          Text2$ (nth 2 *MyPickButton@)
          Text3$ (nth 3 *MyPickButton@)
    );setq
    (set_tile "Title" " My Pick Button")
    (select_pick);*Included
    (set_tile "Prompt" "Select an object")
    (set_tile "Text1" Text1$)
    (set_tile "Text2" Text2$)
    (set_tile "Text3" Text3$)
    ; Dialog Actions
    (action_tile "select_pick" "(done_dialog 2)")
    (action_tile "accept" "(done_dialog 1)")
    (setq Return# (start_dialog))
    (if (= Return# 2)
      (if (setq EntPick@ (entsel))
        (progn
          (setq EntName^ (car EntPick@)
                EntList@ (entget EntName^)
                EntType$ (cdr (assoc 0 EntList@))
                EntLayer$ (cdr (assoc 8 EntList@))
                EntXpt$ (rtos (nth 1 (assoc 10 EntList@)) 2 3)
                EntYpt$ (rtos (nth 2 (assoc 10 EntList@)) 2 3)
                EntIns$ (strcat EntXpt$ "," EntYpt$)
                Found t
          );setq
          (setq *MyPickButton@ (list Found
                   (strcat "Object Type: " EntType$)
                   (strcat "Object Layer: " EntLayer$)
                   (strcat "Insertion point: " EntIns$))
          );setq
          (foreach Item EntList@
            (princ "\n")(princ Item)
          );foreach
          (princ "\n")
        );progn
        (progn
          (setq Found (nth 0 *MyPickButton@))
          (setq *MyPickButton@ (list Found "" "\t    No object selected" ""))
          (setq EntList@ nil)
        );progn
      );if
    );if
  );while
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (nth 0 *MyPickButton@)
    (textscr)
  );if
  (setq *MyPickButton@ (list nil "" "" ""))
  (princ)
);defun c:MyPickButton
;-------------------------------------------------------------------------------
; c:MySlideImages - Dialog of four slides for example. For the demo create four
; slides and modify the Slides@ list variable. Edit the Folder$ variable to the
; path and folder where the new slides are stored. i.e. "C:\\Slds\\". This is
; the basics for creating your own block slide library.
; Syntax: MySlideImages
;-------------------------------------------------------------------------------
(defun c:MySlideImages (/ Dcl_Id% Folder$ Slides@ Slide1$ Slide2$ Slide3$ Slide4$
  Return$ X# Y#)
  (princ "\nMySlideImages")(princ)
  ; Set Default Variables
  (setq Slides@ (list nil "Bolt_Top" "Nut_Washer" "Nut_Top" "Nut")
        Slide1$ (nth 1 Slides@)
        Slide2$ (nth 2 Slides@)
        Slide3$ (nth 3 Slides@)
        Slide4$ (nth 4 Slides@)
        Folder$ ""
        Return$ ""
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MySlideImages" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Slide Images")
  (set_tile "Text1" Slide1$)
  (set_tile "Text2" Slide2$)
  (set_tile "Text3" Slide3$)
  (set_tile "Text4" Slide4$)
  ; Adjust X# and Y# per image_buttom outline to fit slide_image
  (start_image "Slide1")(setq X# (- (dimx_tile "Slide1") 2))
  (setq Y# (- (dimy_tile "Slide1") 2))(end_image)
  (start_image "Slide1")(slide_image 1 1 X# Y# (strcat Folder$ Slide1$))(end_image)
  (start_image "Slide2")(slide_image 1 1 X# Y# (strcat Folder$ Slide2$))(end_image)
  (start_image "Slide3")(slide_image 1 1 X# Y# (strcat Folder$ Slide3$))(end_image)
  (start_image "Slide4")(slide_image 1 1 X# Y# (strcat Folder$ Slide4$))(end_image)
  ; Dialog Actions
  (action_tile "Slide1" "(setq Return$ Slide1$)")
  (action_tile "Slide2" "(setq Return$ Slide2$)")
  (action_tile "Slide3" "(setq Return$ Slide3$)")
  (action_tile "Slide4" "(setq Return$ Slide4$)")
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ (strcat "\n" Return$))
  (princ)
);defun c:MySlideImages
;-------------------------------------------------------------------------------
; c:MyImageButton
; These images were created using GetVectors.lsp on AutoLISP Exchange
; (URL: http://web2.airmail.net/terrycad)
;-------------------------------------------------------------------------------
(defun c:MyImageButton (/ Dcl_Id% Show_Image:)
  (princ "\nMyImageButton")(princ)
  ; Show_Image: ----------------------------------------------------------------
  (defun Show_Image: (/ Ang CenPt Dist~ PickPt X# Y#)
    (start_image "Image1")(setq X# (dimx_tile "Image1"))
    (setq Y# (dimy_tile "Image1"))(end_image)
    (setq CenPt (list (/ X# 2)(/ Y# 2))
          PickPt (list $x $y)
          Ang (angle CenPt PickPt)
          Dist~ (distance CenPt PickPt)
    );setq
    (cond
      ((< Dist~ (/ Y# 4))(Front_View));*Included
      ((< Ang (* pi 0.25))(Right_View));*Included
      ((< Ang (* pi 0.75))(Bottom_View));*Included
      ((< Ang (* pi 1.25))(Left_View));*Included
      ((< Ang (* pi 1.75))(Top_View));*Included
      (t (Right_View))
    );cond
  );defun Show_Image:
  ;-----------------------------------------------------------------------------
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyImageButton" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Image Button")
  (set_tile "Text1" "Pick arrows to change views.")
  (Front_View);*Included
  ; Dialog Actions
  (action_tile "Image1" "(Show_Image:)")
  (start_dialog)
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (princ)
);defun c:MyImageButton
;-------------------------------------------------------------------------------
; c:MySliders
; Syntax: MySliders
;-------------------------------------------------------------------------------
(defun c:MySliders (/ Cnt# Color# Colors@ Dcl_Id% FillinColor: List@ Return#
  SliderH$ SliderV$)
  (princ "\nMySliders")(princ)
  ; FillinColor: ---------------------------------------------------------------
  (defun FillinColor: (/ X# Y#)
    (setq Color# (nth (1- (atoi SliderV$)) (nth (1- (atoi SliderH$)) Colors@)))
    (start_image "ColorImage")
    ; The drawing area is 1 less than dimx_tile and dimy_tile returns
    (setq X# (1- (dimx_tile "ColorImage")))
    (setq Y# (1- (dimy_tile "ColorImage")))
    ; Outline image
    (vector_image 0 0 X# 0 255);Top white
    (vector_image 0 0 0 Y# 255);Left white
    (vector_image X# 0 X# Y# 250);Right black
    (vector_image 0 Y# X# Y# 250);Bottom Black
    ; Fillin only the inside
    (fill_image 1 1 (1- X#) (1- Y#) Color#)
    (end_image)
    (set_tile "Text1" (strcat "Horizontal = " SliderH$))
    (set_tile "Text2" (strcat "Vertical = " SliderV$))
    (set_tile "Text3" (strcat "Color = " (itoa Color#)))
  );defun FillinColor:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables
  (if (not *MySliders@);Unique global variable name to store dialog info
    (setq *MySliders@ (list nil "1" "1" 15))
  );if
  (setq Colors@ (list (list 15 13 11 10 12 14)))
  (setq Cnt# 1)
  (repeat 5
    (setq List@ nil)
    (foreach Item (nth (1- Cnt#) Colors@)
      (setq List@ (append List@ (list (+ Item 40))))
    );foreach
    (setq Colors@ (append Colors@ (list List@)))
    (setq Cnt# (1+ Cnt#))
  );repeat
  (setq SliderH$ (nth 1 *MySliders@)
        SliderV$ (nth 2 *MySliders@)
        Color# (nth (1- (atoi SliderV$)) (nth (1- (atoi SliderH$)) Colors@))
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MySliders" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Sliders")
  (FillinColor:)
  (set_tile "SliderH" SliderH$)
  (set_tile "SliderV" SliderV$)
  (set_tile "Text1" (strcat "Horizontal = " SliderH$))
  (set_tile "Text2" (strcat "Vertical = " SliderV$))
  (set_tile "Text3" (strcat "Color = " (itoa Color#)))
  ; Dialog Actions
  (action_tile "SliderH" "(setq SliderH$ $value)(FillinColor:)")
  (action_tile "SliderV" "(setq SliderV$ $value)(FillinColor:)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MySliders@ (list nil SliderH$ SliderV$ Color#))
  (princ)
);defun c:MySliders
;-------------------------------------------------------------------------------
; Start of MyDialogs Support Utility Functions
;-------------------------------------------------------------------------------
; c:MyDialogsMenu - Menu designed for the tutorial to demo other dialogs
;-------------------------------------------------------------------------------
(defun c:MyDialogsMenu (/ AssocList1@ AssocList2@ AssocList3@ Dcl_Id% Item$ List1@
  List2@ List3@ Return# SelectFromList:)
  (princ "\nMyDialogsMenu")(princ)
  ; SelectList: ----------------------------------------------------------------
  (defun SelectFromList: ()
    (set_tile_list "List1" List1@ "");*Included
    (set_tile_list "List2" List2@ "");*Included
    (set_tile_list "List3" List3@ "");*Included
    (cond
      ((= $key "List1")
        (setq Item$ (nth (atoi $value) List1@))
        (set_tile_list "List1" List1@ Item$);*Included
      );case
      ((= $key "List2")
        (setq Item$ (nth (atoi $value) List2@))
        (set_tile_list "List2" List2@ Item$);*Included
      );case
      ((= $key "List3")
        (setq Item$ (nth (atoi $value) List3@))
        (set_tile_list "List3" List3@ Item$);*Included
      );case
    );cond
  );defun SelectFromList:
  ; Set Default Variables
  (if (not *MyMenu@);Unique global variable name to store dialog info
    (setq *MyMenu@ (list nil "My First"))
  );if
  (setq Item$ (nth 1 *MyMenu@))
  (setq AssocList1@ (list
    (list "My First" "(c:MyFirst)")
    (list "My Alert 1" "(MyAlert1 \" My Message\" \"I'm going to figure this out.\")")
    (list "My Alert 2" "(MyAlert2 \" Attention AutoCAD\" \"Not only am I going to figure this out,\" \"but I'm going to be good at it!\")")
    (list "My Bold Text" "(c:MyBoldText)")
    (list "My Ok Cancel" "(c:MyOkCancel)")
    (list "My Yes No" "(MyYesNo \" My Yes No\" \"Do you like creating programs in AutoLISP?\")")
    (list "My Next / My Back" "(c:MyNext)"))
  );setq
  (setq AssocList2@ (list
    (list "My Edit Text" "(MyEditText \" My Edit Text\" \"\")")
    (list "My Edit Boxes" "(c:MyEditBoxes)")
    (list "My Popup Lists" "(c:MyPopupLists)")
    (list "My Other Lists" "(c:MyOtherLists)")
    (list "My Multi Lists" "(c:MyMultiLists)")
    (list "My Radios" "(c:MyRadios)")
    (list "My Toggles" "(c:MyToggles)"))
  );setq
  (setq AssocList3@ (list
    (list "My Back Next" "(c:MyBackNext)")
    (list "My Pick Button" "(c:MyPickButton)")
    (list "My Slide Images" "(c:MySlideImages)")
    (list "My Image Button" "(c:MyImageButton)")
    (list "My Sliders" "(c:MySliders)")
    (list "Dcl Calcs" "(c:DclC)")
    (list "View Dcl" "(c:ViewDcl)"))
  );setq
  (foreach Item AssocList1@
    (setq List1@ (append List1@ (list (car Item))))
  );foreach
  (foreach Item AssocList2@
    (setq List2@ (append List2@ (list (car Item))))
  );foreach
  (foreach Item AssocList3@
    (setq List3@ (append List3@ (list (car Item))))
  );foreach
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "MyDialogsMenu" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Dialogs Menu")
  (set_tile_list "List1" List1@ "");*Included
  (set_tile_list "List2" List2@ "");*Included
  (set_tile_list "List3" List3@ "");*Included
  (cond
    ((member Item$ List1@)
      (set_tile_list "List1" List1@ Item$);*Included
    );case
    ((member Item$ List2@)
      (set_tile_list "List2" List2@ Item$);*Included
    );case
    ((member Item$ List3@)
      (set_tile_list "List3" List3@ Item$);*Included
    );case
  );cond
  ; Dialog Actions
  (action_tile "List1" "(SelectFromList:)")
  (action_tile "List2" "(SelectFromList:)")
  (action_tile "List3" "(SelectFromList:)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (exit))
  (setq *MyMenu@ (list nil Item$))
  (cond
    ((member Item$ List1@)
      (eval (read (cadr (assoc Item$ AssocList1@))))
    );case
    ((member Item$ List2@)
      (eval (read (cadr (assoc Item$ AssocList2@))))
    );case
    ((member Item$ List3@)
      (eval (read (cadr (assoc Item$ AssocList3@))))
    );case
  );cond
  (c:MyDialogsMenu)
  (princ)
);defun c:MyDialogsMenu
;-------------------------------------------------------------------------------
; c:DclCalcs - Dcl Calculations
;-------------------------------------------------------------------------------
(defun c:DclC ()(load "MyDialogs")(c:DclCalcs)(princ));Shortcut
(defun c:DclCalcs (/ DclCalcs_Info: Dcl_Id% Edit1$ Edit2$ Edit3$ Edit4$ Edit5$
  Edit6$ Edit7$ Edit8$ Edit10$ Edit11$ Edit12$ Edit14$ Edit15$ Edit16$ Edit17$
  Image_Tiles: Lines@ ListBox_Tiles: Phrases@ Skipped@ Text_Tiles: Toggle9$
  Toggle13$ Widths@)
  (princ "\nDclCalcs")(princ)
  ;-----------------------------------------------------------------------------
  ; Image_Tiles: - Calculates values for Images and Tiles
  ; Arguments: 1
  ;   SentVar$ = String of the variable name
  ; Syntax: (Image_Tiles: "Variable")
  ;-----------------------------------------------------------------------------
  (defun Image_Tiles: (SentVar$)
    (cond
      ((= SentVar$ "Edit1$")(check_editint "Edit1$");X Pixels
        (if (< (atoi Edit1$) 1) (setq Edit1$ "1"))
        (setq Edit2$ (PixelsToWidth Edit1$));*Included
        (set_tile "Edit2" Edit2$)(set_tile "Edit1" Edit1$)
      );case
      ((= SentVar$ "Edit2$")(check_editreal "Edit2$");Width
        (if (< (atof Edit2$) 0.09) (setq Edit2$ "0.09"))
        (setq Edit1$ (WidthToPixels Edit2$));*Included
        (setq Edit2$ (PixelsToWidth Edit1$));*Included
        (set_tile "Edit1" Edit1$)(set_tile "Edit2" Edit2$)
      );case
      ((= SentVar$ "Edit3$")(check_editint "Edit3$");Y Pixels
        (if (< (atoi Edit3$) 1) (setq Edit3$ "1"))
        (setq Edit4$ (PixelsToHeight Edit3$));*Included
        (set_tile "Edit4" Edit4$)(set_tile "Edit3" Edit3$)
      );case
      ((= SentVar$ "Edit4$")(check_editreal "Edit4$");Height
        (if (< (atof Edit4$) 0.05) (setq Edit4$ "0.05"))
        (setq Edit3$ (HeightToPixels Edit4$));*Included
        (setq Edit4$ (PixelsToHeight Edit3$));*Included
        (set_tile "Edit3" Edit3$)(set_tile "Edit4" Edit4$)
      );case
    );cond
  );defun Image_Tiles:
  ;-----------------------------------------------------------------------------
  ; Text_Tiles: - Calculates values for Text and Tile Widths
  ; Arguments: 1
  ;   SentVar$ = String of the variable name
  ; Syntax: (Text_Tiles: "Variable")
  ;-----------------------------------------------------------------------------
  (defun Text_Tiles: (SentVar$ / Pixels# Num#)
    (if (= SentVar$ "Edit5$");Text Label
      (progn
        (setq Edit5$ $value
              Pixels# (nth 0 (DclTextWidth Edit5$));*Included
              Edit6$ (itoa Pixels#)
              Edit7$ (PixelsToWidth Edit6$);*Included
              Edit10$ (PixelsToWidth (itoa (+ Pixels# 8)));*Included
              Edit14$ (PixelsToWidth (itoa (+ Pixels# 8)));*Included
        );setq
        (set_tile "Edit6" Edit6$)
        (set_tile "Edit7" Edit7$)
        (set_tile "Edit10" Edit10$)
        (set_tile "Edit14" Edit14$)
      );progn
      (progn
        (cond
          ((= SentVar$ "Edit8$") (setq Edit8$ $value));Popup List
          ((= SentVar$ "Edit12$") (setq Edit12$ $value));Edit Box
          ((= SentVar$ "Toggle9$") (setq Toggle9$ $value));Popup List Toggle
          ((= SentVar$ "Toggle13$") (setq Toggle13$ $value));Edit Box Toggle
        );cond
        (cond
          ((and (= Toggle9$ "1")(= Toggle13$ "0"));Popup List only
            (setq Pixels# (nth 0 (DclTextWidth Edit8$)));*Included
            (if (< Pixels# 32) (setq Pixels# 32))
            (setq Edit11$ (PixelsToWidth (itoa (+ Pixels# 25))));*Included
          );case
          ((and (= Toggle9$ "0")(= Toggle13$ "1"));Edit Box only
            (setq Num# (- (nth 0 (DclTextWidth Edit12$)) 6));*Included
            (if (< Num# 1) (setq Num# 1))
            (setq Edit15$ (PixelsToWidth (itoa Num#)));*Included
          );case
          ((and (= Toggle9$ "1")(= Toggle13$ "1"));Popup List w/ Edit Box
            (setq Pixels# (+ (nth 0 (DclTextWidth Edit8$)) 25));*Included
            (if (< Pixels# 56) (setq Pixels# 56))
            (setq Num# (- (nth 0 (DclTextWidth Edit12$)) 6));*Included
            (if (< Num# 44) (setq Num# 44))
            (if (< Pixels# (+ Num# 12))
              (setq Pixels# (+ Num# 12))
            );if
            (if (< Num# (- Pixels# 12))
              (setq Num# (- Pixels# 12))
            );if
            (setq Edit11$ (PixelsToWidth (itoa Pixels#)));*Included
            (setq Edit15$ (PixelsToWidth (itoa Num#)));*Included
          );case
        );cond
        (if (= Toggle9$ "1")
          (progn
            (set_tile "Edit8" Edit8$)
            (set_tile "Edit11" Edit11$)
            (mode_tile "Edit8" 0)
          );progn
          (progn
            (set_tile "Edit8" "")
            (set_tile "Edit11" "")
            (mode_tile "Edit8" 1)
          );progn
        );if
        (if (= Toggle13$ "1")
          (progn
            (set_tile "Edit12" Edit12$)
            (set_tile "Edit15" Edit15$)
            (mode_tile "Edit12" 0)
          );progn
          (progn
            (set_tile "Edit12" "")
            (set_tile "Edit15" "")
            (mode_tile "Edit12" 1)
          );progn
        );if
      );progn
    );if
  );defun Text_Tiles:
  ;-----------------------------------------------------------------------------
  ; ListBox_Tiles: - Calculates values for List Box Tiles
  ; Arguments: 1
  ;   SentVar$ = String of the variable name
  ; Syntax: (ListBox_Tiles: "Variable")
  ;-----------------------------------------------------------------------------
  (defun ListBox_Tiles: (SentVar$ / Temp$)
    (cond
      ((= SentVar$ "Edit16$");Lines
        (check_editint "Edit16$");*Included
        (cond
          ((< (atoi Edit16$) 1)(setq Edit16$ "1"))
          ((> (atoi Edit16$) 55)
            (alert (strcat Edit16$ " exceeds the maximum lines recommended\n"
              "for several Windows Screen resolutions."))
            (setq Edit16$ "55")
          );case
          ((member (atoi Edit16$) Skipped@)
            (alert (strcat Edit16$ " lines is skipped in dcl as the possible lines. "
              "The lines\nskipped are 5, 10, 15, 21, 26, 31, 37, 42, 47, and 53."))
            (setq Edit16$ (itoa (1+ (atoi Edit16$))))
          );case
        );cond
        (setq Edit17$ (rtos (FindInList (atoi Edit16$) Lines@ Widths@) 2 2));*Included
        (set_tile "Edit17" Edit17$)(set_tile "Edit16" Edit16$)
      );case
      ((= SentVar$ "Edit17$");Height
        (check_editreal "Edit17$");*Included
        (cond
          ((< (atof Edit17$) 1.35)(setq Edit17$ "1.35"))
          ((> (atof Edit17$) 55.5)
            (alert (strcat Edit17$ " exceeds the maximum height recommended\n"
              "for several Windows Screen resolutions."))
            (setq Edit17$ "55.5")
          );case
        );cond
        (foreach Item (reverse Widths@)
          (if (<= (atof Edit17$) Item)
            (setq Temp$ (rtos Item 2 2))
          );if
        );foreach
        (setq Edit17$ Temp$)
        (setq Edit16$ (itoa (FindInList (atof Edit17$) Widths@ Lines@)));*Included
        (set_tile "Edit16" Edit16$)(set_tile "Edit17" Edit17$)
      );case
    );cond
  );defun ListBox_Tiles:
  ;-----------------------------------------------------------------------------
  ; DclCalcs_Info: - Displays Dcl Calcs Information screen
  ;-----------------------------------------------------------------------------
  (defun DclCalcs_Info: (/ Dcl_Id% Info$)
    (setq Info$ (strcat
    "     Dcl Calcs is a utility program for calculating the widths and heights of "
    "Dialog tiles.\n\n"
    "     In the Images and Tiles section, the values of the X Pixels and Y Pixels "
    "correspond to the return of the dimx_tile and dimy_tile variables in image "
    "tiles. The algorithm to determine the values in this section may also be used "
    "to calculate the width and height of other type of tiles as well. The change "
    "in other tiles may not relate to Pixels, but as incremental changes instead.\n\n"
    "     In the Text and Tile Widths section, the widths are calculated based upon "
    "the longest phrase needed. This section is very useful for aligning a column "
    "of text with popup_list and edit_box tiles. This method ignores the hard coded "
    "dcl labels for popup_list and edit_box tiles, and provides a dynamic alternative "
    "of being able to change the text labels within AutoLISP.\n\n"
    "     The toggles for Popup List and Edit Box determine the combination of choices "
    "that will be used in a column. If only one toggle is selected, it calculates "
    "the needed width per the longest phrase needed. If both toggles are selected, "
    "it recalculates the widths to align both types in a column. Also notice that "
    "the Text Column width for the Edit Box is equivalent to one pixel greater than "
    "the Text Column width for the Popup List.\n\n"
    "     In the List Box Tiles section, enter the desired number of lines to display "
    "in a list_box tile and the corresponding height is displayed. If the number "
    "of lines is one of the ones that are skipped in dcl, it will display a message "
    "with all of the skipped lines within a reasonable range.\n\n"
    "     The Calculator image button runs the Windows calculator, which is handy for "
    "doing some calculations while still in the dialog."))
    (if (not Phrases@)
      (setq Phrases@ (PhraseList Info$ 36.76));*Included
    );if
    (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
    (new_dialog "DclCalcs_Info" Dcl_Id%)
    (set_tile "Title" " Dcl Calcs Information")
    (set_tile_list "List1" Phrases@ "");*Included
    (start_dialog)
    (unload_dialog Dcl_Id%)
    (princ)
  );defun DclCalcs_Info:
  ;-----------------------------------------------------------------------------
  ; Set Default Variables
  (if (not *DclCalcs@);Unique global variable name to store dialog info
    (setq *DclCalcs@ (list nil "1" "0.09" "1" "0.05"
      "Longest phrase needed" "112" "18.59"
      "Longest phrase needed" "1" "19.92" "22.59"
      "Longest phrase needed" "1" "19.92" "20.59"
      "1" "1.35")
    );setq
  );if
  (setq Edit1$ (nth 1 *DclCalcs@)
        Edit2$ (nth 2 *DclCalcs@)
        Edit3$ (nth 3 *DclCalcs@)
        Edit4$ (nth 4 *DclCalcs@)
        Edit5$ (nth 5 *DclCalcs@)
        Edit6$ (nth 6 *DclCalcs@)
        Edit7$ (nth 7 *DclCalcs@)
        Edit8$ (nth 8 *DclCalcs@)
        Toggle9$ (nth 9 *DclCalcs@)
        Edit10$ (nth 10 *DclCalcs@)
        Edit11$ (nth 11 *DclCalcs@)
        Edit12$ (nth 12 *DclCalcs@)
        Toggle13$ (nth 13 *DclCalcs@)
        Edit14$ (nth 14 *DclCalcs@)
        Edit15$ (nth 15 *DclCalcs@)
        Edit16$ (nth 16 *DclCalcs@)
        Edit17$ (nth 17 *DclCalcs@)
        List0@ (list "0.0" "0.00")
  );setq
  (setq Lines@ (list 1 2 3 4 6 7 8 9 11 12 13 14 16 17 18 19 20 22 23 24 25 27 28
                29 30 32 33 34 35 36 38 39 40 41 43 44 45 46 48 49 50 51 52 54 55)
        Widths@ (list 1.35 2.58 3.81 5.04 6.27 7.5 8.74 9.97 11.2 12.43 13.66
                14.89 16.12 17.35 18.58 19.81 21.04 22.27 23.5 24.74 25.97 27.2
                28.43 29.66 30.89 32.12 33.35 34.58 35.81 37.04 38.27 39.5 40.74
                41.97 43.2 44.43 45.66 46.89 48.12 49.35 50.58 51.81 53.04 54.27 55.5)
        Skipped@ (list 5 10 15 21 26 31 37 42 47 53)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
  (new_dialog "DclCalcs" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " Dcl Calcs")
  (set_tile "Text1" "X Pixels")
  (set_tile "Text2" "Width")
  (set_tile "Text3" "Y Pixels")
  (set_tile "Text4" "Height")
  (set_tile "Text5" "Text Label")
  (set_tile "Text6" "X Pixels")
  (set_tile "Text7" "Text Width")
  (set_tile "Text8" "Popup List")
  (set_tile "Text10" "Text Column")
  (set_tile "Text11" "Popup List")
  (set_tile "Text12" "Edit Box")
  (set_tile "Text14" "Text Column")
  (set_tile "Text15" "Edit Box")
  (set_tile "Text16" "Lines")
  (set_tile "Text17" "Height")
  (set_tile "Edit1" Edit1$)
  (set_tile "Edit2" Edit2$)
  (set_tile "Edit3" Edit3$)
  (set_tile "Edit4" Edit4$)
  (set_tile "Edit5" Edit5$)
  (set_tile "Edit6" Edit6$)
  (set_tile "Edit7" Edit7$)
  (set_tile "Toggle9" Toggle9$)
  (set_tile "Edit10" Edit10$)
  (set_tile "Toggle13" Toggle13$)
  (set_tile "Edit14" Edit14$)
  (set_tile "Edit16" Edit16$)
  (set_tile "Edit17" Edit17$)
  (if (= Toggle9$ "1")
    (progn
      (set_tile "Edit8" Edit8$)
      (set_tile "Edit11" Edit11$)
      (mode_tile "Edit8" 0)
    );progn
    (progn
      (set_tile "Edit8" "")
      (set_tile "Edit11" "")
      (mode_tile "Edit8" 1)
    );progn
  );if
  (if (= Toggle13$ "1")
    (progn
      (set_tile "Edit12" Edit12$)
      (set_tile "Edit15" Edit15$)
      (mode_tile "Edit12" 0)
    );progn
    (progn
      (set_tile "Edit12" "")
      (set_tile "Edit15" "")
      (mode_tile "Edit12" 1)
    );progn
  );if
  (mode_tile "Edit6" 1)
  (mode_tile "Edit7" 1)
  (mode_tile "Edit10" 1)
  (mode_tile "Edit11" 1)
  (mode_tile "Edit14" 1)
  (mode_tile "Edit15" 1)
  (Calculator)
  ; Dialog Actions
  (action_tile "Edit1" "(Image_Tiles: \"Edit1$\")")
  (action_tile "Edit2" "(Image_Tiles: \"Edit2$\")")
  (action_tile "Edit3" "(Image_Tiles: \"Edit3$\")")
  (action_tile "Edit4" "(Image_Tiles: \"Edit4$\")")
  (action_tile "Edit5" "(Text_Tiles: \"Edit5$\")")
  (action_tile "Edit8" "(Text_Tiles: \"Edit8$\")")
  (action_tile "Toggle9" "(Text_Tiles: \"Toggle9$\")")
  (action_tile "Edit12" "(Text_Tiles: \"Edit12$\")")
  (action_tile "Toggle13" "(Text_Tiles: \"Toggle13$\")")
  (action_tile "Edit16" "(ListBox_Tiles: \"Edit16$\")")
  (action_tile "Edit17" "(ListBox_Tiles: \"Edit17$\")")
  (action_tile "Calculator" "(startapp \"Calc.exe\")")
  (action_tile "accept" "(done_dialog 1)")
  (action_tile "Info" "(DclCalcs_Info:)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *DclCalcs@ (list nil Edit1$ Edit2$ Edit3$ Edit4$ Edit5$ Edit6$ Edit7$ Edit8$
    Toggle9$ Edit10$ Edit11$ Edit12$ Toggle13$ Edit14$ Edit15$ Edit16$ Edit17$)
  );setq
  (princ)
);defun c:DclCalcs
;-------------------------------------------------------------------------------
; c:ViewDcl - Utility to View Dcl Dialogs
;-------------------------------------------------------------------------------
(defun c:ViewDcl (/ Cnt# Dcl_Id% DialogList@ DialogName$ FileName% Index$ Loop
  PathFilename$ Return# Text$ Title$)
  (princ "\nSelect Dialog File to View")(princ)
  (if (not *DclPathFilename$)
    (if (findfile "AcadDoc.lsp");Change to current filename
      (setq *DclPathFilename$ (vl-filename-directory (findfile "AcadDoc.lsp")))
      (setq *DclPathFilename$ "C:\\")
    );if
  );if
  (if (setq PathFilename$ (getfiled " Select Dialog File" *DclPathFilename$ "dcl" 20))
    (setq *DclPathFilename$ (vl-filename-directory PathFilename$))
    (exit)
  );if
  (setq Title$ (strcat " View " (vl-filename-base PathFilename$) ".dcl"))
  (setq FileName% (open PathFilename$ "r"))
  (princ "\nSelect Dialog to View ")(princ)
  (setq Cnt# 0 DialogList@ nil)
  (while (setq Text$ (read-line FileName%))
    (if (and (wcmatch Text$ "*:*" )(wcmatch Text$ "*dialog*" ))
      (progn
        (setq DialogName$ (nth 0 (WordList (NoSpaces Text$))))
        (if (/= (substr DialogName$ 1 2) "//")
          (setq DialogList@ (append DialogList@ (list DialogName$)))
        );if
      );progn
    );if
    (setq Cnt# (1+ Cnt#))
  );while
  (close FileName%)
  (setq Index$ "0" Loop t)
  (while Loop
    (setq Dcl_Id% (load_dialog "MyDialogs.dcl"))
    (new_dialog "ViewDcl" Dcl_Id%)
    (start_list "DialogList")(mapcar 'add_list DialogList@)(end_list)
    (set_tile "Title" Title$)
    (set_tile "DialogList" Index$)
    (action_tile "DialogList" "(setq Index$ $value)")
    (setq Return# (start_dialog))
    (unload_dialog Dcl_Id%)
    (cond
      ((= Return# 1)
        (progn
          (setq DialogName$ (nth (atoi Index$) DialogList@))
          (setq Dcl_Id% (load_dialog PathFilename$))
          (new_dialog DialogName$ Dcl_Id%)
          (start_dialog)
          (unload_dialog Dcl_Id%)
        );progn
      );case
      ((= Return# 0)(setq Loop nil))
    );cond
  );while
  (princ)
);defun c:ViewDcl
;-------------------------------------------------------------------------------
; c:DCE - Displays Acad.dce dialog error file if found
;-------------------------------------------------------------------------------
(defun c:DCE (/ PathFile$ FileName% Msg$ Text$)
  (if (setq PathFile$ (findfile "Acad.dce"))
    (progn
      (setq FileName% (open PathFile$ "r"))
      (setq Msg$ "")
      (while (setq Text$ (read-line FileName%))
        (setq Msg$ (strcat Msg$ "\n" Text$))
      );while
      (close FileName%)
      (alert Msg$)
    );progn
    (alert "No current Acad.dce file found to view.")
  );if
  (princ)
);defun c:DCE
;-------------------------------------------------------------------------------
; edit_value - Dialog to edit a value
; Arguments: 2
;   Title$ = Dialog Title
;   Edit1$ = Edit line
; Syntax: (edit_value "Enter Other Value" "")
;-------------------------------------------------------------------------------
(defun edit_value (Title$ Edit1$ / Dcl_Id% NewText$ Return#)
  ; Set Default Variables
  (setq NewText$ Edit1$)
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "MyDialogs.dcl"));Change filename as required
  (new_dialog "edit_value" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" Title$)
  (set_tile "Value" "Value:")
  (set_tile "Edit1" Edit1$)
  ; Dialog Actions
  (action_tile "accept" "(setq NewText$ (get_tile \"Edit1\"))(done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (if (= Return# 0) (setq NewText$ nil))
  NewText$
);defun edit_value
;-------------------------------------------------------------------------------
; set_tile_list - Sets a dialog popup_list or list_box tile to a list
; Arguments: 3
;   KeyName$ = Key name of tile
;   ListName@ = The list to set in tile
;   Selected = An item in the ListNames@ or a list of items selected
; Syntax: (set_tile_list "TileName" '("A" "B" "C") "B")
;         (set_tile_list "TileName" '("A" "B" "C") '("A" "C"))
; Returns: Sets Selected items in dialog popup_list or list_box tiles.
;-------------------------------------------------------------------------------
(defun set_tile_list (KeyName$ ListName@ Selected / Item)
  (start_list KeyName$ 3)
  (mapcar 'add_list ListName@)
  (end_list)
  (foreach Item (if (listp Selected) Selected (list Selected))
   (if (member Item ListName@)
     (set_tile KeyName$ (itoa (- (length ListName@) (length (member Item ListName@)))))
   );if
  );foreach
);defun set_tile_list
;-------------------------------------------------------------------------------
; set_multilist_value - Sets SentVar$ to list of the items selected in SentList$
; Arguments: 2
;   SentList$ = String of the list variable name
;   SentVar$ = String of the variable name
; Syntax: (set_multilist_value "ListName" "Variable")
;-------------------------------------------------------------------------------
(defun set_multilist_value (SentList$ SentVar$ / SubList@)
  (setq SubList@ (eval (read SentList$)))
  (set (read SentVar$) (list (nth (atoi $value) SubList@)))
  (setq $value (substr $value (+ (strlen (itoa (atoi $value))) 2)))
  (while (/= $value "")
    (set (read SentVar$) (append (eval (read SentVar$))
      (list (nth (atoi $value) SubList@)))
    );set
    (setq $value (substr $value (+ (strlen (itoa (atoi $value))) 2)))
  );while
);defun set_multilist_value
;-------------------------------------------------------------------------------
; set_list_value - Sets SentVar$ to the item selected in SentList$
; Arguments: 2
;   SentList$ = String of the list variable name
;   SentVar$ = String of the variable name
; Syntax: (set_list_value "ListName" "Variable")
;-------------------------------------------------------------------------------
(defun set_list_value (SentList$ SentVar$ / SaveVar$ SubList@)
  (setq SubList@ (eval (read SentList$)))
  (setq SaveVar$ (eval (read SentVar$)))
  (set (read SentVar$) (nth (atoi $value) SubList@))
  (if (= (eval (read SentVar$)) "")
    (progn
      (set (read SentVar$) SaveVar$)
      (set_tile_list $key SubList@ SaveVar$)
    );progn
  );if
  (princ)
);defun set_list_value
;-------------------------------------------------------------------------------
; set_other_list - Function to include other values to a list
; Arguments: 2
;   SentList$ = String of the list variable name
;   SentVar$ = String of the variable name
; Syntax: (set_other_list "ListName" "Variable")
;-------------------------------------------------------------------------------
(defun set_other_list (SentList$ SentVar$ / AddOther Other$ SubList@ SubVar$)
  (setq SubList@ (eval (read SentList$))
        SubVar$ (eval (read SentVar$))
  );setq
  (if (= (nth (atoi $value) SubList@) "")
    (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
  );if
  (if (= (nth (atoi $value) SubList@) "Other")
    (progn
      (if (setq Other$ (edit_value "Enter Other Value" SubVar$))
        (setq Other$ (NoSpaces Other$))
        (setq Other$ "")
      );if
      (if (= (strcase Other$) "OTHER") (setq Other$ ""))
      (if (/= Other$ "")
        (progn
          (setq AddOther t)
          (foreach Item SubList@
            (if (= (strcase Other$) (strcase Item))
              (setq $value (itoa (- (length SubList@)(length (member Item SubList@))))
                    AddOther nil)
            );if
          );foreach
          (if AddOther
            (setq SubList@ (insert_nth (- (length SubList@) 2) Other$ SubList@)
                  $value (itoa (- (length SubList@)(length (member Other$ SubList@)))))
          );if
        );progn
        (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
      );if
    );progn
  );if
  (setq SubVar$ (nth (atoi $value) SubList@))
  (start_list $key) (mapcar 'add_list SubList@)(end_list)
  (set_tile $key $value)
  (set (read SentList$) SubList@)
  (set (read SentVar$) SubVar$)
  (princ)
);defun set_other_list
;-------------------------------------------------------------------------------
; set_other_intlist - Function to include other integer numbers to a list
; Arguments: 2
;   SentList$ = String of the list variable name
;   SentVar$ = String of the variable name
; Syntax: (set_other_intlist "ListName" "Variable")
;-------------------------------------------------------------------------------
(defun set_other_intlist (SentList$ SentVar$ / AddOther Cnt# Item Mid$ Other$ Passed
  SubList@ SubVar$)
  (setq SubList@ (eval (read SentList$))
        SubVar$ (eval (read SentVar$))
  );setq
  (if (= (nth (atoi $value) SubList@) "")
    (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
  );if
  (if (= (nth (atoi $value) SubList@) "Other")
    (progn
      (if (setq Other$ (edit_value "Enter an Integer" SubVar$))
        (setq Other$ (vl-string-trim " " Other$))
        (setq Other$ "")
      );if
      (if (= (strcase Other$) "OTHER") (setq Other$ ""))
      (if (/= Other$ "")
        (progn
          (setq Cnt# 1 Passed t)
          (repeat (strlen Other$)
            (setq Mid$ (substr Other$ Cnt# 1))
            (if (not (member Mid$ (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
              (setq Passed nil)
            );if
            (setq Cnt# (1+ Cnt#))
          );repeat
          (if (not Passed)
            (progn
              (alert "Value must be an integer!")
              (setq Other$ "")
            );progn
          );if
        );progn
      );if
      (if (/= Other$ "")
        (progn
          (setq Other$ (itoa (atoi Other$)))
          (setq AddOther t)
          (foreach Item SubList@
            (if (= Other$ Item)
              (setq $value (itoa (- (length SubList@)(length (member Item SubList@))))
                    AddOther nil)
            );if
          );foreach
          (if AddOther
            (setq SubList@ (insert_nth (- (length SubList@) 2) Other$ SubList@)
                  $value (itoa (- (length SubList@)(length (member Other$ SubList@)))))
          );if
        );progn
        (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
      );if
    );progn
  );if
  (setq SubVar$ (nth (atoi $value) SubList@))
  (start_list $key) (mapcar 'add_list SubList@)(end_list)
  (set_tile $key $value)
  (set (read SentList$) SubList@)
  (set (read SentVar$) SubVar$)
  (princ)
);defun set_other_intlist
;-------------------------------------------------------------------------------
; set_other_reallist - Function to include other real numbers to a list
; Arguments: 2
;   SentList$ = String of the list variable name
;   SentVar$ = String of the variable name
; Syntax: (set_other_reallist "ListName" "Variable")
;-------------------------------------------------------------------------------
(defun set_other_reallist (SentList$ SentVar$ / AddOther Cnt# Loop Mid$ Other$
  Passed Period# SubList@ SubVar$)
  (setq SubList@ (eval (read SentList$))
        SubVar$ (eval (read SentVar$))
  );setq
  (if (= (nth (atoi $value) SubList@) "")
    (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
  );if
  (if (= (nth (atoi $value) SubList@) "Other")
    (progn
      (if (setq Other$ (edit_value "Enter a Real Number" SubVar$))
        (setq Other$ (NoSpaces Other$))
        (setq Other$ "")
      );if
      (if (= (strcase Other$) "OTHER") (setq Other$ ""))
      (if (/= Other$ "")
        (progn
          (setq Cnt# 1 Passed t Period# 0)
          (repeat (strlen Other$)
            (setq Mid$ (substr Other$ Cnt# 1))
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
              (setq Other$ "")
            );progn
          );if
        );progn
      );if
      (if (/= Other$ "")
        (progn
          (setq Loop t Cnt# 8)
          (while Loop
            (setq Other$ (rtos (atof Other$) 2 Cnt#))
            (if (= (atof Other$) (atof (rtos (atof Other$) 2 (1- Cnt#))))
              (setq Cnt# (1- Cnt#))
              (setq Loop nil)
            );if
            (if (= Cnt# 0) (setq Loop nil))
          );while
          (setq AddOther t)
          (foreach Item SubList@
            (if (= Other$ Item)
              (setq $value (itoa (- (length SubList@)(length (member Item SubList@))))
                    AddOther nil)
            );if
          );foreach
          (if AddOther
            (setq SubList@ (insert_nth (- (length SubList@) 2) Other$ SubList@)
                  $value (itoa (- (length SubList@)(length (member Other$ SubList@)))))
          );if
        );progn
        (setq $value (itoa (- (length SubList@)(length (member SubVar$ SubList@)))))
      );if
    );progn
  );if
  (setq SubVar$ (nth (atoi $value) SubList@))
  (start_list $key) (mapcar 'add_list SubList@)(end_list)
  (set_tile $key $value)
  (set (read SentList$) SubList@)
  (set (read SentVar$) SubVar$)
  (princ)
);defun set_other_reallist
;-------------------------------------------------------------------------------
; check_editint - Function to verify if value is an integer
; Arguments: 1
;   SentVar$ = String of the variable name
; Syntax: (check_editint "Variable")
;-------------------------------------------------------------------------------
(defun check_editint (SentVar$ / Cnt# Mid$ Passed SubVar$)
  (setq SubVar$ (eval (read SentVar$)))
  (setq Cnt# 1 Passed t)
  (repeat (strlen $value)
    (setq Mid$ (substr $value Cnt# 1))
    (if (not (member Mid$ (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
      (setq Passed nil)
    );if
    (setq Cnt# (1+ Cnt#))
  );repeat
  (if (not Passed)
    (progn
      (alert "Value must be an integer!")
      (set_tile $key SubVar$)
    );progn
    (if (= $value "")
      (set (read SentVar$) $value)
      (progn
        (setq $value (itoa (atoi $value)))
        (set (read SentVar$) $value)
        (set_tile $key $value)
      );progn
    );if
  );if
  (princ)
);defun check_editint
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
; DclTextWidth - List of the width in pixels and the dcl width of a string
; Arguments: 1
;   Str$ = String
; Returns: List of the width in pixels and the dcl width of a string.
;-------------------------------------------------------------------------------
(defun DclTextWidth (Str$ / Cnt# Mid$ Pixels# PixelWidth~)
  (setq Cnt# 1 Pixels# 0 PixelWidth~ 0)
  (if (= (type Str$) 'STR)
    (repeat (strlen Str$)
      (setq Mid$ (substr Str$ Cnt# 1))
      (cond
        ((member Mid$ (list "@" "W"))
          (setq Pixels# (+ Pixels# 11));11 Pixels
        );case
        ((= Mid$ "M")
          (setq Pixels# (+ Pixels# 9));9 Pixels
        );case
        ((member Mid$ (list "%" "D" "G" "H" "N" "O" "Q" "R" "U" "m" "w"))
          (setq Pixels# (+ Pixels# 8));8 Pixels
        );case
        ((member Mid$ (list "#" "A" "B" "C" "E" "K" "P" "S" "T" "V" "X" "Y" "Z" "~"))
          (setq Pixels# (+ Pixels# 7));7 Pixels
        );case
        ((member Mid$ (list "$" "&" "+" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "<" "=" ">" "?" "F" "L" "^" "_" "a" "b" "c" "d" "e" "g" "h" "k" "n" "o" "p" "q" "u" "v"))
          (setq Pixels# (+ Pixels# 6));6 Pixels
        );case
        ((member Mid$ (list (chr 34) "/" "J" (chr 92) "s" "x" "y" "z"))
          (setq Pixels# (+ Pixels# 5));5 Pixels
        );case
        ((member Mid$ (list "*" "{" "}"))
          (setq Pixels# (+ Pixels# 4));4 Pixels
        );case
        ((member Mid$ (list " " "!" "(" ")" "," "-" "." ":" ";" "I" "[" "]" "`" "f" "r" "t"))
          (setq Pixels# (+ Pixels# 3));3 Pixels
        );case
        ((member Mid$ (list "'" "i" "j" "l" "|"))
          (setq Pixels# (+ Pixels# 2));2 Pixels
        );case
        ((member (ascii Mid$) (list 198 230))
          (setq Pixels# (+ Pixels# 10));10 Pixels
        );case
        ((= (ascii Mid$) 169)
          (setq Pixels# (+ Pixels# 9));9 Pixels
        );case
        ((member (ascii Mid$) (list 174 188 189 190 208 209 210 211 212 213 214 216 217 218 219 220))
          (setq Pixels# (+ Pixels# 8));8 Pixels
        );case
        ((member (ascii Mid$) (list 192 193 194 195 196 197 199 200 201 202 203 221 222))
          (setq Pixels# (+ Pixels# 7));7 Pixels
        );case
        ((member (ascii Mid$) (list 128 162 163 164 165 167 171 172 175 177 181 182 187 191 215 223 224 225 226 227 228 229 231 232 233 234 235 240 241 242 243 244 245 246 247 248 249 250 251 252 254 255))
          (setq Pixels# (+ Pixels# 6));6 Pixels
        );case
        ((= (ascii Mid$) 253)
          (setq Pixels# (+ Pixels# 5));5 Pixels
        );case
        ((member (ascii Mid$) (list 170 176 186 237 238 239))
          (setq Pixels# (+ Pixels# 4));4 Pixels
        );case
        ((member (ascii Mid$) (list 127 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 168 173 178 179 180 183 184 185 204 205 206 207))
          (setq Pixels# (+ Pixels# 3));3 Pixels
        );case
        ((member (ascii Mid$) (list 166 236))
          (setq Pixels# (+ Pixels# 2));2 Pixels
        );case
        (t
          (setq Pixels# (+ Pixels# 7));7 Pixels default
        );case
      );cond
      (setq Cnt# (1+ Cnt#))
    );repeat
  );if
  (if (> Pixels# 0)
    (setq PixelWidth~ (atof (rtos (+ (* (1- Pixels#) (/ 1 6.0)) 0.09) 2 2)))
  );if
  (list Pixels# PixelWidth~)
);defun DclTextWidth
;-------------------------------------------------------------------------------
; PhraseList - Returns a list of phrases of a String within a certain DclWidth~
; Arguments: 2
;   Str$ = String to divide into phrases
;   DclWidth~ = Dcl width needed to fit the phrase
; Returns: List of phrases within the DclWidth~ range of the String
;-------------------------------------------------------------------------------
(defun PhraseList (Str$ DclWidth~ / Cnt# Current$ ListBox@ Mid$ Temp$)
  (setq Current$ "" Temp$ "" Cnt# 1 Str$ (strcat Str$ "\n"))
  (repeat (strlen Str$)
    (setq Mid$ (substr Str$ Cnt# 1))
    (cond
      ((= Mid$ " ")
        (if (<= (nth 1 (DclTextWidth (strcat Current$ Temp$))) DclWidth~)
          (setq Current$ (strcat Current$ Temp$) Temp$ " ")
          (setq ListBox@ (append ListBox@ (list Current$))
                Current$ (substr Temp$ 2) Temp$ " "
          );setq
        );if
      );case
      ((= Mid$ "\n")
        (if (<= (nth 1 (DclTextWidth (strcat Current$ Temp$))) DclWidth~)
          (setq Current$ (strcat Current$ Temp$ " ") Temp$ "")
        );if
        (setq ListBox@ (append ListBox@ (list Current$))
              Current$ (substr Temp$ 2) Temp$ ""
        );setq
        (if (/= Current$ "")
          (setq ListBox@ (append ListBox@ (list Current$))
                Current$ "" Temp$ ""
          );setq
        );if
      );case
      (t (setq Temp$ (strcat Temp$ Mid$)))
    );cond
    (setq Cnt# (1+ Cnt#))
  );repeat
  (if (/= Current$ "")
    (setq ListBox@ (append ListBox@ (list Current$)))
  );if
  ListBox@
);defun PhraseList
;-------------------------------------------------------------------------------
; WordList - Returns a list of words in a sentence
; Arguments: 1
;   Sentence$ = String to convert into a list strings
; Syntax: (WordList "Words in a sentence") = (list "Words" "in" "a" "sentence")
; Returns: List of words or strings that were seperated by spaces in a sentence
;-------------------------------------------------------------------------------
(defun WordList (Str$ / List@ Num#)
  (while (setq Num# (vl-string-search " " Str$))
    (setq List@ (cons (substr Str$ 1 Num#) List@)
          Str$ (substr Str$ (+ Num# 2))
    );setq
  );while
  (reverse (cons Str$ List@))
);defun WordList
;-------------------------------------------------------------------------------
; NoSpaces - Truncates left and right spaces from a string.
; Arguments: 1
;   Str$ = String
; Returns: String with the left and right spaces truncated.
;-------------------------------------------------------------------------------
(defun NoSpaces (Str$)
  (vl-string-trim " " Str$)
);defun NoSpaces
;-------------------------------------------------------------------------------
; vector_text - Draws text in a dialog image tile
; Arguments: 6
;   Justify$ = Justification option of "L" "ML" "TL" "C" "M" "TC" "R" "MR" or "TR"
;   X# = Starting X location
;   Y# = Starting Y location
;   Rotation# = Rotation angle of 0 or 90
;   Color# = Color number of text ranging from 0 to 255
;   TextStr$ = Text string to draw
; Returns: Draws text string in a dialog image tile
; Note: Use this function between a start_image and an end_image command.
; Example: (vector_text "M" 110 25 0 5 "Hello World")
;-------------------------------------------------------------------------------
(defun vector_text (Justify$ X# Y# Rotation# Color# TextStr$ / ChrList@ FontList@
  Item Num# Width# XY# X1# X2# Y1# Y2#)
  (setq Justify$ (strcase Justify$))
  (if (not (member Justify$ (list "L" "ML" "TL" "C" "M" "TC" "R" "MR" "TR")))
    (progn (princ "\nvector_text syntax error:\nJustification options are L, ML, TL, C, M, TC, R, MR, and TR.")(exit))
  );if
  (if (and (< Color# 0)(> Color# 255))
    (progn (princ "\nvector_text syntax error:\nColor value ranges between 0 and 255.")(exit))
  );if
  (if (or (< X# 0)(< Y# 0))
    (progn (princ "\nvector_text syntax error:\nValues for X and Y must be a positive number.")(exit))
  );if
  (if (not (or (= Rotation# 0)(= Rotation# 90)))
    (progn (princ "\nvector_text syntax error:\nRotation angle can only be 0 or 90 degrees.")(exit))
  );if
  (setq FontList@ (GetFontList TextStr$))
  (setq Width# 0)
  (if (= Rotation# 0)
    (progn
      (if (member Justify$ (list "TL" "TC" "TR"))
        (setq Y# (1- Y#))
      );if
      (if (member Justify$ (list "ML" "M" "MR"))
        (setq Y# (- Y# 5))
      );if
      (if (member Justify$ (list "L" "C" "R"))
        (setq Y# (- Y# 9))
      );if
      (foreach Item FontList@
        (setq Width# (+ Width# (nth 0 Item)))
      );foreach
      (if (member Justify$ (list "C" "M" "TC"))
        (setq X# (- X# (fix (+ (/ Width# 2.0) 0.5))))
      );if
      (if (member Justify$ (list "R" "MR" "TR"))
        (setq X# (- X# Width#))
      );if
      (foreach ChrList@ FontList@
        (setq Num# 1)
        (while (< Num# (length ChrList@))
          (setq XY# (nth Num# ChrList@)
                X1# (+ X# (nth Num# ChrList@))
                Y1# (+ Y# (nth (1+ Num#) ChrList@))
                X2# (+ X# (nth (+ Num# 2) ChrList@))
                Y2# (+ Y# (nth (+ Num# 3) ChrList@))
          );setq
          (if (and (/= XY# -1)(> X1# -1)(> Y1# -1)(> X2# -1)(> Y2# -1))
            (vector_image X1# Y1# X2# Y2# Color#)
          );if
          (setq Num# (+ Num# 4))
        );while
        (setq X# (+ X# (nth 0 ChrList@)))
      );foreach
    );progn
    (progn
      (if (member Justify$ (list "TL" "TC" "TR"))
        (setq X# (1- X#))
      );if
      (if (member Justify$ (list "ML" "M" "MR"))
        (setq X# (- X# 5))
      );if
      (if (member Justify$ (list "L" "C" "R"))
        (setq X# (- X# 9))
      );if
      (foreach Item FontList@
        (setq Width# (+ Width# (nth 0 Item)))
      );foreach
      (if (member Justify$ (list "C" "M" "TC"))
        (setq Y# (+ Y# (fix (+ (/ Width# 2.0) 0.5))))
      );if
      (if (member Justify$ (list "R" "MR" "TR"))
        (setq Y# (+ Y# Width#))
      );if
      (foreach ChrList@ FontList@
        (setq Num# 1)
        (while (< Num# (length ChrList@))
          (setq XY# (nth Num# ChrList@)
                X1# (+ X# (nth (1+ Num#) ChrList@))
                Y1# (- Y# (nth Num# ChrList@))
                X2# (+ X# (nth (+ Num# 3) ChrList@))
                Y2# (- Y# (nth (+ Num# 2) ChrList@))
          );setq
          (if (and (/= XY# -1)(> X1# -1)(> Y1# -1)(> X2# -1)(> Y2# -1))
            (vector_image X1# Y1# X2# Y2# Color#)
          );if
          (setq Num# (+ Num# 4))
        );while
        (setq Y# (- Y# (nth 0 ChrList@)))
      );foreach
    );progn
  );if
);defun vector_text
;-------------------------------------------------------------------------------
; GetFontList - Gets vector points of font string
; Arguments: 1
;   Str$ = Text string
; Returns: List of vector points of font string
;-------------------------------------------------------------------------------
(defun GetFontList (Str$ / C$ ChrList@ FontList@ Num# PercentPercent:)
  ;-----------------------------------------------------------------------------
  ; PercentPercent: - Replaces special characters begining with %%.
  ; Arguments: 1
  ;   Str$ = String
  ; Returns: String with %%d, %%c and %%p characters replaced.
  ;-----------------------------------------------------------------------------
  (defun PercentPercent: (Str$)
    (if (wcmatch Str$ "*%%D*")
      (setq Str$ (FindReplace Str$ "%%D" (chr 176)));degree
    );if
    (if (wcmatch Str$ "*%%d*")
      (setq Str$ (FindReplace Str$ "%%d" (chr 176)));degree
    );if
    (if (wcmatch Str$ "*%%P*")
      (setq Str$ (FindReplace Str$ "%%P" (chr 177)));plus/minus
    );if
    (if (wcmatch Str$ "*%%p*")
      (setq Str$ (FindReplace Str$ "%%p" (chr 177)));plus/minus
    );if
    (if (wcmatch Str$ "*%%C*")
      (setq Str$ (FindReplace Str$ "%%C" (chr 248)));diameter
    );if
    (if (wcmatch Str$ "*%%c*")
      (setq Str$ (FindReplace Str$ "%%c" (chr 248)));diameter
    );if
    (if (wcmatch Str$ "*?*")
      (setq Str$ (FindReplace Str$ (chr 216) (chr 248)));diameter
    );if
    Str$
  );defun PercentPercent:
  ;-----------------------------------------------------------------------------
  ; Start of main function
  ;-----------------------------------------------------------------------------
  (setq Str$ (PercentPercent: Str$))
  (setq Num# 1)
  (repeat (strlen Str$)
    (setq C$ (substr Str$ Num# 1))
    (setq ChrList@
      (cond
        ((= C$" ")'(3 -1 -1 -1 -1))((= C$"!")'(3 1 7 1 1 1 9 1 9))((= C$"\"")'(5 1 1 1 3 4 1 4 3))((= C$"#")'(7 1 7 6 7 1 3 6 3 2 1 2 9 5 1 5 9))((= C$"$")'(6 3 1 3 10 1 8 1 8 2 9 4 9 1 3 1 4 4 6 2 5 4 2 2 2 5 8 5 7 5 3 5 3))((= C$"%")'(8 1 8 7 2 4 8 4 8 1 2 1 2 2 3 3 3 2 1 3 1 4 2 4 2 5 7 6 7 5 9 6 9 7 8 7 8))((= C$"&")'(6 1 6 1 8 2 9 3 9 4 8 4 7 1 2 1 3 2 4 2 5 3 6 3 6 2 1 2 1 3 2 3 3 5 9 5 9 5 6 5 6))((= C$"'")'(2 1 1 1 3))((= C$"(")'(3 1 2 1 10 2 11 2 11 2 1 2 1))((= C$")")'(3 2 2 2 10 1 11 1 11 1 1 1 1))((= C$"*")'(4 1 4 3 2 1 2 3 4))((= C$"+")'(6 1 6 5 6 3 4 3 8))((= C$",")'(3 1 10 2 9))((= C$"-")'(3 1 6 2 6))((= C$".")'(3 1 9 1 9))((= C$"/")'(5 1 9 4 2 4 1 4 1))((= C$"0")'(6 1 2 1 8 2 9 4 9 2 1 4 1 5 2 5 8))((= C$"1")'(6 3 1 3 9 1 2 2 2))((= C$"2")'(6 5 9 1 9 1 8 4 5 1 2 1 2 2 1 4 1 5 2 5 4))((= C$"3")'(6 1 8 1 8 2 9 4 9 1 2 1 2 4 5 3 5 2 1 4 1 5 8 5 6 5 2 5 4))((= C$"4")'(6 5 7 1 7 4 1 4 9 3 2 1 7))((= C$"5")'(6 5 1 1 1 1 8 1 8 4 9 2 9 1 1 1 5 2 4 4 4 5 5 5 8))
        ((= C$"6")'(6 1 8 1 2 2 9 4 9 4 5 2 5 2 1 4 1 5 8 5 6 5 2 5 2))((= C$"7")'(6 5 1 2 8 1 1 5 1 2 9 2 9))((= C$"8")'(6 1 6 1 8 2 9 4 9 1 2 1 4 2 5 4 5 2 1 4 1 5 6 5 8 5 2 5 4))((= C$"9")'(6 1 8 1 8 2 9 4 9 1 2 1 4 2 5 4 5 2 1 4 1 5 2 5 8))((= C$":")'(3 1 9 1 9 1 4 1 4))((= C$";")'(3 1 10 2 9 2 4 2 4))((= C$"<")'(6 1 6 4 9 1 6 4 3))((= C$"=")'(6 1 7 5 7 1 5 5 5))((= C$">")'(6 4 6 1 9 1 3 4 6))((= C$"?")'(6 3 6 3 7 3 9 3 9 1 2 1 2 4 5 4 5 2 1 4 1 5 2 5 4))((= C$"@")'(11 4 10 8 10 4 1 7 1 1 4 1 7 2 9 3 9 2 8 2 9 4 5 4 6 3 2 2 2 2 2 2 3 8 7 10 7 5 7 6 7 7 4 5 4 7 4 7 6 8 2 9 2 9 2 9 3 10 4 10 7))((= C$"A")'(7 3 1 5 6 1 7 5 7 0 9 0 8 1 6 3 1 6 8 6 9))((= C$"B")'(7 1 1 1 9 1 9 4 9 1 5 4 5 1 1 4 1 5 6 5 8 5 2 5 4))((= C$"C")'(7 2 9 5 9 2 1 5 1 1 2 1 8 6 8 6 8 6 2 6 2))((= C$"D")'(8 1 1 1 9 1 9 4 9 1 1 4 1 6 3 6 7 5 8 5 8 5 2 5 2))((= C$"E")'(7 1 9 5 9 1 1 5 1 1 1 1 9 1 5 4 5))((= C$"F")'(6 1 1 5 1 1 1 1 9 1 5 4 5))((= C$"G")'(8 4 5 6 5 2 1 5 1 1 2 1 8 4 9 2 9 6 5 6 9 5 8 5 8 6 2 6 2))
        ((= C$"H")'(8 1 5 6 5 1 1 1 9 6 1 6 9))((= C$"I")'(3 1 1 1 9))((= C$"J")'(5 3 8 3 1 1 9 2 9 0 7 0 8))((= C$"K")'(7 2 5 6 9 5 1 2 4 1 1 1 9))((= C$"L")'(6 1 9 5 9 1 1 1 9))((= C$"M")'(9 4 8 6 3 1 9 1 1 4 8 2 3 7 1 7 9))((= C$"N")'(8 1 1 1 9 2 2 3 5 4 6 4 6 6 9 6 1 5 7 5 8))((= C$"O")'(8 2 9 5 9 2 1 5 1 1 2 1 8 6 2 6 8))((= C$"P")'(7 5 5 1 5 1 1 5 1 1 9 1 1 6 2 6 4))((= C$"Q")'(8 5 8 4 7 2 9 5 9 2 1 5 1 1 2 1 8 6 2 6 8 6 10 6 10))((= C$"R")'(8 1 1 5 1 5 5 1 5 1 9 1 1 6 6 6 9 6 2 6 4))((= C$"S")'(7 1 8 1 8 2 9 4 9 1 2 1 4 2 5 4 5 2 1 4 1 5 6 5 8 5 2 5 2))((= C$"T")'(7 1 1 5 1 3 1 3 9))((= C$"U")'(8 2 9 5 9 1 1 1 8 6 1 6 8))((= C$"V")'(7 5 4 3 9 1 4 3 9 0 1 1 4 6 1 5 4))((= C$"W")'(11 5 4 3 9 1 4 3 9 0 1 1 4 10 1 9 4 9 4 7 9 5 4 7 9 5 3 5 3))((= C$"X")'(7 1 3 5 7 1 7 5 3 0 9 0 8 0 1 0 2 6 8 6 9 6 1 6 2))((= C$"Y")'(7 3 5 5 3 3 6 3 9 1 3 3 5 0 1 0 2 6 1 6 2))((= C$"Z")'(7 0 8 6 2 0 9 6 9 0 1 6 1))((= C$"[")'(3 1 1 1 11 2 11 2 11 2 1 2 1))((= C$"\\")'(5 1 2 4 9 1 1 1 1))
        ((= C$"]")'(3 2 1 2 11 1 11 1 11 1 1 1 1))((= C$"^")'(6 1 2 3 0 3 0 5 2))((= C$"_")'(6 0 11 5 11))((= C$"`")'(3 1 1 2 2))((= C$"a")'(6 2 6 5 6 5 9 2 9 1 8 1 7 4 4 2 4 5 9 5 5))((= C$"b")'(6 1 1 1 9 1 9 4 9 1 4 4 4 5 5 5 8))((= C$"c")'(6 1 5 1 8 2 9 4 9 2 4 4 4 5 8 5 8 5 5 5 5))((= C$"d")'(6 2 4 5 4 2 9 5 9 1 5 1 8 5 9 5 1))((= C$"e")'(6 1 6 5 6 1 5 1 8 2 9 4 9 2 4 4 4 5 8 5 8 5 5 5 5))((= C$"f")'(3 1 2 1 9 2 4 2 4 2 1 2 1))((= C$"g")'(6 2 4 5 4 2 9 5 9 1 5 1 8 4 11 1 11 5 4 5 10))((= C$"h")'(6 1 1 1 9 2 5 2 5 3 4 4 4 5 5 5 9))((= C$"i")'(2 1 9 1 4 1 1 1 1))((= C$"j")'(2 1 4 1 11 1 1 1 1))((= C$"k")'(6 5 9 2 6 1 1 1 9 2 6 4 4))((= C$"l")'(2 1 1 1 9))((= C$"m")'(8 1 9 1 4 4 9 4 5 3 4 2 4 7 9 7 5 5 4 6 4))((= C$"n")'(6 1 9 1 4 2 5 2 5 3 4 4 4 5 5 5 9))((= C$"o")'(6 1 5 1 8 2 9 4 9 2 4 4 4 5 8 5 5))((= C$"p")'(6 1 4 1 11 1 9 4 9 1 4 4 4 5 8 5 5))((= C$"q")'(6 5 9 2 9 5 4 2 4 1 8 1 5 5 4 5 11))((= C$"r")'(3 1 9 1 4 2 4 2 4))((= C$"s")'(5 1 5 4 8 1 8 1 8 2 9 3 9 2 4 3 4 4 5 4 5))
        ((= C$"t")'(3 1 1 1 8 2 9 2 9 2 4 2 4))((= C$"u")'(6 1 4 1 8 2 9 3 9 4 8 4 8 5 9 5 4))((= C$"v")'(6 3 9 5 4 1 4 3 9))((= C$"w")'(8 6 9 4 4 1 4 1 7 2 9 4 4 7 4 7 7))((= C$"x")'(5 1 4 2 7 3 6 4 9 1 9 1 8 2 7 2 7 4 4 4 5))((= C$"y")'(5 4 4 4 7 1 4 1 7 1 11 0 11 2 8 2 10 3 8 3 8))((= C$"z")'(5 1 8 4 5 1 9 4 9 1 4 4 4))((= C$"{")'(4 2 6 2 9 3 10 3 10 1 5 1 5 2 4 2 1 3 0 3 0))((= C$"|")'(2 1 1 1 10))((= C$"}")'(4 2 6 2 9 1 10 1 10 2 4 2 1 3 5 3 5 1 0 1 0))((= C$"~")'(7 2 2 5 3 1 3 1 3 6 2 6 2))((= C$(chr 176))'(4 1 2 2 3 2 1 3 2))((= C$(chr 177))'(6 1 9 5 9 1 5 5 5 3 3 3 7))((= C$(chr 248))'(6 3 5 5 3 1 8 3 6 4 8 3 8 1 4 1 6 3 3 2 3 5 5 5 7))
      );cond
    );setq
    (setq FontList@ (append FontList@ (list ChrList@)))
    (setq Num# (1+ Num#))
  );repeat
  (if FontList@ FontList@ (list '(3 -1 -1 -1 -1)))
);defun GetFontList
;-------------------------------------------------------------------------------
; Utilities for converting pixels, width and height
;-------------------------------------------------------------------------------
; PixelsToWidth - Converts pixels to width as a string or number
; Arguments: 1
;   Pixels = String or integer of pixels
; Returns: Width as a string or a number
;-------------------------------------------------------------------------------
(defun PixelsToWidth (Pixels / String Width)
  (if (= (type Pixels) 'STR)
    (setq String t Pixels (atoi Pixels))
  );if
  (if (< Pixels 1) (setq Pixels 1))
  (setq Width (atof (rtos (+ (* (1- Pixels) (/ 1 6.0)) 0.09) 2 2)))
  (if String (setq Width (rtos Width 2 2)))
  Width
);defun PixelsToWidth
;-------------------------------------------------------------------------------
; WidthToPixels - Converts width to pixels as a string or an integer
; Arguments: 1
;   Width = String or number of the width
; Returns: Pixels as a string or an integer
;-------------------------------------------------------------------------------
(defun WidthToPixels (Width / Pixels String)
  (if (= (type Width) 'STR)
    (setq String t Width (atof Width))
  );if
  (if (< Width 0.09) (setq Width 0.09))
  (setq Pixels (fix (+ 1.5 (/ (- Width 0.09) (/ 1 6.0)))))
  (if String (setq Pixels (itoa Pixels)))
  Pixels
);defun WidthToPixels
;-------------------------------------------------------------------------------
; PixelsToHeight - Converts pixels to height as a string or number
; Arguments: 1
;   Pixels = String or integer of pixels
; Returns: Height as a string or a number
;-------------------------------------------------------------------------------
(defun PixelsToHeight (Pixels / Height String)
  (if (= (type Pixels) 'STR)
    (setq String t Pixels (atoi Pixels))
  );if
  (if (< Pixels 1)(setq Pixels 1))
  (setq Height (atof (rtos (+ (* (1- Pixels)(/ 1 13.0)) 0.048) 2 2)))
  (if String (setq Height (rtos Height 2 2)))
  Height
);defun PixelsToHeight
;-------------------------------------------------------------------------------
; HeightToPixels - Converts height to pixels as a string or an integer
; Arguments: 1
;   Height = String or number of the height
; Returns: Pixels as a string or an integer
;-------------------------------------------------------------------------------
(defun HeightToPixels (Height / Pixels String)
  (if (= (type Height) 'STR)
    (setq String t Height (atof Height))
  );if
  (if (< Height 0.05)(setq Height 0.05))
  (setq Pixels (fix (+ 1.5 (/ (- Height 0.048) (/ 1 13.0)))))
  (if String (setq Pixels (itoa Pixels)))
  Pixels
);defun HeightToPixels
;-------------------------------------------------------------------------------
; Utilities for modifying Lists
;-------------------------------------------------------------------------------
; Change_nth - Changes the nth item in a list with a new item value.
; Arguments: 3
;   Num# = Nth number in list to change
;   Value = New item value to change to
;   OldList@ = List to change item value
; Returns: A list with the nth item value changed.
;-------------------------------------------------------------------------------
(defun Change_nth (Num# Value OldList@)
  (if (<= 0 Num# (1- (length OldList@)))
    (if (> Num# 0)
      (cons (car OldList@) (Change_nth (1- Num#) Value (cdr OldList@)))
      (cons Value (cdr OldList@))
    );if
    OldList@
  );if
);defun Change_nth
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
; Move_nth - Moves the nth Num1# item value to the nth Num2# location in a list.
; Arguments: 3
;   Num1# = Nth number in list to move item value
;   Num2# = Nth number in list to move item value of nth Num1# into
;   OldList@ = List to move item values
; Returns: A list with nth item value moved.
;-------------------------------------------------------------------------------
(defun Move_nth (Num1# Num2# OldList@ / Move_nth:)
  (defun Move_nth: (Num1# Num2# OldList@ Nth# Item)
    (cond
      ((and (> Nth# Num1#) (> Nth# Num2#))
        OldList@
      );case
      ((= Nth# Num1#)
        (Move_nth: Num1# (1+ Num2#) (cdr OldList@) (1+ Nth#) Item)
      );case
      ((= Nth# Num2#)
        (cons Item (Move_nth: (1+ Num1#) Num2# OldList@ (1+ Nth#) Item))
      );case
      ((cons (car OldList@)
        (Move_nth: Num1# Num2# (cdr OldList@) (1+ Nth#) Item))
      );case
    );cond
  );defun Move_nth:
  (if (and (/= Num1# Num2#) (<= 0 Num1# (1- (length OldList@))) (<= 0 Num2# (1- (length OldList@))))
    (Move_nth: Num1# Num2# OldList@ 0 (nth Num1# OldList@))
    OldList@
  );if
);defun Move_nth
;-------------------------------------------------------------------------------
; Remove_nths - Removes the RemoveList@ of nths from a list.
; Arguments: 2
;   RemoveList@ = List of nths to remove
;   OldList@ = List to remove the list of nths from
; Returns: A list with the list of nths removed.
;-------------------------------------------------------------------------------
(defun Remove_nths (RemoveList@ OldList@)
  (if (and RemoveList@ OldList@)
    (if (zerop (car RemoveList@))
      (Remove_nths (mapcar '1- (cdr RemoveList@)) (cdr OldList@))
      (cons (car OldList@) (Remove_nths (mapcar '1- RemoveList@) (cdr OldList@)))
    );if
    OldList@
  );if
);defun Remove_nths
;-------------------------------------------------------------------------------
; Switch_nth - Switches the nth Num1# and Num2# item values in a list.
; Arguments: 3
;   Num1# = nth number in list to switch with nth Num2#
;   Num2# = nth number in list to switch with nth Num1#
;   OldList@ = List to switch item values
; Returns: A list with two item values switched.
;-------------------------------------------------------------------------------
(defun Switch_nth (Num1# Num2# OldList@ / Index#)
  (setq Index# -1)
  (if (and (< -1 Num1# (length OldList@)) (< -1 Num2# (length OldList@)))
    (mapcar '(lambda (x) (setq Index# (1+ Index#))
      (cond
        ((= Index# Num2#) (nth Num1# OldList@))
        ((= Index# Num1#) (nth Num2# OldList@))
        (x)
      )) OldList@
    );mapcar
    OldList@
  );if
);defun Switch_nth
;-------------------------------------------------------------------------------
; select_pick - Image for select pick button
; Dcl Specs: image_button width = 3.59; height = 1.66;
;-------------------------------------------------------------------------------
(defun select_pick ()
  (start_image "select_pick")
  ; Fill image from 4,4 across 11 and down 10 with color 255 white
  (fill_image 4 4 11 10 255)
  ; Draw a X from 9,5 to 13,9 and 9,9 to 13,5 with color 1 red
  (vector_image 9 5 13 9 1)
  (vector_image 9 9 13 5 1)
  ; Use mapcar function to reduce the amount of code for vector_image
  (mapcar 'vector_image
    (list  3  3  3 15 13 14 15 16 17 17  12  12  13  16  14  16  16); X1
    (list  3  3 14  3  8  9 10 11 12 16   7   7  15  14  15  18  14); Y1
    (list 15  3 15 15 13 14 15 16 17 17  12  18  14  17  16  17  18); X2
    (list  3 14 14 14 15 15 16 17 13 17  16  13  15  13  18  18  17); Y2
    (list  9  9  8  8  2  2  2  2  2  2 250 250 250 250 250 250 250); Color
  );mapcar
  (end_image)
);defun select_pick
;-------------------------------------------------------------------------------
; Front_View - Front view of computer image
; Dcl Specs: image_button width = 35.92; height = 16.59;
;-------------------------------------------------------------------------------
(defun Front_View ()
  (start_image "Image1")
  (fill_image 30 23 156 178 -2)
  (vector_text "M" 107 194 0 2 "FRONT VIEW");*Included
  (mapcar 'vector_image; Front View
    (list 170 174 170 170  86  87  89  87 126 127 129 127 116 117 119 117  96  97  99  97 106 107 109 107  75  77  74  66  61  61 149 141 134 134 138  81  43 172  30  30 185  43  43  30)
    (list 149 145 145 145 146 145 146 149 146 145 146 149 146 145 146 149 146 145 146 149 146 145 146 149 160 166 175 180 184 184 180 175 172 172 166 172  36  36  23 160  23 133  36  23)
    (list 174 174 174 170  86  88  89  88 126 128 129 128 116 118 119 118  96  98  99  98 106 108 109 108  77  81  81  74  66 154 154 149 141 138 140 134  43 172  30 185 185 172 172 185)
    (list 149 149 145 149 148 145 148 149 148 145 148 149 148 145 148 149 148 145 148 149 148 145 148 149 166 172 172 175 180 184 184 180 175 166 160 172 133 133 160 160 160 133  36  23)
    (list   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4)
  );mapcar
  (mapcar 'vector_image; Arrows  Top, Left,                       Right,                      Bottom
    (list 108 108 107 104 104 106 106   4   7   7   7   7   4   4 208 208 203 203 208 208 211 108 108 107 104 104 106 106)
    (list   4   7  12   7   7   4   4 106 104 104 110 108 108 106 106 104 107 107 108 108 106 208 208 203 208 208 208 211)
    (list 108 110 110 107 106 106 108   7   7  12  12   7   7   4 211 208 208 208 208 211 211 108 110 110 107 106 106 108)
    (list   7   7   7  12   7   7   4 106 106 107 107 110 108 108 106 106 104 110 110 108 108 211 208 208 203 208 211 211)
    (list   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3)
  );mapcar
  (end_image)
);defun Front_View
;-------------------------------------------------------------------------------
; Top_View - Top view of computer image
; Dcl Specs: image_button width = 35.92; height = 16.59;
;-------------------------------------------------------------------------------
(defun Top_View ()
  (start_image "Image1")
  (fill_image 30 23 156 178 -2)
  (vector_text "M" 107 194 0 2 "TOP VIEW");*Included
  (mapcar 'vector_image; Top View
    (list 160 101 114 126 138 147 155 162 168 174 179 183  89  77  68  60  53  47  41  36  32  30  46  55 185  30  30  30)
    (list  33  97  97  99 103 107 112 118 125 133 142 152  99 103 107 112 118 125 133 142 152 162 126  33 162 162 162 184)
    (list 169 114 126 138 147 155 162 168 174 179 183 185 101  89  77  68  60  53  47  41  36  32  55 160 185  30 185 185)
    (list 126  97  99 103 107 112 118 125 133 142 152 162  97  99 103 107 112 118 125 133 142 152  33  33 184 184 162 184)
    (list   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4)
  );mapcar
  (mapcar 'vector_image; Arrows  Top, Left,                       Right,                      Bottom
    (list 108 108 107 104 104 106 106   4   7   7   7   7   4   4 208 208 203 203 208 208 211 108 108 107 104 104 106 106)
    (list   4   7  12   7   7   4   4 106 104 104 110 108 108 106 106 104 107 107 108 108 106 208 208 203 208 208 208 211)
    (list 108 110 110 107 106 106 108   7   7  12  12   7   7   4 211 208 208 208 208 211 211 108 110 110 107 106 106 108)
    (list   7   7   7  12   7   7   4 106 106 107 107 110 108 108 106 106 104 110 110 108 108 211 208 208 203 208 211 211)
    (list   1   1   1   1   1   1   1   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3)
  );mapcar
  (end_image)
);defun Top_View
;-------------------------------------------------------------------------------
; Left_View - Left view of computer image
; Dcl Specs: image_button width = 35.92; height = 16.59;
;-------------------------------------------------------------------------------
(defun Left_View ()
  (start_image "Image1")
  (fill_image 30 23 156 178 -2)
  (vector_text "M" 107 194 0 2 "LEFT VIEW");*Included
  (mapcar 'vector_image; Left View
    (list  68  78  88  97 106 115 123 132 141 151 96 151 142 134 124 115 105  96  97 161 157 157 164 172  84  84  89  97 100 104  54  32  32 161 161  54  32 161 183)
    (list 124 125 128 131 136 142 148 153 156 159 35  23  24  25  27  29  32  35 157 166 172 172 175 180 184 184 180 175 166 172 155 121  43 160  23 123  43  23  23)
    (list  78  88  97 106 115 123 132 141 151 161 96 161 151 142 134 124 115 105 100 163 161 164 172 177 177  89  97 104 104 157 161  68 127 183 183  54  32 161 183)
    (list 125 128 131 136 142 148 153 156 159 160 39  23  23  24  25  27  29  32 166 160 166 175 180 184 184 180 175 172 172 172 160 124  37 160  23 155 121 160 160)
    (list   4   4   4   4   4   4   4   4   4   4  4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4)
  );mapcar
  (mapcar 'vector_image; Arrows  Top, Left,                       Right,                      Bottom
    (list 108 108 107 104 104 106 106   4   7   7   7   7   4   4 208 208 203 203 208 208 211 108 108 107 104 104 106 106)
    (list   4   7  12   7   7   4   4 106 104 104 110 108 108 106 106 104 107 107 108 108 106 208 208 203 208 208 208 211)
    (list 108 110 110 107 106 106 108   7   7  12  12   7   7   4 211 208 208 208 208 211 211 108 110 110 107 106 106 108)
    (list   7   7   7  12   7   7   4 106 106 107 107 110 108 108 106 106 104 110 110 108 108 211 208 208 203 208 211 211)
    (list   3   3   3   3   3   3   3   1   1   1   1   1   1   1   3   3   3   3   3   3   3   3   3   3   3   3   3   3)
  );mapcar
  (end_image)
);defun Left_View
;-------------------------------------------------------------------------------
; Right_View - Right view of computer image
; Dcl Specs: image_button width = 35.92; height = 16.59;
;-------------------------------------------------------------------------------
(defun Right_View ()
  (start_image "Image1")
  (fill_image 30 23 156 178 -2)
  (vector_text "M" 107 194 0 2 "RIGHT VIEW");*Included
  (mapcar 'vector_image; Right View
    (list  54  64  74  83  92 100 109 118 127 137 119 110 100  91 81 73 64 54 115  52  54  51  43  38  38 126 118 111 111  58  54 147  88  32 32 161 183  54  32)
    (list 160 159 156 153 148 142 136 131 128 125  35  32  29  27 25 24 23 23 166 160 166 175 180 184 184 180 175 172 172 172 160 124  37 160 23 123  43  23  23)
    (list  64  74  83  92 100 109 118 127 137 147 119 119 110 100 91 81 73 64 118  54  58  58  51  43 131 131 126 118 115 111 161 183 183  54 54 161 183  54  32)
    (list 159 156 153 148 142 136 131 128 125 124  39  35  32  29 27 25 24 23 157 166 172 172 175 180 184 184 180 175 166 172 155 121  43 160 23 155 121 160 160)
    (list   4   4   4   4   4   4   4   4   4   4   4   4   4   4  4  4  4  4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4  4   4   4   4   4)
  );mapcar
  (mapcar 'vector_image; Arrows  Top, Left,                       Right,                      Bottom
    (list 108 108 107 104 104 106 106   4   7   7   7   7   4   4 208 208 203 203 208 208 211 108 108 107 104 104 106 106)
    (list   4   7  12   7   7   4   4 106 104 104 110 108 108 106 106 104 107 107 108 108 106 208 208 203 208 208 208 211)
    (list 108 110 110 107 106 106 108   7   7  12  12   7   7   4 211 208 208 208 208 211 211 108 110 110 107 106 106 108)
    (list   7   7   7  12   7   7   4 106 106 107 107 110 108 108 106 106 104 110 110 108 108 211 208 208 203 208 211 211)
    (list   3   3   3   3   3   3   3   3   3   3   3   3   3   3   1   1   1   1   1   1   1   3   3   3   3   3   3   3)
  );mapcar
  (end_image)
);defun Right_View
;-------------------------------------------------------------------------------
; Bottom_View - Bottom view of computer image
; Dcl Specs: image_button width = 35.92; height = 16.59;
;-------------------------------------------------------------------------------
(defun Bottom_View ()
  (start_image "Image1")
  (fill_image 30 23 156 178 -2)
  (vector_text "M" 107 194 0 2 "BOTTOM VIEW");*Included
  (mapcar 'vector_image; Bottom View
    (list 132 135 135 132 109  78  78  81  81  82 81 78 78 81  82 135 135 132 132 108 108 105 105 152 147 141 132 123 113 102  92 83 74 68 63 61 61  61  63  68  74  83  92 102 113 123 132 141 147 152 154 156 109  54  59 160 169 174 179 183 41 36 32 30  46  55 185 30 143 30  30)
    (list 113 115 110 112  87 112 113 115 110 111 56 58 59 61  60  61  56  58  59  88  83  85  86  70  61  53  46  41  39  39  41 46 53 61 70 80 80  91 101 111 119 125 130 132 132 130 125 119 111 101  80 162  84  55 162 184  91  84  75  65 84 75 65 55  91 184  33 33  55 55  33)
    (list 134 137 137 134 133  80  80  83  83 106 83 80 80 83 106 137 137 134 134 110 110 107 107 154 152 147 141 132 123 113 102 92 83 74 68 63 61  63  68  74  83  92 102 113 123 132 141 147 152 154 154 161 133  59 156 169 174 179 183 185 46 41 36 32  55 160 185 30 185 72 185)
    (list 115 113 112 110 111 110 115 113 112  87 58 56 61 59  84  59  58  56  61  86  85  83  88  80  70  61  53  46  41  39  39 41 46 53 61 70 91 101 111 119 125 130 132 132 130 125 119 111 101  91  91  55  60 162 162  91  84  75  65  55 91 84 75 65 184 184  55 55  55 55  33)
    (list   4   4   4   4   4   4   4   4   4   4  4  4  4  4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4  4  4  4  4  4  4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4  4  4  4  4   4   4   4  4   4  4   4)
  );mapcar
  (mapcar 'vector_image; Arrows  Top, Left,                       Right,                      Bottom
    (list 108 108 107 104 104 106 106   4   7   7   7   7   4   4 208 208 203 203 208 208 211 108 108 107 104 104 106 106)
    (list   4   7  12   7   7   4   4 106 104 104 110 108 108 106 106 104 107 107 108 108 106 208 208 203 208 208 208 211)
    (list 108 110 110 107 106 106 108   7   7  12  12   7   7   4 211 208 208 208 208 211 211 108 110 110 107 106 106 108)
    (list   7   7   7  12   7   7   4 106 106 107 107 110 108 108 106 106 104 110 110 108 108 211 208 208 203 208 211 211)
    (list   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   1   1   1   1   1   1   1)
  );mapcar
  (end_image)
);defun Bottom_View
;-------------------------------------------------------------------------------
; Calculator - Calculator Image Button
; Dcl Specs: image_button width = 5.42; height = 2.51;
;-------------------------------------------------------------------------------
(defun Calculator ()
  (start_image "Calculator")
  (fill_image 2 2 29 29 9)
  (mapcar 'vector_image
    (list 25 25 25   4   4   4  25  25  18  18  18  11  11  11   4   4   4)
    (list 15 14 16   8   9   7  21  27  15  21  27  15  21  27  15  21  27)
    (list 28 28 28  28  28  28  28  28  21  21  21  14  14  14   7   7   7)
    (list 15 14 16   8   9   7  21  27  15  21  27  15  21  27  15  21  27)
    (list 10 11 12 130 131 140 141 141 141 141 141 141 141 141 141 141 141)
  );mapcar
  (mapcar 'vector_image
    (list  25   4   4   4  11  11  11  18  18  18  25   4   4)
    (list  22  28  22  16  28  22  16  28  22  16  28   6   5)
    (list  28   7   7   7  14  14  14  21  21  21  28  28  28)
    (list  22  28  22  16  28  22  16  28  22  16  28   6   5)
    (list 143 143 143 143 143 143 143 143 143 143 143 150 160)
  );mapcar
  (mapcar 'vector_image
    (list  31   3   2  30  29   3   1   1   4   4   4  11  11  11  18  18  18  25  25)
    (list   3  31  30   2  31   1   3   3  26  20  14  26  20  14  26  20  14  26  20)
    (list  31  29   3  31  31  29   1   3   7   7   7  14  14  14  21  21  21  28  28)
    (list  29  31  31   3  29   1  29   1  26  20  14  26  20  14  26  20  14  26  20)
    (list 250 250 250 250 250 255 255 255 255 255 255 255 255 255 255 255 255 255 255)
  );mapcar
  (mapcar 'vector_image
    (list   3   4   8   4   4   8   4   3   4   8   4   3  11  15  11  10  11  15  11  10  11  15  11  10  18  22  18  17  18  22  18  17  18  22  18  17  25  29  25  24  25  29  25  24  25  29  25  24   3  29   4   4)
    (list  26  29  26  25  19  20  23  20  13  14  17  14  25  26  29  26  19  20  23  20  13  14  17  14  25  26  29  26  19  20  23  20  13  14  17  14  25  26  29  26  19  20  23  20  13  14  17  14   5   5   4  10)
    (list   3   7   8   7   7   8   7   3   7   8   7   3  14  15  14  10  14  15  14  10  14  15  14  10  21  22  21  17  21  22  21  17  21  22  21  17  28  29  28  24  28  29  28  24  28  29  28  24   3  29  28  28)
    (list  28  29  28  25  19  22  23  22  13  16  17  16  25  28  29  28  19  22  23  22  13  16  17  16  25  28  29  28  19  22  23  22  13  16  17  16  25  28  29  28  19  22  23  22  13  16  17  16   9   9   4  10)
    (list 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252 252)
  );mapcar
  (end_image)
);defun Calculator
;-------------------------------------------------------------------------------
(princ);End of MyDialogs.lsp
