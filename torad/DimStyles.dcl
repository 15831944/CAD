dcl_settings : default_dcl_settings { audit_level = 3; }
//------------------------------------------------------------------------------
// Program Name: DimStyles.dcl [DimStyles R3]
// Created By:   Terry Miller (Email: terrycadd@yahoo.com)
//               (URL: http://web2.airmail.net/terrycad)
// Date Created: 1-20-05
// Function:     Creates and sets Dimension Styles for Linear, Angular, Diameter,
//               Ordinate and Radial styles. DimStyles.lsp may be easily 
//               customized by editing the SetDimVars function and in the 
//               "Exceptions to SetDimVars" areas.
// Note:         Edit the lines ending with "<--Change to your Dim layer info"
//               as required.  DimStyles requires functions inside of GetIcon.lsp
//               and Dcl_Tiles.lsp.  Also change your LTSCALE back to 0.375 or 
//               your default setting when plotting layouts.
//------------------------------------------------------------------------------
// Revision History
// Rev  By     Date    Description
//------------------------------------------------------------------------------
// 1    TM   1-20-05   Initial version
// 2    TM   3-20-05   Revised to include the dimscales of other Dim Styles.
// 3    TM   7-20-05   Revised dialog to include Architectural scales.  Also
//                     added c:DD, dim diameter, and c:DR, dim radius functions.
//------------------------------------------------------------------------------
// DimStyles - Dimension Styles
//------------------------------------------------------------------------------
DimStyles : dialog {
  key = "title";
  initial_focus = "Text";
  label = "";
  key = "Title";// Dimension Styles
  spacer;
  : row {//<
    width = 25.09;
    fixed_width = true;
    : column {
      width = 12.26;
      fixed_width = true;
      spacer;
      : column {
        : text {
          key = "Text001";
          label = "001";// Dim Scale
          alignment = left;
        }
      }
    }
    : popup_list {
      key = "ListReal001";
      width = 11.42;
      fixed_width = true;
    }
  }//>
  : row {//<
    width = 24.76;
    fixed_width = true;
    : column {
      width = 12.42;
      fixed_width = true;
      spacer;
      : column {
        : text {
          key = "Text002";
          label = "002";// Arch Scale
          alignment = left;
        }
      }
    }
    : edit_box {
      key = "Edit002";
      edit_width = 8.92;
      fixed_width = true;
    }
  }//>
  : row {//<
    width = 24.76;
    fixed_width = true;
    : column {
      width = 12.42;
      fixed_width = true;
      spacer;
      : column {
        : text {
          key = "Text003";
          label = "003";// Text Height
          alignment = left;
        }
      }
    }
    : edit_box {
      key = "Edit003";
      edit_width = 8.92;
      fixed_width = true;
    }
  }//>
  : row {//<
    width = 24.76;
    fixed_width = true;
    : column {
      width = 12.42;
      fixed_width = true;
      spacer;
      : column {
        : text {
          key = "Text004";
          label = "004";// Zoom Scale
          alignment = left;
        }
      }
    }
    : edit_box {
      key = "Edit004";
      edit_width = 8.92;
      fixed_width = true;
    }
  }//>
  : spacer { height = 0.2; }
  : row {
    : column {
      : ok_button {
        alignment = right;
        width = 11;
      }
    }
    : column {
      : cancel_button {
        alignment = left;
        width = 11;
      }
    }
  }
}
//------------------------------------------------------------------------------