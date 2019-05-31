dcl_settings : default_dcl_settings { audit_level = 3; }
//------------------------------------------------------------------------------
// Program Name: PlotDwgs.dcl [PlotDwgs R2]
// Created By:   Terry Miller (Email: terrycadd@yahoo.com)
//               (URL: http://web2.airmail.net/terrycad)
// Date Created: 10-20-03
// Function:     Dialogs for the Plot Drawings functions
//------------------------------------------------------------------------------
// Revision History
// Rev  By     Date    Description
//------------------------------------------------------------------------------
// 1    TM   10-20-03  Initial version
// 2    TM   5-20-07   Revised program to be easier to customize by creating the
//                     *PlotterInfo@ global list variable. Included plot folder
//                     and plot open drawings. Redesigned the dialogs and added
//                     additional features.
//------------------------------------------------------------------------------
// PlotDwgs - Dialog for Plotting Drawings and Layouts
//------------------------------------------------------------------------------
PlotDwgs : dialog {
  key = "Title";
  label = " Plot Drawings";
  spacer;
  : boxed_column {
    label = "Plot Information";
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text1";
            label = "";// Plot layouts
          }
        }
      }
      : popup_list {
        key = "Layouts";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text2";
            label = "";// Number of copies
          }
        }
      }
      : popup_list {
        key = "Copies";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text3";
            label = "";// Paper size
          }
        }
      }
      : popup_list {
        key = "PaperSizes";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text4";
            label = "";// Printer/Plotter
          }
        }
      }
      : popup_list {
        key = "Plotters";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text5";
            label = "";// Plot style
          }
        }
      }
      : popup_list {
        key = "PlotStyles";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : row {//<
      fixed_width = true;
      : column {
        width = 15.26;
        fixed_width = true;
        spacer;
        : column {
          : text {
            key = "Text6";
            label = "";// Drawings to plot
          }
        }
      }
      : popup_list {
        key = "Drawings";
        width = 24.09;
        fixed_width = true;
      }
    }//>
    : column {
      fixed_width = true;
      alignment = centered;
      height = 2.2;
      fixed_height = true;
      spacer_0;
      : row {
        fixed_width = true;
        alignment = centered;
        : spacer {
          width = 6.59;
        }
        : toggle {
          key = "Reverse";
          label = "Reverse order of layouts";
        }
      }
      spacer_0;
    }
  }
  : row {//<
    width = 31.26;
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : image {
      key = "iconimage";
      width = 5.42;
      height = 2.51;
      fixed_width = true;
      fixed_height = true;
      aspect_ratio = 1;
      color = -15;
    }
    : cancel_button {
      width = 11;
    }
  }//>
}// PlotDwgs
//------------------------------------------------------------------------------
// PlotFolderDwgs - Dialog for Selecting Drawings to Plot (reference version)
//------------------------------------------------------------------------------
PlotFolderDwgs : dialog {
  key = "Title";
  label = " Plot Folder of Drawings";
  spacer;
  : boxed_column {
    label = "Multi-select Drawings to plot";
    : text {
      key = "FolderName";
      label = "";
    }
    : list_box {
      multiple_select = true;
      key = "FolderDwgs";
      height = 11.20;// 11 list_box lines
      fixed_height = true;
      width = 39.42;
      fixed_width = true;
    }
    : column {
      fixed_width = true;
      alignment = centered;
      height = 1.97;
      fixed_height = true;
      spacer_0;
      : row {
        fixed_width = true;
        alignment = centered;
        : spacer {
          width = 3.09;
        }
        : toggle {
          key = "SelectAll";
          label = "Select all";
        }
        : toggle {
          key = "Reverse";
          label = "Reverse order";
        }
      }
      spacer_0;
    }
  }
  : row {//<
    width = 31.26;
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 11;
    }
    : image {
      key = "iconimage";
      width = 5.42;
      height = 2.51;
      fixed_width = true;
      fixed_height = true;
      aspect_ratio = 1;
      color = -15;
    }
    : cancel_button {
      width = 11;
    }
  }//>
}// PlotFolderDwgs
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
}// edit_value
//------------------------------------------------------------------------------