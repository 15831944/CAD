/*★★★★★ListDCL @ fsxm.bokee.com★★★★★*/

b2p:dialog {
    key = "title" ;
    label = "批量打印" ;
    :spacer {
    }
    :row {
        :popup_list {
            key = "pop1" ;
        }
        :text {
            label = "选择打印笔" ;
        }
    }
    :button {
        is_default = true ;
        key = "bt1" ;
        label = "确认" ;
    }
}
