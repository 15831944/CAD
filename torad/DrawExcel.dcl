dcl_settings : default_dcl_settings { audit_level = 3; }
//------------------------------------------------------------------------------
// Program Name: DrawExcel.dcl [Draw Excel R4]
// Created By:   Terry Miller (Email: terrycadd@yahoo.com)
//               (URL: http://web2.airmail.net/terrycad)
// Date Created: 9-20-03
// Note:         DrawExcel.lsp is designed to draw basic spreadsheets without
//               merged cells. Adjust the range for the Starting and Ending cells
//               to not include merged cells. Headings and Titles can later be
//               added in AutoCAD. Save the Excel spreadsheet in the view that
//               you want to draw. Then close Excel. DrawExcel requires functions
//               inside of GetIcon.lsp. The associated files are DrawExcel.lsp
//               and DrawExcel.dcl.
//------------------------------------------------------------------------------
// Revision History
// Rev  By     Date    Description
//------------------------------------------------------------------------------
// 1    TM   9-20-03   Initial version. Created GetExcel function.
// 2    TM   5-20-04   Added DrawExcel to draw an Excel spread sheet.
// 3    TM   3-20-06   Revised program and rewrote DrawExcel with new dialogs.
// 4    TM   8-20-07   Rewrote GetExcel and added several new functions including
//                     Alpha2Number and Number2Alpha by Gilles Chanteau from
//                     Marseille, France.
//------------------------------------------------------------------------------
// DrawExcel - Dialog to Draw an Excel spreadsheet in AutoCAD
//------------------------------------------------------------------------------
DrawExcel : dialog {
  key = "Title";
  label = "";
  spacer;
  : column {
    : column {//< Layer for Lines
      fixed_width = true;
      : row {
        : column {
          width = 14.76;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text001";
              label = "001";//Layer for Lines
              alignment = left;
            }
          }
        }
        : image {
          key = "Image101";
          width = 2.42;
          aspect_ratio = 1;
          color = 8;
        }
        : popup_list {
          key = "List001";
          width = 18.59;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Layer for Text
      fixed_width = true;
      : row {
        : column {
          width = 14.76;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text002";
              label = "002";//Layer for Text
              alignment = left;
            }
          }
        }
        : image {
          key = "Image102";
          width = 2.42;
          aspect_ratio = 1;
          color = 8;
        }
        : popup_list {
          key = "List002";
          width = 18.59;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Text Style & Font
      fixed_width = true;
      : row {
        : column {
          width = 18.59;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text003";
              label = "003";//Text Style & Font
              alignment = left;
            }
          }
        }
        : popup_list {
          key = "List003";
          width = 18.59;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Text Justification
      fixed_width = true;
      : row {
        : column {
          width = 18.59;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text004";
              label = "004";//Text Justification
              alignment = left;
            }
          }
        }
        : popup_list {
          key = "List004";
          width = 18.59;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Text Height & Row Height
      fixed_width = true;
      : row {
        : column {
          width = 11.42;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text005";
              label = "005";//Text Height
              alignment = left;
            }
          }
        }
        : edit_box {
          key = "EditReal005";
          edit_width = 4.26;
          fixed_width = true;
        }
        : column {
          width = 11.42;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text006";
              label = "006";//Row Height
              alignment = left;
            }
          }
        }
        : edit_box {
          key = "EditReal006";
          edit_width = 4.26;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Starting Cell & Ending Cell
      fixed_width = true;
      : row {
        : column {
          width = 11.42;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text007";
              label = "007";//Starting Cell
              alignment = left;
            }
          }
        }
        : edit_box {
          key = "EditCaps007";
          edit_width = 4.26;
          fixed_width = true;
        }
        : column {
          width = 11.42;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text008";
              label = "008";//Ending Cell
              alignment = left;
            }
          }
        }
        : edit_box {
          key = "EditCaps008";
          edit_width = 4.26;
          fixed_width = true;
        }
      }
    }//>
    : column {//< Excel Filename & Browse
      fixed_width = true;
      : row {
        : column {
          width = 13.09;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text009";
              label = "009";//Excel Filename
              alignment = left;
            }
          }
        }
        : spacer {
          width = 13.26;
          fixed_width = true;
        }
        : column {
          width = 7.09;
          fixed_width = true;
          spacer;
          : column {
            : text {
              key = "Text010";
              label = "010";//Browse
              alignment = left;
            }
          }
        }
        : column {
          spacer;
          : toggle {
            key = "Toggle010";
          }
        }
      }
    }//>
    : column {//< Excel Filename
      fixed_width = true;
      : row {
        : edit_box {
          key = "Edit009";
          label = "";
          edit_width = 34.92;
          fixed_width = true;
        }
      }
    }//>
  }
  spacer;
  : row {
    alignment = centered;
    fixed_width = true;
    : ok_button {
      width = 11;
    }
    : cancel_button {
      width = 11;
    }
    : button {
      key = "Info";
      label = "Info";
      width = 11;
      fixed_width = true;
    }
  }
}// DrawExcel
//------------------------------------------------------------------------------