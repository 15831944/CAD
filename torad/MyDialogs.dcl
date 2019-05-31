dcl_settings : default_dcl_settings { audit_level = 3; }

//------------------------------------------------------------------------------
// Program Name: MyDialogs.dcl
// Created By:   Terry Miller (Email: terrycadd@yahoo.com)
//               (URL: http://web2.airmail.net/terrycad)
// Date Created: 7-20-06
// Function:     Tutorial for Getting Started with Dcl Dialogs
//------------------------------------------------------------------------------
// Revision History
// Rev  By     Date    Description
//------------------------------------------------------------------------------
// 1    TM   7-20-06   Initial version
//------------------------------------------------------------------------------
// MyFirst
//------------------------------------------------------------------------------
MyFirst : dialog {
  label = " Hello World";
  spacer;
  : text {
    label = "This is my first dialog.";
    alignment = centered;
  }
  spacer;
  ok_only;
}//MyFirst

//------------------------------------------------------------------------------
// pdfdlg
//------------------------------------------------------------------------------
pdfdlg:dialog {
    label = "Batch Plot" ;
    :text {
        key = "txt1" ;
		width=45;
		fixed_width=true;
    }
    :spacer {
    }
    :row {
        :popup_list {
            fixed_width = true ;
            key = "pop1" ;
            width = 25 ;
        }
        :text {
            label = "PlotStyleTable" ;
			key="txt2";
        }
    }
    ok_cancel;
}

//------------------------------------------------------------------------------
// MyAlert1
//------------------------------------------------------------------------------
MyAlert1 : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : text {
    key = "Text1";
    label = "";//Message$ from lsp file
    width = 20.6;
    alignment = centered;
  }
  spacer;
  ok_only;
}//MyAlert1
//------------------------------------------------------------------------------
// MyAlert2
// Note: Added key "Text2" tile and changed widths to 30.6 for example.
//------------------------------------------------------------------------------
MyAlert2 : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : text {
    key = "Text1";
    label = "";//Message1$ from lsp file
    width = 30.6;
  }
  : text {
    key = "Text2";
    label = "";//Message2$ from lsp file
    width = 30.6;
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      label = "OK";
      width = 8.59;
      is_cancel = true;
    }
    : button {
      key = "Help";
      label = "Help";
      width = 8.59;
      fixed_width = true;
    }
  }
}//MyAlert2
//------------------------------------------------------------------------------
// MyBoldText
// Note: The widths were determined by the example and will need to be changed
// as per your requirements.
//------------------------------------------------------------------------------
MyBoldText : dialog {
  label = " My Bold Text";
  spacer;
  : text {
    key = "Text1";
    label = "";//Text1$ from lsp file
    width = 18;
    fixed_width_font = true;
  }
  : image {
    key = "ImageText2";//ImageText2$ from lsp file
    width = 24;
    height = 1.28;//Height is Ok per font
    fixed_width = true;
    fixed_height = true;
    aspect_ratio = 1;
    color = -15;//-15 is dialog color
  }
  spacer;
  ok_only;
}//MyBoldText
//------------------------------------------------------------------------------
// MyOkCancel
// Customize Ok Cancel buttons and group them together and specify their widths
//------------------------------------------------------------------------------
MyOkCancel : dialog {
  label = " My Ok Cancel";
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyOkCancel
//------------------------------------------------------------------------------
// MyYesNo
// Note: The width for the Text1 key was determined by the syntax example and
// will need to be changed as per your requirements. Also note that the buttons
// for Yes and No, the added fixed_width = true;.
//------------------------------------------------------------------------------
MyYesNo : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : text {
    key = "Text1";
    label = "";//Question$ from lsp file
    width = 35.0;
    alignment = centered;
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Yes";
      label = "&Yes";
      is_default = true;
      width = 7.92;
      fixed_width = true;
    }
    : button {
      key = "No";
      label = "&No";
      is_cancel = true;
      width = 7.92;
      fixed_width = true;
    }
  }
}//MyYesNo
//------------------------------------------------------------------------------
// MyNext
//------------------------------------------------------------------------------
MyNext : dialog {
  label = " My Next";
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Next";
      is_default = true;
      label = "&Next >";
      width = 11;
      fixed_width = true;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyNext
//------------------------------------------------------------------------------
// MyBack
//------------------------------------------------------------------------------
MyBack : dialog {
  label = " My Back";
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Back";
      is_default = true;
      label = "< &Back";
      width = 11;
      fixed_width = true;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyBack
//------------------------------------------------------------------------------
// MyEditText
//------------------------------------------------------------------------------
MyEditText : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {
    : column {
      width = 5.09;
      fixed_width = true;
      spacer;
      : text {
        key = "Prompt";
        label = "";//Prompt from lsp file
      }
    }
    : edit_box {
      key = "Edit1";//Edit1$ from lsp file
      edit_width = 26.42;
      fixed_width = true;
    }
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyEditText
//------------------------------------------------------------------------------
// MyEditBoxes
//------------------------------------------------------------------------------
MyEditBoxes : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : edit_box {
      key = "Edit1";//Edit1$ from lsp file
      edit_width = 9.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text2";
        label = "";//Text2$ from lsp file
      }
    }
    : edit_box {
      key = "Edit2";//Edit2$ from lsp file
      edit_width = 9.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text3";
        label = "";//Text3$ from lsp file
      }
    }
    : edit_box {
      key = "Edit3";//Edit3$ from lsp file
      edit_width = 9.42;
      fixed_width = true;
    }
  }//>
  spacer;
  ok_only;
}//MyEditBoxes
//------------------------------------------------------------------------------
// MyPopupLists
//------------------------------------------------------------------------------
MyPopupLists : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "List1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : popup_list {
      key = "List1";//Value1$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text2";
        label = "";//Text2$ from lsp file
      }
    }
    : popup_list {
      key = "List2";//Value2$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  spacer;
  ok_only;
}//MyPopupLists
//------------------------------------------------------------------------------
// MyOtherLists
//------------------------------------------------------------------------------
MyOtherLists : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "List1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : popup_list {
      key = "List1";//Value1$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text2";
        label = "";//Text2$ from lsp file
      }
    }
    : popup_list {
      key = "List2";//Value2$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text3";
        label = "";//Text3$ from lsp file
      }
    }
    : popup_list {
      key = "List3";//Value3$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  spacer;
  ok_only;
}//MyOtherLists
//------------------------------------------------------------------------------
// MyMultiLists
//------------------------------------------------------------------------------
MyMultiLists : dialog {
  key = "Title";
  label = "";
  : boxed_column {
    label = "Select an Item";
    : list_box {
      key = "List1";//Value1$ from lsp file
      height = 6.27;
      fixed_height = true;
      width = 32.92;
      fixed_width = true;
    }
    spacer;
  }
  : boxed_column {
    label = "Multi Select Items";
    : list_box {
      multiple_select = true;
      key = "List2";//Value2$ from lsp file
      height = 6.27;
      fixed_height = true;
      width = 32.92;
      fixed_width = true;
    }
    spacer;
  }
  spacer;
  ok_only;
}//MyMultiLists
//------------------------------------------------------------------------------
// MyRadios
//------------------------------------------------------------------------------
MyRadios : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : boxed_radio_row {
    key = "Radio1";
    label = "Paper Size";
    width = 34.26;
    fixed_width = true;
    : radio_button {
      key = "A";
      label = "A-Size";
    }
    : radio_button {
      key = "B";
      label = "B-Size";
    }
    : radio_button {
      key = "C";
      label = "C-Size";
    }
  }
  : boxed_radio_column {
    key = "Radio2";
    label = "Orientation";
    : radio_button {
      key = "P";
      label = "Portrait";
    }
    : radio_button {
      key = "L";
      label = "Landscape";
    }
  }
  spacer;
  ok_only;
}//MyRadios
//------------------------------------------------------------------------------
// MyToggles
//------------------------------------------------------------------------------
MyToggles : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : boxed_column {
    label = "Row of Toggles";
    width = 34.26;
    fixed_width = true;
    : row {
      : toggle {
        key = "Toggle1";
        label = "Toggle 1";
      }
      : toggle {
        key = "Toggle2";
        label = "Toggle 2";
      }
    }
    spacer;
  }
  : boxed_column {
    label = "Column of Toggles";
    width = 34.26;
    fixed_width = true;
    : toggle {
      key = "Toggle3";
      label = "Toggle 3";
    }
    : toggle {
      key = "Toggle4";
      label = "Toggle 4";
    }
    : toggle {
      key = "Toggle5";
      label = "Toggle 5";
    }
    spacer;
  }
  spacer;
  ok_only;
}//MyToggles
//------------------------------------------------------------------------------
// MyEdit_Lists
//------------------------------------------------------------------------------
MyEdit_Lists : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : edit_box {
      key = "Edit1";//Edit1$ from lsp file
      edit_width = 9.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text2";
        label = "";//Text2$ from lsp file
      }
    }
    : popup_list {
      key = "List2";//Value2$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Next";
      is_default = true;
      label = "&Next >";
      width = 11;
      fixed_width = true;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyEdit_Lists
//------------------------------------------------------------------------------
// MyList_Radios
//------------------------------------------------------------------------------
MyList_Radios : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : popup_list {
      key = "List1";//Value1$ from lsp file
      width = 11.42;
      fixed_width = true;
    }
  }//>
  spacer;
  : boxed_radio_row {
    key = "Radio2";
    label = "Favorite Paper Size";
    width = 34.26;
    fixed_width = true;
    : radio_button {
      key = "A";
      label = "A-Size";
    }
    : radio_button {
      key = "B";
      label = "B-Size";
    }
    : radio_button {
      key = "C";
      label = "C-Size";
    }
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Back";
      label = "< &Back";
      width = 11;
    }
    : button {
      key = "Next";
      is_default = true;
      label = "&Next >";
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyList_Radios
//------------------------------------------------------------------------------
// MyEdit_Toggles
//------------------------------------------------------------------------------
MyEdit_Toggles : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {//<
    fixed_width = true;
    : column {
      width = 24.76;
      fixed_width = true;
      spacer;
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
    }
    : edit_box {
      key = "Edit1";//Edit1$ from lsp file
      edit_width = 9.42;
      fixed_width = true;
    }
  }//>
  spacer;
  : boxed_column {
    label = "Favorite Software";
    width = 34.26;
    fixed_width = true;
    : row {
      : toggle {
        key = "Toggle2";
        label = "AutoCAD";
      }
      : toggle {
        key = "Toggle3";
        label = "Excel";
      }
    }
    spacer;
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : button {
      key = "Back";
      label = "< &Back";
      width = 11;
    }
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyEdit_Toggles
//------------------------------------------------------------------------------
// MyPickButton
//------------------------------------------------------------------------------
MyPickButton : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : row {
    : column {
      fixed_width = true;
      : row {
        : column {
          spacer;
          : image_button {
            key = "select_pick";
            width = 3.59;
            height = 1.66;
            fixed_width = true;
            fixed_height = true;
            aspect_ratio = 1;
            color = -15;
          }
          spacer;
        }
        : column {
          spacer;
          : text {
            key = "Prompt";
            label = "";
            width = 31.09;
            fixed_width = true;
            vertical_margin = none;
          }
          spacer;
        }
      }
    }
  }
  : boxed_column {
    label = "Object Information";
    width = 34.26;
    fixed_width = true;
    : paragraph {
      : text_part {
        key = "Text1";
        label = "";//Text1$ from lsp file
      }
      : text_part {
        key = "Text2";
        label = "";//Text2$ from lsp file
      }
      : text_part {
        key = "Text3";
        label = "";//Text3$ from lsp file
      }
    }
    spacer;
  }
  spacer;
  ok_only;
}//MyPickButton
//------------------------------------------------------------------------------
// MySlideImages
//------------------------------------------------------------------------------
MySlideImages : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : row {
    : image_button {
      key = "Slide1";
      width = 17.26;
      height = 5.28;
      aspect_ratio = 1;
      color = -2;
    }
    : image_button {
      key = "Slide2";
      width = 17.26;
      height = 5.28;
      aspect_ratio = 1;
      color = -2;
    }
  }
  : row {
    : column {
      : text {
        key = "Text1";
        label = "";//Text1$ from lsp file
        width = 17.26;
        fixed_width = true;
        alignment = centered;
      }
    }
    : column {
      : text {
        key = "Text2";
        label = "";//Text2$ from lsp file
        width = 17.26;
        fixed_width = true;
        alignment = centered;
      }
    }
  }
  : row {
    : image_button {
      key = "Slide3";
      width = 17.26;
      height = 5.28;
      aspect_ratio = 1;
      color = -2;
    }
    : image_button {
      key = "Slide4";
      width = 17.26;
      height = 5.28;
      aspect_ratio = 1;
      color = -2;
    }
  }
  : row {
    : column {
      : text {
        key = "Text3";
        label = "";//Text3$ from lsp file
        width = 17.26;
        fixed_width = true;
        alignment = centered;
      }
    }
    : column {
      : text {
        key = "Text4";
        label = "";//Text4$ from lsp file
        width = 17.26;
        fixed_width = true;
        alignment = centered;
      }
    }
  }
  ok_only;
}//MySlideImages
//------------------------------------------------------------------------------
// MyImageButton
//------------------------------------------------------------------------------
MyImageButton : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : image_button {
    key = "Image1";
    width = 35.92;
    height = 16.59;
    fixed_width = true;
    fixed_height = true;
    aspect_ratio = 1;
    color = -2;
  }
  : text {
    key = "Text1";
    label = "";//Text1$ from lsp file
    width = 23.42;
    fixed_width = true;
    alignment = centered;
  }
  ok_only;
}//MyImageButton
//------------------------------------------------------------------------------
// MySliders
//------------------------------------------------------------------------------
MySliders : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : row {
    : image {
      key = "ColorImage";
      width = 18.26;
      height = 8.43;
      fixed_width = true;
      fixed_height = true;
      aspect_ratio = 1;
    }
    : slider {
      layout = vertical;
      key = "SliderV";
      min_value = 1;
      max_value = 6;
      small_increment = 1;
      big_increment = 2;
      height = 8.43;
      fixed_height = true;
      is_tab_stop = false;
    }
  }
  : row {
    height = 1.97;
    : slider {
      key = "SliderH";
      min_value = 1;
      max_value = 6;
      small_increment = 1;
      big_increment = 2;
      width = 18.26;
      fixed_width = true;
      is_tab_stop = false;
    }
  }
  : paragraph {
    : text_part {
      key = "Text1";
      label = "";//Text1$ from lsp file
    }
    : text_part {
      key = "Text2";
      label = "";//Text2$ from lsp file
    }
    : text_part {
      key = "Text3";
      label = "";//Text3$ from lsp file
    }
  }
  ok_only;
}//MySliders
//------------------------------------------------------------------------------
// Start of MyDialogs Support Utility Dialogs
//------------------------------------------------------------------------------
// MyDialogsMenu - Menu designed for the tutorial to demo other dialogs
//------------------------------------------------------------------------------
MyDialogsMenu : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  : boxed_row {
    label = "Select Dialog Function";
    : column {
      width = 17.59;
      fixed_width = true;
      : list_box {
        key = "List1";//Item$ from lsp file
        height = 7.50;
        allow_accept = true;
      }
      spacer;
    }
    : column {
      width = 17.59;
      fixed_width = true;
      : list_box {
        key = "List2";//Item$ from lsp file
        height = 7.50;
        allow_accept = true;
      }
      spacer;
    }
    : column {
      width = 17.59;
      fixed_width = true;
      : list_box {
        key = "List3";//Item$ from lsp file
        height = 7.50;
        allow_accept = true;
      }
      spacer;
    }
  }
  : row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//MyDialogsMenu
//------------------------------------------------------------------------------
// DclCalcs - Dcl Calcs
//------------------------------------------------------------------------------
DclCalcs : dialog {
  key = "Title";
  label = "";//Dcl Calcs
  initial_focus = "Edit1";
  : boxed_column {
    label = "Images and Tiles";
    fixed_width = true;
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text1";
          label = "";//X Pixels
        }
      }
      : edit_box {
        key = "Edit1";//Edit1$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text2";
          label = "";//Width
        }
      }
      : edit_box {
        key = "Edit2";//Edit2$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text3";
          label = "";//Y Pixels
        }
      }
      : edit_box {
        key = "Edit3";//Edit3$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text4";
          label = "";//Height
        }
      }
      : edit_box {
        key = "Edit4";//Edit4$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    spacer;
  }
  : boxed_column {
    label = "Text and Tile Widths";
    fixed_width = true;
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text5";
          label = "";//Label Text
        }
      }
      : edit_box {
        key = "Edit5";//Edit5$ from lsp file
        edit_width = 23.59;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text6";
          label = "";//X PIxels
        }
      }
      : edit_box {
        key = "Edit6";//Edit6$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text7";
          label = "";//Pixels Width
        }
      }
      : edit_box {
        key = "Edit7";//Edit7$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text8";
          label = "";//Popup List
        }
      }
      : edit_box {
        key = "Edit8";//Edit8$ from lsp file
        edit_width = 17.42;
        fixed_width = true;
      }
      : column {
        spacer_0;
        : toggle {
          key = "Toggle9";
        }
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text10";
          label = "";//Text Column
        }
      }
      : edit_box {
        key = "Edit10";//Edit10$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text11";
          label = "";//Popup List
        }
      }
      : edit_box {
        key = "Edit11";//Edit11$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text12";
          label = "";//Edit Box
        }
      }
      : edit_box {
        key = "Edit12";//Edit12$ from lsp file
        edit_width = 17.42;
        fixed_width = true;
      }
      : column {
        spacer_0;
        : toggle {
          key = "Toggle13";
        }
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text14";
          label = "";//Text Column
        }
      }
      : edit_box {
        key = "Edit14";//Edit14$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text15";
          label = "";//Edit Box
        }
      }
      : edit_box {
        key = "Edit15";//Edit15$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    spacer;
  }
  : boxed_column {
    label = "List Box Tiles";
    fixed_width = true;
    : row {//<
      fixed_width = true;
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text16";
          label = "";//Lines
        }
      }
      : edit_box {
        key = "Edit16";//Edit16$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
      : column {
        width = 11.59;
        fixed_width = true;
        spacer;
        : text {
          key = "Text17";
          label = "";//Height
        }
      }
      : edit_box {
        key = "Edit17";//Edit17$ from lsp file
        edit_width = 4.26;
        fixed_width = true;
      }
    }//>
    spacer;
  }
  spacer;
  : row {//<
    fixed_width = true;
    alignment = centered;
    : column {
      spacer_0;
      : ok_button {
        is_cancel = true;
      }
      spacer_0;
    }
    : column {
      : image_button {
        key = "Calculator";
        width = 5.42;
        height = 2.51;
        fixed_width = true;
        fixed_height = true;
        aspect_ratio = 1;
        color = -15;
      }
    }
    : column {
      spacer_0;
      : button {
        key = "Info";
        label = "Info";
        width = 9.42;
        fixed_width = true;
      }
      spacer_0;
    }
  }//>
}//DclCalcs
//------------------------------------------------------------------------------
// DclCalcs_Info - Dcl Calcs Information
//------------------------------------------------------------------------------
DclCalcs_Info : dialog {
  key = "Title";
  label = "";
  spacer;
  : list_box {
    key = "List1";
    height = 25.97;
    fixed_height = true;
    width = 40.26;
    fixed_width = true;
  }
  ok_only;
}//DclCalcs_Info
//------------------------------------------------------------------------------
// ViewDcl - View Dcl Dialogs
//------------------------------------------------------------------------------
ViewDcl : dialog {
  key = "Title";
  label = "";
  : boxed_column {
    label = "Select Dialog to View";
    : list_box {
      key = "DialogList";
      height = 11.20;
      allow_accept = true;
    }
    spacer;
  }
  : row {
    : column {
      : ok_button {
        label = "View";
        alignment = right;
        width = 11.92;
      }
    }
    : column {
      : cancel_button {
        alignment = left;
        width = 11.92;
      }
    }
  }
}//ViewDcl
//------------------------------------------------------------------------------
// edit_value
//------------------------------------------------------------------------------
edit_value : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  initial_focus = "Edit1";
  spacer;
  : row {
    : column {
      width = 6.09;
      fixed_width = true;
      spacer;
      : text {
        key = "Value";
        label = "";//Value from lsp file
      }
    }
    : edit_box {
      key = "Edit1";//Edit1$ from lsp file
      edit_width = 15.26;
      fixed_width = true;
    }
  }
  spacer;
  : row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
  }
}//edit_value
//------------------------------------------------------------------------------
