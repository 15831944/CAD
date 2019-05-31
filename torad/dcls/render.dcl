// Next available MSG number is   485 
// MODULE_ID RENDER_DCL_

//     Copyright (C) 1991-1997 by Autodesk, Inc.
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

//***************************************************************************
//
// Render Dialogue Control Language (DCL)
//
//***************************************************************************

// Change level to 3 for new DCL auditing.
dcl_settings : default_dcl_settings { }

@include "rendcomm.dcl"

//***************************************************************************
//

// Sub-assemblies common to the render and preferences dialog

render_quality : popup_list {
    label = "渲染类型(R):";
    key = "pf_st";
    mnemonic = "R";
    list = "一般渲染\n照片级真实感渲染\n照片级光线跟踪渲染";
    render_types = "crender\nautovis\nraytrace";
    edit_width = 20;
    fixed_width = true;
}

render_query : toggle {
    key = "pf_rp";
    label = "查询选择集(Q)";
    mnemonic = "Q";
}

render_crop : toggle {
    key = "pf_cropwin";
    label = "修剪窗口(W)";
    mnemonic = "W";
}

render_procedure : column {
    : boxed_column {
        label = "渲染过程";
        render_query;
        render_crop;
        : toggle {
            key =  "pf_sd";
            //  FIXME
            label = "跳过渲染对话框(K)";
            mnemonic = "K";
        }
    }
    : edit_box_4 {
        label = "光源图标比例(L):";
        key = "pf_ic_tx";
        mnemonic = "L";
    }
    : edit_box_4 {
        label = "平滑角度(G):";
        key = "pf_sa";
        mnemonic = "G";
    }
}

render_options : boxed_column {
    label = "渲染选项";
    : toggle {
        key = "pf_ss";
        label = "平滑着色(M)";
        mnemonic = "M";
    }
    : toggle {
        key = "pf_af";
        label = "应用材质(A)";
        mnemonic = "A";
    }
    : toggle {
        key = "pf_sh";
        label = "阴影(D)";
        mnemonic = "D";
    }
    : toggle {
        key = "pf_ca";
        label = "渲染高速缓存(C)";
        mnemonic = "C";
    }
    : button {
        key = "Options";
        label = "其他选项(O)...";
        mnemonic = "O";
    }
}

sub_sample : boxed_column {
    label = "子样例(U)";
    mnemonic = "U";
    : popup_list {
        key = "pf_subs";
        mnemonic = "U";
        list = "1:1（最佳）\n2:1\n3:1\n4:1\n5:1\n6:1\n7:1\n8:1 （最快）";
        subsample_types = "1\n2\n3\n4\n5\n6\n7\n8";
        edit_width = 15;
    }
}

render_env : column {
    sub_sample;
    : button {
        key = "pf_env_back";
        label = "背景(B)...";
        mnemonic = "B";
    }
    : button {
        key = "pf_env_fog";
        label = "雾化/深度设置(F)...";
        mnemonic = "F";
    }
}

render_destination : boxed_column {
    label = "目标(N)";
    mnemonic = "N";
    : popup_list {
        key = "pf_ds";
        list = "视口\n渲染窗口\n文件";
        mnemonic = "N";

    }
    spacer;
    : column {
        : var_text {
            key = "pf_width";
            alignment = left;
            label = "   宽度    :  640";
        }
        : var_text {
            key = "pf_height";
            alignment = left;
            label = "   高度    :  480";
        }
        : var_text {
            key = "pf_colors";
            alignment = left;
            label = "   颜色      :  8位";
        }
    }
    spacer;
    : button {
        key = "FOptions";
        label = "其他选项(P)...";
        mnemonic = "P";
    }
}

pref : dialog {
    label = "渲染系统配置";
    render_quality;
    spacer_1;
    : row {
        render_scene_list;
        render_procedure;
    }
    spacer_1;
    : row {
        render_options;
        render_destination;
        render_env;
    }
    spacer_1_ok_cancel_help_errtile;
}


render : dialog {
    label = "渲染";
    render_quality;
    spacer_1;
    : row {
        render_scene_list;
        render_procedure;
    }
    spacer_1;
    : row {
        render_options;
        render_destination;
        render_env;
    }
    spacer_1;
    : row {
        fixed_width = true;
        alignment = centered;
        : button {
            key = "pf_re_scene";
            label = "渲染";
            is_default = true;
        }
        : spacer { width = 2; }
        cancel_button;
        : spacer { width = 2; }
        help_button;
    }
    errtile;
}

//**************************************************************************
// Rendering Options

rp_alias_mode : boxed_radio_column {
    label = "反走样";
    key = "rpaliasmode";
    fixed_height = true;
    : radio_button {
        key = "ahnv";
        label = "最小(I)";
        mnemonic = "I";
    }
    : radio_button {
        key = "ahsv";
        label = "低(&O)";
    }
    : radio_button {
        key = "ahsv3";
        label = "中(&E)";
    }
    : radio_button {
        key = "ahsv4";
        label = "高(&G)";
    }
}

rp_adaptive_toggle : toggle {
    label = "启用(E)";
    key = "adaptive_enable";
    mnemonic = "E";
}

rp_ray_adaptive : boxed_column {
    key = "adapt_samp_box";
    label = "自适应采样";
    fixed_height = true;
    rp_adaptive_toggle;
    : edit_box_6 {
        label = "对比阈值(C): ";
        key = "contrast_threshold";
        mnemonic = "C";
    }

}


rp_raydepth_mode : boxed_column {
    label = "光线树深度";
    fixed_height = true;
    : edit_box_4 {
        label = "最大深度(D): ";
        key = "ray_depth";
        mnemonic = "D";
    }
    : edit_box_6 {
        label = "截断阈值(T):";
        key = "ray_threshold";
        mnemonic = "T";
    }
}


rp_shadow_mode : boxed_column {
    label = "深度贴图阴影控制";
    key = "rpshadowmode";
    : edit_box_8  {
        key = "minbias";
        label = "最小偏移(B): ";
        mnemonic = "B";
    }
    : edit_box_8  {
        key = "maxbias";
        label = "最大偏移(X): ";
        mnemonic = "X";
    }
}

rp_texmap_mode : boxed_radio_column {
    label = "贴图采样";
    key = "rptexmapmode";
    : radio_button  {
        key = "txpoint";
        label = "点采样(P)";
        mnemonic = "P";
    }
    : radio_button  {
        key = "txlinterp";
        label = "线性采样(L)";
        mnemonic = "L";
    }
    : radio_button  {
        key = "txmip";
        label = "Mip 贴图采样(M)";
        mnemonic = "M";
    }
}

scanline_options : dialog {
    label = "照片级真实感渲染选项";
    spacer_1;
    : row {
        : column {
            fixed_height = true;
            alignment = top;
            rp_alias_mode;
        }
        spacer_1;
        : column {
            fixed_height = true;
            alignment = top;
            other_options;
            spacer;
            rp_shadow_mode;
            spacer;
            spacer;
            rp_texmap_mode;
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

raytrace_options : dialog {
    label = "照片级光线跟踪渲染选项";
    spacer_1;
    : row {
        : column {
            rp_alias_mode;
            rp_ray_adaptive;
            rp_raydepth_mode;
        }
        spacer_1;
        : column {
            other_options;
            spacer;
            rp_shadow_mode;
            spacer;
            spacer;
            rp_texmap_mode;
        }
    }
    spacer_1_ok_cancel_help_errtile;
}


//**************************************************************************
// Statistics dialog box

avis_stats : dialog {
    label = "统计信息";
    width = 50;
    : list_box { 
        key = "stats_list";
        height = 16;
        tabs = "24";
    }
    : row {
        alignment = centered;
        fixed_width = true;
        width = 39;
        : toggle {
            label = "将统计信息保存到文件(S): ";
            mnemonic = "S";
            key = "save_stats";
            height = 1;
        }
        : edit_box {
            label = "";
            key = "stats_name";
            edit_width = 14;
            edit_limit = 132;
        }
        : button {
            label = "查找文件(F)...";
            mnemonic = "F";
            key = "findfile";
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

//***************************************************************************
// Main light dialog.

avis_light : dialog {                       // identical to ave_light, plus North Location button
    label = "光源";
    key = "dialog";
    dialog_kind = "main";
    : row {
        : column {
            : row {
                : list_box_8x8 {
                    key = "list";
                    label = "光源(L): ";
                    mnemonic = "L";
                }
                : column {
                    spacer_0;
                    button_mod;
                    button_del;
                    button_pkt;
                    spacer_0;
                }
            }
            : row {
                button_new;
                : popup_list { 
                    key = "light_type_popup";
                    edit_width = 15;
                    mnemonic = "T";
                    list = "点光源\n平行光\n聚光灯";
                    light_types = "overhead\ndirect\nsh_spot";
                }
            }
            : button {
                key = "northloc";
                label = "北方位置(O)...";
                mnemonic = "O";
                fixed_width = true;
                alignment = centered;
            }
        }
        spacer;
        : column {
            children_alignment = centered;
            : boxed_column {
                label = "环境光";
                : edit_box_4 {
                    label = "强度(I): ";
                    key = "ambient_t";
                    mnemonic = "I";
                }
                : slider_0_1 { key = "ambient_s"; }
                : boxed_column {
                    label = "颜色";
                    rgb_edit_slider;
                    light_color_panel;
                }
            }
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

//***************************************************************************
// Dialog to edit the currently selected Point light definition.

avis_point_light : dialog {
    key = "dialog";
    dialog_kind = "point";
    : row {
        ave_basic_lights;
        : column {
            alignment = top;
            fixed_height = true;
            attenuation_panel;
            shadow_panel;
            spacer_0;
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

//***************************************************************************
// Dialog to edit the currently selected Spot light definition.

avis_spotlight : dialog {
    key = "dialog";
    dialog_kind = "spot";
    : row {
        ave_basic_lights;
        : column {
            alignment = top;
            fixed_height = true;
            ave_spot_lights;
            attenuation_panel;
            shadow_panel;
            spacer_0;
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

//***************************************************************************
// Dialog to edit distant lights (sun).

avis_distant_light : dialog {
    key = "dialog";
    dialog_kind = "distant";
    : row {
        : column {
            distant_light_parameters_panel;
            shadow_panel;
            : button {
                key = "sa_calc";
                label = "太阳角度计算器(S)...";
                mnemonic = "S";
                fixed_width = true;
                alignment = centered;
            }
        }
        : column {
            azimuth_altitude_panel;
            light_source_panel;
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

sun_angle_calculator_panel : column {
    : boxed_column {
        : row {
        : column {
                : edit_box {
                    label = "日期(D):      ";
                    key = "date_edit";
                    mnemonic = "D";
                    edit_width = 6;
                    edit_limit = 6;
                }
                : edit_box {
                    label = "时钟时间(C):";
                    key = "time_edit";
                    mnemonic = "C";
                    edit_width = 6;
                    edit_limit = 6;
                }
                : popup_list { 
                    key = "timezone_popup";
                    list = "PST:8\nMST:7\nCST:6\nEST:5\nNewfoundland:4\nYukon:9";
                }
                : edit_box {
                    label = "纬度(L):  ";
                    key = "latitude_edit";
                    mnemonic = "L";
                    edit_width = 6;
                    edit_limit = 6;
                }
                : edit_box {
                    label = "经度(O): ";
                    key = "longitude_edit";
                    mnemonic = "O";
                    edit_width = 6;
                    edit_limit = 6;
                }
        }
        : column {
                : slider {
                    key = "date_slider";
                    min_value = 1;
                    max_value = 365;
                    small_increment = 1;
                    big_increment = 31;
                    width = 10;
                }
                : slider {
                    key = "time_slider";
                    min_value = 0;
                    max_value = 1440;
                    small_increment = 10;
                    big_increment = 60;
                    width = 10;
                }
                : toggle {
                    label = "夏令时(S)";
                    key = "daylight_toggle";
                    mnemonic = "S";
                }
                : slider {
                    key = "latitude_slider";
                    min_value = 0;
                    max_value = 90;
                    small_increment = 1;
                    big_increment = 10;
                    width = 10;
                }
                : slider {
                    key = "longitude_slider";
                    min_value = 0;
                    max_value = 180;
                    small_increment = 1;
                    big_increment = 10;
                    width = 10;
                }
        }
        }
        : row {
            : popup_list { 
                key = "latitude_popup";
                list = "北\n南";
            }
            : popup_list { 
                key = "longitude_popup";
                list = "西\n东";
            }
        }
        : button {
            alignment = centered;
            fixed_width = true;
            key = "location_button";
            label = "地理位置(G)...";
            mnemonic = "G";
        }
    }
}
        

azimuth_altitude_panel_write_only : boxed_column {
    : row {
        : column {
            : row {
                : text {
                    label = "方位角:";
                }
                : text {
                    label = "      ";
                    key = "azimuth_t";
                    width = 6;
                }
            }
            : image_button {
                key = "azimuth_image";
                color = dialog_background;
                height = 7;
                aspect_ratio = 1;
                fixed_height = true;
                fixed_width = true;
                alignment = centered;
                is_enabled = false;
            }
        }
        : column {
            : row {
                : text {
                    label = "仰角:";
                }
                : text {
                    label = "      ";
                    key = "altitude_t";
                    width = 6;
                }
            }
            : image_button {
                key = "altitude_image";
                color = dialog_background;
                height = 7;
                aspect_ratio = 1;
                fixed_height = true;
                fixed_width = true;
                alignment = centered;
                is_enabled = false;
            }
        }
    }
    : row {
        : text {
            label = "太阳时间:";
        }
        : text {
            label = "     ";
            key = "solar_time";
        }
    }
}

ave_sun_angle_calc : dialog {
    label = "太阳角度计算器";
    initial_focus = "accept";
    : row {
        sun_angle_calculator_panel;
        azimuth_altitude_panel_write_only;
    }
    spacer_1_ok_cancel_help_errtile;
}

shadow_panel : boxed_column {
    label = "阴影:";
    : toggle {
        alignment = left;
        label = "阴影打开(W)";
        key = "shadow_on";
        mnemonic = "W";
    }
    : button {
        key = "shadow_dialog";
        label = "阴影选项(P)...";
        mnemonic = "P";
        fixed_width = true;
    }
}


//***************************************************************************
// Tile used only by Spotlights.

ave_spot_lights : column {
    fixed_height = true;
    : edit_box_8 {
        label = "聚光角(T):";
        key = "conea_t";
        mnemonic = "T";
    }
    : slider {
        key = "conea_s";
        min_value = 0;
        max_value = 160;
        small_increment = 1;
        big_increment = 10;
    }
    : edit_box_8 {
        label = "照射角(F):";
        key = "coned_t";
        mnemonic = "F";
    }
    : slider {
        key = "coned_s";
        min_value = 0;
        max_value = 160;
        small_increment = 1;
        big_increment = 10;
    }
}

//***************************************************************************
// geographic location dialog

ave_geographic_location : dialog {
    key = "dialog";
    initial_focus = "accept";
    label = "地理位置";
    : column { 
        key = "top_key";
        : row {
            : column {
                fixed_width = true;
                : list_box {
                    key = "cities";
                    height = 8;
                    width = 21;
                    label = "城市(C):";
                    mnemonic = "C";
                }
                : boxed_column {
                    : text {
                        label = " ";
                        key = "city";
                        width = 21;
                    }
                    : edit_box_8 {
                        label = "纬度(A): ";
                        value = "0.";
                        edit_width = 8;
                        key = "latitude";
                        mnemonic = "A";
                    }
                    : edit_box_8 {
                        label = "经度(O): ";
                        value = "0.";
                        edit_width = 8;
                        key = "longitude";
                        mnemonic = "O";
                    }
                    spacer_0;
                }
            }
            : boxed_column {
                : row {
                    : popup_list { 
                        key = "map_name";
                        list = 
"北美\n加拿大\n欧洲\n南美\n亚洲\n澳大利亚\n亚洲次大陆\n非洲";
                        files = 
"namer.map\ncanada.map\neurope.map\nsamer.map\nasia.map\naust.map\nindia.map\nafrica.map";
                        width = 18;
                    }
                    : toggle {
                        label = "最近的大城市(N)";
                        value = "1";
                        key = "nearest";
                        mnemonic = "N";
                    }
                }
                : image_button {
                    key = "map_image";
                    color = -15;             /* background color */
                    height = 15;
                    aspect_ratio = 1.5;
                }
            }
        }
//      spacer_1_ok_cancel_help_errtile;
        ok_cancel_help_errtile;
    }
}

northLocator : dialog {
    label = "北方位置";
    spacer;
    spacer;
    : row {
        : boxed_column {
            label = "X/Y 平面:";
            fixed_width = true;
            : image_button {
                key = "northImage";
                color = dialog_background;             /* background color */
                width = 20;
                aspect_ratio = 1;
//              is_enabled = true;
                fixed_width = true;
            }
            : column {
                : edit_box {
                    label = "角度(A):";
                    key = "northEdit";
                    mnemonic = "A";
                    edit_width = 6;
                    edit_limit = 6;
                }
                : slider {
                    key = "northSlider";
                    min_value = 0;
                    max_value = 360;
                    small_increment = 1;
                    big_increment = 10;
                    width = 20;
                }
            }
        }
        : list_box {
            width = 20;
            fixed_width = true;
            key = "useUCS";
            label = "使用 UCS(U):";
            mnemonic = "U";
//          list = "阴影柔和度(O):";
        }
    }
    ok_cancel_help_errtile;
}

shadowMapOptions : dialog {
    label = "阴影选项";
    spacer;
    spacer;
    : toggle {
        label = "阴影大小/光线跟踪的阴影(S)";
        key = "shadowVolumes";
        mnemonic = "S";
    }
    : popup_list { 
        key = "shadowMapSize";
        fixed_width = true;
        label = "阴影贴图尺寸(M)";
        list = "64\n128\n256\n512\n1024\n2048\n4096";
    mnemonic = "M";
    }
    : row {
        : edit_box {
            label = "阴影柔和度(O):";
            edit_width = 6;
            edit_limit = 6;
            key = "beamd_t";
            mnemonic = "O";
        }
        : slider {
            key = "beamd_s";
            min_value = 1;
            max_value = 10;
            small_increment = 1;
            big_increment = 2;
            width = 20;
        }
    }
    : button {
        key = "pick";
        label = "阴影约束对象(B) <";
        alignment = centered;
        fixed_width = true;
        width = 3;
        mnemonic = "B";
    }
    spacer;
    spacer;
    ok_cancel_help_errtile;
}

ave_make_map : dialog {
    key = "dialog";
    label = "生成贴图";
    : row {
        : column {
            : edit_box_8 {
                label = "经度(X): ";
                value = "-99.";
                key = "longitude";
                mnemonic = "X";
            }
            : edit_box_8 {
                label = "纬度(Y): ";
                value = "38.";
                key = "latitude";
                mnemonic = "Y";
            }
            : edit_box_8 {
                label = "宽度（度）(S): ";
                value = "70.";
                key = "width";
                mnemonic = "S";
            }
            : edit_box_8 {
                label = "分类(R): ";
                value = "1";
                key = "rank";
                mnemonic = "R";
            }
            : edit_box_8 {
                label = "文件(F): ";
                value = "bdy.cbd";
                key = "file";
                mnemonic = "F";
            }
            : edit_box {
                label = "路径(T): ";
                value = "/files1/map/namer.map/";
//              value = "e:\\map\\namer.map\\";
                edit_width = 16;
                edit_limit = 30;
                key = "path";
                mnemonic = "T";
            }
            : edit_box {
                label = "输出(O): ";
                value = "namer.map";
                edit_width = 12;
                edit_limit = 12;
                key = "save";
                mnemonic = "O";
            }
            : row {
                : button {
                    key = "plot_button";
                    label = "打印(P)";
                    mnemonic = "P";
                    fixed_width = true;
                }
                : button {
                    key = "header_button";
                    label = "表头(H)";
                    mnemonic = "H";
                    fixed_width = true;
                }
                : button {
                    key = "save_button";
                    label = "保存(S)";
                    mnemonic = "S";
                    fixed_width = true;
                }
                : button {
                    key = "erase_button";
                    label = "删除(E)";
                    mnemonic = "E";
                    fixed_width = true;
                }
            }
        }
        : boxed_column {
            : image_button {
                key = "map_image";
                color = -15;             /* background color */
                height = 13;
                aspect_ratio = 1.5;
            }
        }
    }
    spacer_1_ok_cancel_help_errtile;
}

//***************************************************************************
//Materials list dialog

avis_list : dialog {
    label = "材质库";
    : column { 
        key = "top_key";
        spacer_1;
        : row {
            material_column;
            : column {
                avis_mat_preview;
                spacer_0;
                import_export_delete;
                spacer_0;
            }
            library_column;
        }
        spacer_0_5;
        ok_cancel_help_custom;
    }
}


//***************************************************************************
// Main material dialog


ave_material : dialog {
  label = "材质";
  : column { 
    key = "top_key";
    : row {
        material_list;
        avis_material_preview_and_select;
        : column {
            width = 18;
            spacer_0;
            button_mod;
            button_dup;
            : boxed_column {
                button_new;
                : popup_list { 
                    key = "template";
                    list = "标准\n花岗石\n大理石\n木材";
                }
            }
            spacer_1;
            material_attach;
        }
    }
    spacer_1_ok_cancel_help_errtile;
  }
}


avis_material_preview_and_select : column {
    avis_mat_preview;
    spacer_0_5;
    button_imp;
    button_pkt;
    spacer_0_5;
}


//
// Dialogs to edit a minimal, standard, granite, marble, or wood material.
//

ave_standard_material_mod : dialog {
  key = "dialog";
  : column { 
    key = "top_key";
    material_name;
    : row {
        standard_attributes;
        standard_value_color_bitmap_preview;
    }
    spacer_0_1_ok_cancel_help_errtile;
  }
}


ave_granite_material_mod : dialog {
  key = "dialog";
  : column { 
    key = "top_key";
    material_name;
    : row {
        granite_attributes;
        template_value_color_bitmap_preview;
    }
    spacer_0_1_ok_cancel_help_errtile;
  }
}


ave_marble_material_mod : dialog {
  key = "dialog";
  : column { 
    key = "top_key";
    material_name;
    : row {
        marble_attributes;
        template_value_color_bitmap_preview;
    }
    spacer_0_1_ok_cancel_help_errtile;
  }
}


ave_wood_material_mod : dialog {
  key = "dialog";
  : column { 
    key = "top_key";
    material_name;
    : row {
        wood_attributes;
        template_value_color_bitmap_preview;
    }
    spacer_0_1_ok_cancel_help_errtile;
  }
}


standard_attributes : boxed_column {
    label = "属性";
    : row {
        : radio_column {
            key = "attribute";
            alignment = top;
            : radio_button {
                label = "颜色/图案(C)";
                key = "diffuse";
                mnemonic = "C";
            }
            : radio_button {
                label = "环境(A)";
                key = "ambient";
                mnemonic = "A";
            }
            : radio_button {
                label = "反射(E)";
                key = "reflection";
                mnemonic = "E";
            }
            : radio_button {
                label = "粗糙度(O)";
                key = "roughness";
                mnemonic = "O";
            }
            : radio_button {
                label = "透明度(T)";
                key = "transparency";
                mnemonic = "T";
            }
            : radio_button {
                label = "折射(N)";
                key = "refraction";
                mnemonic = "N";
            }
            : radio_button {
                label = "凹凸贴图(U)";
                key = "bump";
                mnemonic = "U";
            }
        }
        : column {
            : avis_sample_image { key = "sample_0"; }
            : avis_sample_image { key = "sample_1"; }
            : avis_sample_image { key = "sample_2"; }
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
        }
    }
}


granite_attributes : boxed_column {
    label = "属性";
    : row {
        : radio_column {
            alignment = top;
            key = "attribute";
            : radio_button {
                label = "第一个颜色(C)";
                key = "first_color";
                mnemonic = "C";
            }
            : radio_button {
                label = "第二个颜色(N)";
                key = "second_color";
                mnemonic = "N";
            }
            : radio_button {
                label = "第三个颜色(T)";
                key = "third_color";
                mnemonic = "T";
            }
            : radio_button {
                label = "第四个颜色(F)";
                key = "fourth_color";
                mnemonic = "F";
            }
            : radio_button {
                label = "反射(E)";
                key = "reflection";
                mnemonic = "E";
            }
            : radio_button {
                label = "粗糙度(O)";
                key = "roughness";
                mnemonic = "O";
            }
            : radio_button {
                label = "尖锐度(R)";
                key = "sharpness";
                mnemonic = "R";
            }
            : radio_button {
                label = "比例(S)";
                key = "scale";
                mnemonic = "S";
            }
            : radio_button {
                label = "凹凸贴图(U)";
                key = "bump";
                mnemonic = "U";
            }
        }
        : column {
            : avis_sample_image { key = "sample_0"; }
            : avis_sample_image { key = "sample_1"; }
            : avis_sample_image { key = "sample_2"; }
            : avis_sample_image { key = "sample_3"; }
            : avis_sample_image { key = "sample_4"; }
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
        }
    }
}


marble_attributes : boxed_column {
    label = "属性";
    : row {
        : radio_column {
            alignment = top;
            key = "attribute";
            : radio_button {
                label = "石质颜色(C)";
                key = "stone_color";
                mnemonic = "C";
            }
            : radio_button {
                label = "纹理颜色(N)";
                key = "vein_color";
                mnemonic = "N";
            }
            : radio_button {
                label = "反射(E)";
                key = "reflection";
                mnemonic = "E";
            }
            : radio_button {
                label = "粗糙度(O)";
                key = "roughness";
                mnemonic = "O";
            }
            : radio_button {
                label = "扰动(T)";
                key = "turbulence";
                mnemonic = "T";
            }
            : radio_button {
                label = "尖锐度(R)";
                key = "sharpness";
                mnemonic = "R";
            }
            : radio_button {
                label = "比例(S)";
                key = "scale";
                mnemonic = "S";
            }
            : radio_button {
                label = "凹凸贴图(U)";
                key = "bump";
                mnemonic = "U";
            }
        }
        : column {
            : avis_sample_image { key = "sample_0"; }
            : avis_sample_image { key = "sample_1"; }
            : avis_sample_image { key = "sample_2"; }
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
        }
    }
}


wood_attributes : boxed_column {
    label = "属性";
    : row {
        : radio_column {
            alignment = top;
            key = "attribute";
            : radio_button {
                label = "浅色(C)";
                key = "light_color";
                mnemonic = "C";
            }
            : radio_button {
                label = "深色(K)";
                key = "dark_color";
                mnemonic = "K";
            }
            : radio_button {
                label = "反射(E)";
                key = "reflection";
                mnemonic = "E";
            }
            : radio_button {
                label = "粗糙度(O)";
                key = "roughness";
                mnemonic = "O";
            }
            : radio_button {
                label = "浅/深(T)";
                key = "light_dark_ratio";
                mnemonic = "T";
            }
            : radio_button {
                label = "年轮密度(N)";
                key = "ring_density";
                mnemonic = "N";
            }
            : radio_button {
                label = "年轮宽度(H)";
                key = "ring_width";
                mnemonic = "H";
            }
            : radio_button {
                label = "年轮形状(A)";
                key = "ring_shape";
                mnemonic = "A";
            }
            : radio_button {
                label = "比例(S)";
                key = "scale";
                mnemonic = "S";
            }
            : radio_button {
                label = "凹凸贴图(U)";
                key = "bump";
                mnemonic = "U";
            }
        }
        : column {
            : avis_sample_image { key = "sample_0"; }
            : avis_sample_image { key = "sample_1"; }
            : avis_sample_image { key = "sample_2"; }
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
            spacer_1_25;
        }
    }
}


avis_sample_image : image {
    color = -15;
    height = 1.25;
    aspect_ratio = 1;
    fixed_height = true;
    fixed_width = true;
    is_tab_stop = false;
}


standard_value_color_bitmap_preview : column {
    : row {
        : column {
            value_edit_slider;
            standard_color_widget;
        }
        avis_mat_preview;
    }
    spacer_0_1;
    bitmap_widget;
}


template_value_color_bitmap_preview : column {
    : row {
        : column {
            value_edit_slider;
            template_color_widget;
        }
        avis_mat_preview;
    }
    spacer_0_1;
    bitmap_widget;
}


standard_color_widget : boxed_column {
    label = "颜色";
    : row {
        : toggle {
            label = "随 ACI(Y)";
            key = "by_aci";
            mnemonic = "Y";
        }
        lock; 
        raytrace_mirror_toggle;
    }
    avis_variable_color_model;
}


template_color_widget : boxed_column {
    label = "颜色";
    : row {
        : toggle {
            label = "随 ACI(Y)";
            key = "by_aci";
            mnemonic = "Y";
        }
        raytrace_mirror_toggle;
    }
    avis_variable_color_model;
}


avis_variable_color_model : row { 
    : column {
        : row {
            : column {
                : text {
                    key = "top_text";
                    width = 10;
                    value = "红:";
                }
                : text {
                    key = "middle_text";
                    width = 10;
                    value = "绿:";
                }
                : text {
                    key = "bottom_text";
                    width = 10;
                    value = "蓝:";
                }
            }
            : column {
                : edit_box_4 {
                    label = "";
                    key = "top_edit";
                } 
                : edit_box_4 {
                    label = "";
                    key = "middle_edit";
                } 
                : edit_box_4 {
                    label = "";
                    key = "bottom_edit";
                }
            }
            : column {
                : slider_0_1_fixed { key = "top_slider"; }
                : slider_0_1_fixed { key = "middle_slider"; }
                : slider_0_1_fixed { key = "bottom_slider"; }
            }
        }
        : row {
            color_system;
            : image_button {
                key = "set_color_image";
                color = -15;             /* background color */
                height = 1;
                aspect_ratio = 1;
            }
        }
    }
}


raytrace_mirror_toggle : toggle {
    label = "镜像(O)";
    key = "raytrace_mirror";
    mnemonic = "O";
}


bitmap_widget : row {
    : column {
        : row {
            : edit_box_4 {
                label = "位图合成(D):";
                key = "blend_edit";
                mnemonic = "D";
                fixed_width = true;
            } 
            : slider_0_1 { 
                key = "blend_slider"; 
                width = 16;
            }
        }
        : edit_box {
            label = "文件名(L):";
            key = "bitmap_edit";
            mnemonic = "L";
        }
    }
    : column {
        fixed_width = true;
        : button {
            label = "调整位图(J)...";
            key = "adjust_map";
            mnemonic = "J";
            fixed_width = true;
        }
        : button {
            label = "查找文件(I)...";
            key = "find_bitmap";
            mnemonic = "I";
        }
    }
}



//
// Material attach by ACI dialogue.
//

avis_material_aci : dialog {
  label = "根据 AutoCAD 颜色索引附着";
  : column {
    key = "top_key";
    : row {
        : list_box {
            key = "list";
            label = "选择材质(M):";
            mnemonic = "M";
            width = 18;
        }
        : column {
            avis_mat_preview;
            : button {
                label = "附着(T) ->";
                key = "attach";
                mnemonic = "T";
            }
            : button {
                label = "拆离(D)";
                key = "detach";
                mnemonic = "D";
            }
        }
        : list_box {
            key = "index";
            label = "选择 ACI(A):";
            mnemonic = "A";
            width = 31;
            tabs = "4 12";
            multiple_select = true;
        }
    }
    spacer_1_ok_cancel_help_errtile;
  }
}



//
// Material attach by layer dialogue.
//

avis_material_layer : dialog {
  label = "根据图层附着";
  : column {
    key = "top_key";
    : row {
        : list_box {
            key = "list";
            label = "选择材质(M):";
            mnemonic = "M";
            width = 18;
        }
        : column {
            avis_mat_preview;
            : button {
                label = "附着(T) ->";
                key = "attach";
                mnemonic = "T";
            }
            : button {
                label = "拆离(D)";
                key = "detach";
                mnemonic = "D";
            }
        }
        : list_box {
            key = "layer";
            label = "选择图层(L):";
            mnemonic = "L";
            width = 38;
            tabs = "22";
            multiple_select = true;
        }
    }
    spacer_1_ok_cancel_help_errtile;
  }
}



avis_mat_preview : boxed_column {
    children_alignment = centered;
    : image_button {
        key = "image";
        color = graphics_background;
        height = 8;
        aspect_ratio = 1;
        fixed_height = true;
        fixed_width = true;
        is_tab_stop = false;
    }
    : button {
        key = "object";
        label = "预览(P)";
        mnemonic = "P";
    }
    : popup_list {
        key = "geometry";
//        list = "调整位图(B)...";
        list = "球体\n立方体";
    }
    spacer_0;
}

avis_mat_preview_LBitmap : boxed_column {
    children_alignment = centered;
    : image_button {
        key = "image";
        color = graphics_background;
        height = 8;
        aspect_ratio = 1;
        fixed_height = true;
        fixed_width = true;
        is_tab_stop = false;
    }
    : button {
        key = "object";
        label = "预览(P)";
        mnemonic = "P";
    }
    : edit_box {
            label = "对象大小:";
            key   = "fixedScalingPreviewSize";
            value = "1";
            edit_limit = 8;
    }
    : popup_list {
        key = "geometry";
        list = "球体\n立方体";
    }
    spacer_0;
}

//***************************************************************************
//
// Morderd UV mapper dialog
//
//***************************************************************************
//***************************************************************************
//
//***************************************************************************
OffsetArea : boxed_column {
    label = "偏移与旋转";
    : row {
        : edit_box {
            label = "X 偏移(&O):";
            key   = "Xoff";
            value = "0";
            edit_limit = 8;
        }
        : edit_box {
            label = "Y 偏移(&O):";
            key   = "Yoff";
            value = "0";
            edit_limit = 8;
        }
    }
    : row {
        : edit_box {
            label = "旋转(&R):  ";
            key   = "Rot";
            value = "0";
            edit_limit = 5;
        }
        : slider {
            key             = "RotSl";
            min_value       = -180;
            max_value       = 180;
            small_increment = 1;
            big_increment   = 10;
            value = "0";
            is_tab_stop = false;
        }
    }
}


//***************************************************************************
//
//***************************************************************************
PickAdjustGroup : row {
    : button {
        label = "调整位图(B)...";
        mnemonic = "B";
        key   = "AdjMap";
    }
    spacer_1;
    : button {
        label = "拾取点(I) <";
        mnemonic = "I";
        key   = "PickPts";
    }
}

//***************************************************************************
//
//
//***************************************************************************
uv : dialog {
  label = "贴图";
  : column { 
    key = "top_key";
    : row {
        : column {
            : boxed_radio_column {
                label = "投影";
                key   = "MapTypes";
                : radio_button {
                    label = "平面(L)";
                    mnemonic = "L";
                    key   = "Pl";
                }
                : radio_button {
                    label = "柱坐标(C)";
                    mnemonic = "C";
                    key   = "Cyl";
                }
                : radio_button {
                    label = "球坐标(S)";
                    mnemonic = "S";
                    key   = "Sph";
                }
                : radio_button {
                    label = "实体(O)";
                    mnemonic = "O";
                    key   = "Sol";
                }
            }

            spacer_1;

            : button {
                label = "调整坐标(A)...";
                mnemonic = "A";
                key   = "AdjCoor";
            }

            spacer_1;

            : button {
                label = "取自(F) <";
                mnemonic = "F";
                key   = "Acquire";
            }
            : button {
                label = "复制到(T) <";
                mnemonic = "T";
                key   = "Copy";
            }
        }

        : spacer { width = 5; }

        finish_preview;
    }
    spacer_1_ok_cancel_help_errtile;
  }
}





//***************************************************************************
//
//***************************************************************************
AdjustPlanar : dialog {
  label = "调整平面坐标";
  : column { 
    key = "top_key";
    : column {
        : row {
            children_alignment = top;
            : boxed_radio_column {
                label = "平行面";
                key   = "Orient";
                : radio_button {
                    label = "WCS XY 平面(X)";
                    mnemonic = "X";
                    key   = "WCS_Z";
                }
                : radio_button {
                    label = "WCS XZ 平面(Z)";
                    mnemonic = "Z";
                    key   = "WCS_Y";
                }
                : radio_button {
                    label = "WCS YZ 平面(Y)";
                    mnemonic = "Y";
                    key   = "WCS_X";
                }
                : radio_button {
                    label = "拾取的平面(A)";
                    mnemonic = "A";
                    key   = "UCS_Z";
                }
            }
            spacer_1;
            : column {
                : boxed_column {
                    label = "中心点位置";
                    fixed_height = true;
                    : row {
                        fixed_width = true;
                        : column {
                            fixed_height = true;
                            : image_button {
                                key = "CenterImage";
                                color = graphics_background;
                                height = 8;
                                aspect_ratio = 1;
                                fixed_width = true;
                                fixed_height = true;
                                is_tab_stop = false;
                            }
                            : slider {
                                key = "XSlide";
                                min_value = 0;
                                max_value = 10000;
                                is_tab_stop = false;
                            }
                        }
                        : slider {
                            layout = vertical;
                            key = "YSlide";
                            min_value = 0;
                            max_value = 10000;
                            is_tab_stop = false;
                        }
                    }
                }
            }

            spacer_1;

            finish_preview;
        }

        PickAdjustGroup;

        OffsetArea;
    }

    spacer_1_ok_cancel_help_errtile;
  }
}




//***************************************************************************
//
//***************************************************************************
AdjustCyl : dialog {
  label = "调整柱坐标";
  : column { 
    key = "top_key";
    : column {
        : row {
            children_alignment = top;
            : boxed_radio_column {
                label = "平行轴";
                key   = "Orient";
                : radio_button {
                    label = "WCS Z 轴";
                    mnemonic = "Z";
                    key   = "WCS_Z";
                }
                : radio_button {
                    label = "WCS Y 轴";
                    mnemonic = "Y";
                    key   = "WCS_Y";
                }
                : radio_button {
                    label = "WCS X 轴";
                    mnemonic = "X";
                    key   = "WCS_X";
                }
                : radio_button {
                    label = "拾取的轴(A)";
                    mnemonic = "A";
                    key   = "UCS_Z";
                }
            }
            spacer_1;
            : column {
                : boxed_column {
                    label = "中心轴位置";
                    fixed_height = true;
                    : row {
                        fixed_width = true;
                        : column {
                            fixed_height = true;
                            : image_button {
                                key = "CenterImage";
                                color = graphics_background;
                                height = 8;
                                aspect_ratio = 1;
                                fixed_width = true;
                                fixed_height = true;
                                is_tab_stop = false;
                            }
                            : slider {
                                key = "XSlide";
                                min_value = 0;
                                max_value = 10000;
                                is_tab_stop = false;
                            }
                        }
                        : slider {
                            layout = vertical;
                            key = "YSlide";
                            min_value = 0;
                            max_value = 10000;
                            is_tab_stop = false;
                        }
                    }
                }
            }

            spacer_1;

            finish_preview;
        }

        PickAdjustGroup;

        OffsetArea;
    }
    spacer_1_ok_cancel_help_errtile;
  }
}




//***************************************************************************
//
//***************************************************************************
AdjustSph : dialog {
    label = "调整球坐标";
  : column { 
    key = "top_key";
    : column {
        : row {
            children_alignment = top;
            : boxed_radio_column {
                label = "平行轴";
                key   = "Orient";
                : radio_button {
                    label = "WCS Z 轴";
                    mnemonic = "Z";
                    key   = "WCS_Z";
                }
                : radio_button {
                    label = "WCS Y 轴";
                    mnemonic = "Y";
                    key   = "WCS_Y";
                }
                : radio_button {
                    label = "WCS X 轴";
                    mnemonic = "X";
                    key   = "WCS_X";
                }
                : radio_button {
                    label = "拾取的轴(A)";
                    mnemonic = "A";
                    key   = "UCS_Z";
                }
            }
            spacer_1;
            : column {
                : boxed_column {
                    label = "极轴位置";
                    fixed_height = true;
                    : row {
                        fixed_width = true;
                        : column {
                            fixed_height = true;
                            : image_button {
                                key = "CenterImage";
                                color = graphics_background;
                                height = 8;
                                aspect_ratio = 1;
                                fixed_width = true;
                                fixed_height = true;
                                is_tab_stop = false;
                            }
                            : slider {
                                key = "XSlide";
                                min_value = 0;
                                max_value = 10000;
                                is_tab_stop = false;
                            }
                        }
                        : slider {
                            layout = vertical;
                            key = "YSlide";
                            min_value = 0;
                            max_value = 10000;
                            is_tab_stop = false;
                        }
                    }
                }
            }

            spacer_1;

            finish_preview;
        }

        PickAdjustGroup;

        OffsetArea;
    }
    spacer_1_ok_cancel_help_errtile;
  }
}




//***************************************************************************
//
//***************************************************************************

BitMapAdjustE : column {
    : row {
        bitmap_image;
        finish_preview;
    } /* end of row */
    offset_scale;
} /* end column */

BitMapAdjustL : column {
    : row {
        bitmap_image;
        avis_mat_preview_LBitmap;
    } /* end of row */
    offset_scale;
} /* end column */

bitmap_image : boxed_column {
    label = "偏移";
    fixed_height = true;
    : row {
        children_alignment = top;
        fixed_width = true;
        : boxed_column {
            fixed_height = true;
            label = "比例";
            : slider {
        key = "X_SIZE";
        min_value = 0;
        max_value = 102;
        is_tab_stop = false;
            }
            : row {
        fixed_width = true;
        : slider {
            layout = vertical;
            key = "Y_SIZE";
            fixed_width = true;
            min_value = 0;
            max_value = 102;
            is_tab_stop = false;
        }
        : image {
            key   = "BitImage";
            color = graphics_background;
            height = 8;
            aspect_ratio = 1;
            fixed_width = true;
            fixed_height = true;
            is_tab_stop = false;
        }
            } /* end row */
        }
        : column {
            : slider {
        layout = vertical;
        key = "Y_OFFSET";
        min_value = 0;
        max_value = 10000;
        is_tab_stop = false;
            }
        }
    } /* end of row */
    : row {
        : slider {
            key = "X_OFFSET";
            min_value = 0;
            max_value = 10000;
            is_tab_stop = false;
        }
    } /* end of row */
} /* end column */


offset_scale : column {
    : row {
        : column {
            : text {
                label = "偏移:";
            }
            : text {
                label = "比例:";
            }
        }
        : column {
            : edit_box {
                key   = "OU";
                edit_limit = 8;
            }
            : edit_box {
                key   = "SU";
                edit_limit = 8;
            }
        }
        : column {
            : text {
                label = "U";
            }
            : text {
                label = "U";
            }
        }
        : column {
            : edit_box {
                key   = "OV";
                edit_limit = 8;
            }
            : edit_box {
                key   = "SV";
                edit_limit = 8;
            }
        }
            : column {
            : text {
                label = "V";
            }
            : text {
                label = "V";
            }
        }
    } /* end row */

    : toggle {
        key   = "Aspect";
        label = "保持宽高比(&M)";
    }
} /* end column */


//***************************************************************************
//
//***************************************************************************
AdjustEBitmap : dialog {
  label = "调整对象位图位置";
  : column { 
    key = "top_key";

    : row {
        BitMapAdjustE;

        : column {
            : boxed_radio_column {
                key   = "Tiling";
                label = "排列方式";
                spacer_1;
                spacer_1;
                : radio_button {
                    key   = "T_DEF";
                    label = "默认(&D)";
                }
                : radio_button {
                    key   = "T_TILE";
                    label = "平铺(&T)";
                }
                : radio_button {
                    key   = "T_CROP";
                    label = "修剪(&C)";
                }
                spacer_1;
                spacer_1;
            }
            spacer;
        }
    }
    ok_cancel_help_errtile;
  }
}

//***************************************************************************
//
//***************************************************************************
AdjustLBitmap : dialog {
  label = "调整材质位图位置";
  : column { 
    key = "top_key";

    : row {
        BitMapAdjustL;

        : column {
            : boxed_radio_column {
                spacer_1;
                spacer_1;
                key   = "Tiling";
                label = "排列方式";
                : radio_button {
                    key   = "T_TILE";
                    label = "平铺(&T)";
                }
                : radio_button {
                    key   = "T_CROP";
                    label = "修剪(&C)";
                }
                spacer_1;
                spacer_1;
            }
            : boxed_radio_column {
                key   = "MaterialMapping";
                label = "贴图样式";
                spacer_1;
                : radio_button {
                    key   = "FixedScaling";
                    label = "固定比例(&F)";
                }
                : radio_button {
                    key   = "FitToEntity";
                    label = "按对象缩放(&O)";
                }
                spacer_1;
            }
            : toggle {
                key = "AutoAxis";
                label = "使用自动轴(&A)";
            }
            spacer_1;
            spacer_1;
        }
    }
    ok_cancel_help_errtile;
  }
}

//***************************************************************************
//
//***************************************************************************
AdjustRST : dialog {
  label = "调整 UVW 坐标";
  : column { 
    key = "top_key";
    : row {
        : column {
            : row {
                : edit_box {
                    label = "U 比例(&U):";
                    key   = "RS";
                    value = "1.0";
                    edit_limit = 10;
                }
                : slider {
                    key = "R_SLIDE";
                    min_value = 0;
                    max_value = 100;
                    width = 15;
                    is_tab_stop = false;
                }
            }
            : row {
                : edit_box {
                    label = "V 比例(&V):";
                    key   = "SS";
                    value = "1.0";
                    edit_limit = 10;
                }
                : slider {
                    key = "S_SLIDE";
                    min_value = 0;
                    max_value = 100;
                    width = 15;
                    is_tab_stop = false;
                }
            }
            : row {
                : edit_box {
                    label = "W 比例(&W):";
                    key   = "TS";
                    value = "1.0";
                    edit_limit = 10;
                }
                : slider {
                    key = "T_SLIDE";
                    min_value = 0;
                    max_value = 100;
                    width = 15;
                    is_tab_stop = false;
                }
            }
            : row {
                : button {
                    label = "拾取点(I) <";
                    mnemonic = "I";
                    key   = "Pick4Pts";
                }
                : toggle {
                    key   = "ARatio";
                    label = "保持宽高比(&M)";
                }
            }
        }

        finish_preview;

    }
 
    spacer_1_ok_cancel_help_errtile;
  }
}

//***************************************************************************
// Support for Background image dialog
//***************************************************************************
background : dialog {
    label = "背景";
    : row { 
        key = "top_key";
        : column {
            : radio_row {
                key = "bg_type";
                : radio_button {
                    key = "solid";
                    label = "纯色(S)";
                    mnemonic = "S";
                }
                : radio_button {
                    key = "gradient";
                    label = "渐变色(G)";
                    mnemonic = "G";
                }
                : radio_button {
                    key = "image";
                    label = "图像(A)";
                    mnemonic = "A";
                }
                : radio_button {
                    key = "merge";
                    label = "合并(M)";
                    mnemonic = "M";
                }
            }
            : row {
                : boxed_column {
                    key = "top_colors";
                    label = "颜色";
                    : row {
                        : column {
                            : row {
                                : column {
                                    : text {
                                        key = "color1_txt";
                                        label = "上";
                                    }
                                    spacer;
                                    : text {
                                        key = "color2_txt";
                                        label = "中";
                                    }
                                    spacer;
                                    : text {
                                        key = "color3_txt";
                                        label = "下";
                                    }
                                } /* column */
                                spacer;
                                : column {
                                    alignment = top;
                                    : image_button {
                                        key = "color1";
                                        color = graphics_background;
                                        fixed_width = true;
                                        aspect_ratio = 1;
                                        width = 2;
                                    }
                                    spacer;
                                    : image_button {
                                        key = "color2";
                                        color = graphics_background;
                                        fixed_width = true;
                                        aspect_ratio = 1;
                                        width = 2;
                                    }
                                    spacer;
                                    : image_button {
                                        key = "color3";
                                        color = graphics_background;
                                        fixed_width = true;
                                        aspect_ratio = 1;
                                        width = 2;
                                    }
                                } /* column */
                            } /* row */
                        } /* column */
                        spacer;
                        : column {
                            color_system;
                            color_system_set;
                        } /* column */
                    } /* row */
                    : column {
                        : row {
                            : toggle {
                                key = "use_acad";
                                label = "AutoCAD 背景(X)";
                                mnemonic = "X";
                            }
                            : button {
                               label = "选择颜色(C)";
                               key = "set_color";
                               fixed_width = true;
                               mnemonic = "C";
                            }
                        }
                    }
                } /* Color row */
                : boxed_column {
                    key = "top_preview";
                    children_alignment = centered;
                    : image_button {
                        key = "preview_img";
                        color = graphics_background;
                        width = 12;
                        height = 6;
                        fixed_height = true;
                        fixed_width = true;
                        is_tab_stop = false;
                    }
                    : button {
                        key = "bg_p_button";
                        label = "预览(P)";
                        mnemonic = "P";
                    }
                    spacer_0;
                }
            } /* row */
            : row {
                : boxed_column {
                    key = "top_image";
                    label = "图像";
                    : edit_box {
                        label = "名称(N):";
                        key = "bg_filename";
                        edit_width = 12;
                        mnemonic = "N";
                    }
                    : button {
                        label = "查找文件(F)...";
                        key = "bg_find_bitmap";
                        mnemonic = "F";
                    }
                    : button {
                        label = "调整位图(B)...";
                        key = "adjust_map";
                        mnemonic = "B";
                    }
                }
                : boxed_column {
                    key = "top_ray";
                    label = "环境";
                    : edit_box {
                        label = "名称(N):";
                        key = "env_filename";
                        edit_width = 12;
                        mnemonic = "N";
                    }
                    : button {
                        label = "查找文件(I)...";
                        key = "env_find_bitmap";
                        mnemonic = "I";
                    }
                    : toggle {
                        label = "使用背景(U)";
                        key = "lock_env_to_bg";
                        mnemonic = "U";
                    }
                }
                : boxed_column {
                    key = "top_sliders";
                    : row {
                        : column {
                            : edit_box_4 {
                                label = "水平(H):";
                                key = "horizon_edt";
                                min_value = 0;
                                max_value = 100;
                                value = "0.5";
                                mnemonic = "H";
                            }
                            : edit_box_4 {
                                label = "高度(E):";
                                key = "height_edt";
                                min_value = 0;
                                max_value = 100;
                                value = "0.5";
                                mnemonic = "E";
                            }
                            : edit_box_4 {
                                label = "旋转(R):";
                                key = "angle_edt";
                                value = "90";
                                mnemonic = "R";
                            }
                        } /* edit column */
                        : column {
                            : slider {
                                key = "horizon_sld";
                                min_value = 0;
                                max_value = 100;
                                value = "50";
                                width = 14;
                                is_tab_stop = false;
                            }
                            : slider {
                                key = "height_sld";
                                min_value = 0;
                                max_value = 100;
                                value = "33";
                                width = 14;
                                is_tab_stop = false;
                            }
                            : slider {
                                key = "angle_sld";
                                min_value = -90;
                                max_value = 90;
                                value = "0";
                                width = 14;
                                is_tab_stop = false;
                            }
                        } /* slider column */
                   } /* row */
                } /* boxed column */
            } /* bottom row */
        ok_cancel_help_errtile;
        }
    }
}


//***************************************************************************
// Support for adjusting the Background image
//***************************************************************************

AdjustBGBitmap : dialog {
  label = "调整背景位图位置";
  : column { 
    key = "top_key";
    : column {
        : row {
            : boxed_column {
                key = "Offset_box";
                label = "偏移";
                fixed_height = true;
                : row {
                    children_alignment = top;
                    fixed_width = true;
                    : boxed_column {
                        fixed_height = true;
                        label = "比例";
                        : slider {
                            key = "X_SIZE";
                            min_value = 0;
                            max_value = 102;
                            is_tab_stop = false;
                        }
                        : row {
                            fixed_width = true;
                            : slider {
                                layout = vertical;
                                key = "Y_SIZE";
                                fixed_width = true;
                                min_value = 0;
                                max_value = 102;
                                is_tab_stop = false;
                            }
                            : image {
                                key   = "BitImage";
                                color = graphics_background;
                                height = 8;
                                aspect_ratio = 1;
                                fixed_width = true;
                                fixed_height = true;
                                is_tab_stop = false;
                            }
                        } /* end row */
                    }
                    : column {
                        : slider {
                            layout = vertical;
                            key = "Y_OFFSET";
                            min_value = 0;
                            max_value = 10000;
                            is_tab_stop = false;
                        }
                    }
                } /* end of row */
                : row {
                    : slider {
                        key = "X_OFFSET";
                        min_value = 0;
                        max_value = 10000;
                        is_tab_stop = false;
                    }
                } /* end of row */
            } /* end column */
    
            : column {
                : toggle {
                    label = "布满屏幕(F)";
                    mnemonic = "F";
                    key = "fit_to_screen";
                    value = "1";
                }
    
                : toggle {
                    key   = "BGAspect";
                    label = "使用图像宽高比(U)";
                    mnemonic = "U";
                }
    
                spacer_1;
                : boxed_radio_column {
                    alignment = centered;
                    key   = "Tiling";
                    label = "排列方式";
                    : radio_button {
                        key   = "T_TILE";
                        label = "平铺(T)";
                        mnemonic = "T";
                    }
                    : radio_button {
                        key   = "T_CROP";
                        label = "修剪(C)";
                        mnemonic = "C";
                    }
                }
                spacer_1;
                : button {
                    alignment = centered;
                    label = "居中(E)";
                    mnemonic = "E";
                    key = "center";
                }
            }
        } /* end of row */
    
        : column {
            : row {
                key = "Edit_Boxes";
                : column {
                    : text {
                        label = "偏移:";
                    }
                    : text {
                        label = "比例:";
                    }
                }
                : column {
                    : edit_box {
                        label = "X:";
                        mnemonic = "X";
                        key   = "OX";
                        edit_limit = 8;
                    }
                    : edit_box {
                        label = "X:";
                        mnemonic = "X";
                        key   = "SX";
                        edit_limit = 8;
                    }
                }
                : column {
                    : edit_box {
                        label = "Y:";
                        mnemonic = "Y";
                        key   = "OY";
                        edit_limit = 8;
                    }
                    : edit_box {
                        label = "Y:";
                        mnemonic = "Y";
                        key   = "SY";
                        edit_limit = 8;
                    }
                }
            } /* end row */
            : toggle {
                key   = "Aspect";
                label = "保持宽高比(M)";
                mnemonic = "M";
            }
        } /* end of boxed column */
    } /* end column */
    ok_cancel_help_errtile;
  }
}

//***************************************************************************
//***************************************************************************
//***************************************************************************
//***************************************************************************
// Support for Landscape objects
//***************************************************************************
//***************************************************************************
landscape_library : dialog {
    label = "配景库";
    : row {
        : column {
            : text {
                key = "lib_name";
                width = 25;
                fixed_width = true;
            }
            : list_box {
                key = "plant_list";
                width = 25;
            }
        }
        : column {
            spacer_1;
            : button {
                label = "修改(&M)...";
                key = "plant_lib_modify";
            }
            : button {
                label = "新建(&N)...";
                key = "plant_lib_new";
            }
            : button {
                label = "删除(&D)";
                key = "plant_lib_delete";
            }
            : button {
                label = "打开(&O)...";
                key = "plant_lib_open";
            }
            : button {
                label = "保存(&S)...";
                key = "plant_lib_save";
            }
            spacer_1;
        }
    }
    ok_cancel_help_errtile;
}

landscape_lib_delete : dialog {
    label = "删除配景库";
    : column {
        : text {
             key = "name";
             width = 30;
             alignment = centered;
        }
        : text {
            label = "是否确定？";
            alignment = centered;
        }
    }
    ok_cancel;
}

landscape_lib_mod : dialog {
    key = "dialog";
    : column {
        key = "top_key";
        : row {
            : boxed_column {
                label = "默认几何图形";
                alignment = top;
                fixed_height = true;
                : radio_column {
                    key = "align_radio";
                    fixed_height = true;
                    : radio_button {
                        key = "align_single";
                        label = "单面(S)";
                        mnemonic = "S";
                    }
                    : radio_button {
                        key = "align_cross";
                        label = "跨越表面(C)";
                        mnemonic = "C";
                    }
                }
                spacer_1;
                : toggle {
                    key = "align_toggle";
                    label = "对齐浏览(&V)";
                }
           }  
           finish_preview;
        }
        : row {
            : column {
                :  text {
                    label = "名称:";
                }
                : text {
                    label = "图像文件:";
                }
                : text {
                    label = "不透明贴图文件:";
                }
            }
            : column {
                :  edit_box {
                    key = "plant_name";
                    edit_width = 14;
                }
                : edit_box {
                    key = "plant_image";
                    edit_width = 14;
                }
                : edit_box {
                    key = "plant_opac";
                    edit_width = 14;
                }
            }
            : column {
                spacer_1;
                spacer_1;
                : button {
                    label = "查找文件(F)...";
                    key = "ld_find_image";
                    mnemonic = "F";
                }
                : button {
                    label = "查找文件(N)...";
                    key = "ld_find_opac";
                    mnemonic = "N";
                }
            }
        }
        spacer_1;
        ok_cancel_help_errtile;
    }
}

landscape_lib_confirm : dialog {
    label = "修改配景库";
    initial_focus = "save";
    : column {
        : text {
            label = "当前配景库已修改。";
            alignment = centered;
        }
        : row {
            : button {
                label = "保存修改(S)...";
                is_default = true;
                mnemonic = "S";
                key = "save";
            }
            : button {
                label = "放弃修改(D)";
                mnemonic = "D";
                key = "discard";
            }
            : button {
                label = "取消命令(C)";
                is_cancel = true;
                mnemonic = "C";
                key = "cancel";
            }
        }
    }
}

landscape_edit : dialog {
    key = "dialog";
    : column {
        key = "topkey";
        : row {
            : column {
                : text {
                    key = "lib_name";
                    width = 25;
                    fixed_width = true;
                }
                : list_box {
                    key = "plant_list";
                    width = 25;
                }
            }
            : column {
                finish_preview;
             }
        }
        : row {
            : boxed_column {
                label = "几何图形";
                : radio_column {
                    key = "align_radio";
                    fixed_height = true;
                    : radio_button {
                        key = "align_single";
                        label = "单面(S)";
                        mnemonic = "S";
                    }
                    : radio_button {
                        key = "align_cross";
                        label = "跨越表面(C)";
                        mnemonic = "C";
                    }
               }
               spacer_1;
               : toggle {
                 key = "align_toggle";
                 label = "对齐浏览(&V)";
               }
            }
            : column {
                spacer_0;
                : edit_box_4 {
                    label = "高度(&H):";
                    key = "height_txt";
                    fixed_width = true;
                    value = "30";
                }
                : slider {
                    label = "高度";
                    key = "height_sld";
                    min_value = 1;
                    max_value = 100;
                    value = "30";
                }
                : button {
                    label = "位置(&P) <";
                    key = "plant_placement";
                }
            }
        }
    ok_cancel_help_errtile;
    }
}

//***************************************************************************
// Support for Fog/Depth cue
//***************************************************************************
fog : dialog {
    label = "雾化/深度设置";
    : row {
        : toggle {
           label = "启用雾化(&E)";
           key = "fog_enable";
        }
        : toggle {
           label = "雾化背景(&B)";
           key = "fog_background";
        }
    }
    : column {
        key = "values_to_edit";
        : row {
            : boxed_column {
                color_system;
                color_system_set;
                light_color_panel;
            }
        }
        : boxed_row {
            : column {
                : text {
                    label = "近距离:      ";
                    key = "near_dist_txt";
                    width = 22;
                    fixed_width = true;
                }
                : text {
                    label = "远距离:";
                    key = "far_dist_txt";
                }
            }
            : column {
                : edit_box_4 {
                    key = "near_dist_txt_ed";
                    value = "0";
                }
                : edit_box_4 {
                    key = "far_dist_txt_ed";
                    value = "100";
                }
            }
            : column {
                : slider_0_1_fixed { key = "near_dist_sld"; }
                : slider_0_1_fixed { key = "far_dist_sld"; }
            }
        }
        : boxed_row {
            : column {
                : text {
                    label = "近处雾化百分率:";
                    key = "near_pct_txt";
                    width = 22;
                    fixed_width = true;
                }
                : text {
                    label = "远处雾化百分率:";
                    key = "far_pct_txt";
               }
            }
            : column {
                : edit_box_4 {
                    key = "near_pct_txt_ed";
                    value = "0";
                }
                : edit_box_4 {
                    key = "far_pct_txt_ed";
                    value = "100";
                }
            }
            : column {
                : slider_0_1_fixed { key = "near_pct_sld"; }
                : slider_0_1_fixed { key = "far_pct_sld"; }
            }
        }
    }
    spacer_1;
    ok_cancel_help_errtile;
}
