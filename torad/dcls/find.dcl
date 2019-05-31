

find : dialog {
   label = "查找与替换";
   : column {
      : edit_box {
         label = "查找:";
         key = "find";
         mnemonic = "F";
         edit_width = 30;
      }  
      : edit_box {
         label = "替换:";
         key = "replace";
         mnemonic = "R";
         edit_width = 30;
      }  
   }   
   spacer_1 ;
   : row {
      : toggle {
         label = "区分大小写";
         key = "case";
         mnemonic = "C";
         alignment = left;
      }   
      : toggle {
         label = "全部替换";
         key = "global";
         mnemonic = "G";
         alignment = right;
      }   
   }   
   spacer_1 ;
   : column {
      ok_cancel;
      errtile;
   }   
}
find2 : dialog {
   label = "查找与替换";
   : row {
      : button {
         label = "替换";
         fixed_width = true;
         alignment = centered;
         key = "accept";
         mnemonic = "R";
      }  
      : spacer { width = 2; }
      : button {
         label = " 自动  ";
         fixed_width = true;
         alignment = centered;
         key = "auto";
         mnemonic = "A";
      }  
      : spacer { width = 2; }
      : button {
         label = " 跳过  ";
         fixed_width = true;
         alignment = centered;
         key = "skip";
         mnemonic = "S";
      }  
      : spacer { width = 2; }
      cancel_button;
   }   
   errtile;
}
