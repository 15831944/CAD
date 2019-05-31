// Next available MSG number is    23 
// MODULE_ID DOSHELP_DCL_
// $Header: //depot/acad/develop/global/src/coreacad/support/doshelp.dcl#1 $ $Change: 1 $ $DateTime: 2005/01/05 09:51:24 $ $Author: integrat $
// $NoKeywords: $
//
//  doshelp.dcl - Proteus dialog file for AUtoCAD Platform-Independent Help
//
//     Copyright (C) 1991-1994,1997 by Autodesk, Inc.
//
//     Permission to use, copy, modify, and distribute this software
//     for any purpose and without fee is hereby granted, provided
//     that the above copyright notice appears in all copies and
//     that both that copyright notice and the limited warranty and
//     restricted rights notice below appear in all supporting
//     documentation.
//
//     AUTODESK PROVIDES THIS PROGRAM "AS IS" AND WITH ALL FAULTS.
//     AUTODESK SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF
//     MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTODESK, INC.
//     DOES NOT WARRANT THAT THE OPERATION OF THE PROGRAM WILL BE
//     UNINTERRUPTED OR ERROR FREE.
//
//     Use, duplication, or disclosure by the U.S. Government is subject to
//     restrictions set forth in FAR 52.227-19 (Commercial Computer
//     Software - Restricted Rights) and DFAR 252.227-7013(c)(1)(ii)
//     (Rights in Technical Data and Computer Software), as applicable.
//
//.
//////////////////////////////////////////////////////
// Special client tiles in this file:
// main dialog has:
// - hlp_typesetting_width = xx;
//      Max number of characters on a line for word wrap.
// help button has:
// - help_on_help_filename="helphelp.ahp";
//      Name of the file containing help on help.
// - help_on_help_label="Help on AutoCAD Help";
//      Caption (label) of Help on Help dialog.

topic_box : list_box {
    width = 73;
    height = 16;
    tabs = "3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54";
    fixed_width = true;
    fixed_width_font = true;
}

title_box : list_box {
    width = 50;
    fixed_width = true;
}

hlp_main : dialog {
    key = "hlp_main";
    label = "AutoCAD 帮助";
    initial_focus = "hlp_text";
    hlp_typesetting_width = 61;
    : row {
        : button {
            key = "hlp_contents_btn";
            label = "帮助主题(&C)";
       	    }
        : button {
            key = "hlp_search_btn";
            label = "搜索(&S)";
        }
        : button {
            key = "hlp_back_btn";
            label = "后退(&B)";
            is_enabled = false;    //only unil the first topic is chosen
         }
        : button {
            key = "hlp_hist_btn";
            label = "历史记录(&H)";
        }
        spacer;
        : button {
            key="hlp_help_btn";
            label = "帮助(&E)";
            help_on_help_filename="helphelp.ahp";
            help_on_help_label="如何使用 AutoCAD 帮助";
        }
    }
    : topic_box {
        key = "hlp_text";
        max_lines = 1000;         // Max lines per help item
	}
	: row {
	 : paragraph {
	   : concatenation {
            : text {
                key = "hlp_main_nextlbl";
	    	label = "选择主题: ";
		width = /*DOSHELP_GLOB_1*/14;
		fixed_width = true;
                is_enabled = false;
		}
	    : text {
                key = "hlp_main_nextedit";
	    	value = "";
                width = 30;
                is_enabled = false;
                }
	   }
	 }
            : button {
                key = "hlp_main_nextbtn";
                label = "下一主题(&N)";
                is_enabled = false;
                }
            : button {
                key = "hlp_main_gotobtn";
                label = "转到(&G)";
                is_enabled = false;
                }
            }
        ok_only;
    }
hlp_search : dialog {
    label = "AutoCAD 帮助搜索";
    initial_focus = "hlp_srch_keyword_list";
    : column {
        : row {
            : column {
                : text {
                    label = "输入或从列表中选择词语。";
                }
                : text {
                    label = "然后选择“显示主题”。";
                }
            }
            : button : cancel_button {
                key = "hlp_srch_close";
                label = "关闭"; 
            }
        }
        : row {
            :edit_box {
                alignment = bottom;
                key = "hlp_srch_keyword";
                edit_width = 30;
            }
            : button {
                key = "hlp_srch_show";
                label = "显示主题(&S)";
            }
        }
        : title_box {
            height = 7;
            key = "hlp_srch_keyword_list";
        }
        spacer;
        : row {
            : text {
                label = "选择主题, 然后选择“转到”。";
            }
            : button : ok_button {
                key = "hlp_srch_goto";
                label = "转到(&G)";
                is_enabled = false;
            }
        }
        :title_box {
            height = 7;
            key = "hlp_srch_goto_list";
        }
    }
}

hlp_history : dialog {
    label = "AutoCAD 帮助历史记录";
    initial_focus = "hlp_historylst";
    : title_box {
        height = 12;
        key = "hlp_historylst";
        max_lines = 100; 
    }
    : row {
        : button : ok_button {
            key = "hlp_hist_goto";
            label = "转到(&G)";
        }
        : button : cancel_button {
            key = "hlp_hist_close";
            label = "关闭"; 
        }
    }
}

hlp_popup : dialog {
    label = "其他 AutoCAD 帮助";
    : topic_box {
        key = "hlp_popup_text";
        max_lines = 100; 
    }
    : button : ok_button {
        key = "hlp_popup_close";
        label = "关闭"; 
    }
}