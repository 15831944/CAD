/*°Ô°Ô°Ô°Ô°ÔListDCL @ fsxm.bokee.com°Ô°Ô°Ô°Ô°Ô*/
test2:dialog {
    label = "Test dialog No 2" ;
    :edit_box {
        alignment = centered ;
        edit_limit = 30 ;
        edit_width = 30 ;
        key = "name" ;
        label = "Enter your name:" ;
    }
    :edit_box {
        alignment = centered ;
        edit_limit = 3 ;
        edit_width = 3 ;
        key = "age" ;
        label = "Enter your age:" ;
    }
    :button {
        alignment = centered ;
        fixed_width = true ;
        is_default = true ;
        key = "accept" ;
        label = "ok" ;
    }
    errtile;
}
