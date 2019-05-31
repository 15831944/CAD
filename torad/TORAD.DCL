// ***************************************************************************
//        torad.dcl
//
//        This file is part of the program torad.lsp to export
//        RADIANCE scene description files from Autocad.
//
//        Copyright (C) 1993 by Georg Mischler / Lehrstuhl
//                              fuer Bauphysik ETH Zurich.
//
//        Permission to use, copy, modify, and distribute this software
//        for any purpose and without fee is hereby granted, provided
//        that the above copyright notice appears in all copies and that
//        both that copyright notice and this permission notice appear in
//        all supporting documentation.
//
//        THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED
//        WARRANTY.  ALL IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR
//        PURPOSE AND OF MERCHANTABILITY ARE HEREBY DISCLAIMED.
//
//        Acknowlegdements:
//        Final developement of this program has been sponsored by Prof. Dr.
//        B. Keller, Building Physics, Dep. for Architekture ETH Zurich.
//        The developement environment has been provided by Prof. Dr.
//        G. Schmitt, Architecture & CAAD ETH Zurich.
//
// ***************************************************************************



dcl_settings : default_dcl_settings { audit_level = 0; }

radiance : dialog {
	label = "torad - radiance export facility";
	: column {
		: row {
			: boxed_column {
				label  = "sampled entities:";
				key    = "filelist";
				: toggle {
					label = "Planarized faces of 3DFACEs";
					key   = "3DFACE";
				}
				: toggle {
					label = "Extruded and flat TRACEs";
					key   = "TRACE";
				}
				: toggle {
					label = "Extruded and flat SOLIDs";
					key   = "SOLID";
				}
				: toggle {
					label = "Extruded and flat CIRCLEs";
					key   = "CIRCLE";
				}
				: toggle {
					label = "Extruded faces of ARCs";
					key   = "ARC";
				}
				: toggle {
					label = "Extruded faces of LINEs";
					key   = "LINE";
				}
				: toggle {
					label = "Extruded faces of 2D-PLINEs";
					key   = "PLINE";
				}
				: toggle {
					label = "Constant width of 2D-PLINES";
					key   = "WPLINE";
				}
				: toggle {
					label = "Closed 2d-polys as POLYGONs";
					key   = "POLYGON";
				}
				: toggle {
					label = "Faces of 3D-MESHes";
					key   = "PMESH";
				}
				: toggle {
					label = "Faces if POLYFACEs";
					key   = "PFACE";
				}
				: toggle {
					label = "Points as SPHERES or BUBBLEs";
					key   = "POINT";
				}
			}
			: column {
				: boxed_column {
					label = "write filetypes:";
					: toggle {
						label = "Geometry information";
						key   = "files";
						value = "1";
					}
					: column {
						key = "auxf";
						: toggle {
							label = "Master-Control";
							key   = "master";
						}
						:row {
							spacer_1;
							:column {
								key = "masterblock";
								: edit_box {
									label = "WCS Rot. from E to X:";
									key   = "WCS rotation";
									value = "0.0";
									width = 2;
								}
								: toggle {
									label = "Makefile";
									key   = "make";
								}
							}
						}
						: toggle {
							label = "Materials (all same)";
							key   = "mat";
						}
					}
					: row {
						: toggle {
							label = "View:";
							key   = "view";
							fixed_width = true;
						}
						: popup_list {
							key   = "viewlist";
							fixed_width = true;
							width = 12;
						}
						spacer_0;
					}
					: toggle {
						label = "Sun at position:";
						key   = "light";
					}
					: row {
						key = "sunvals";
						:column {
							:edit_box {
								label = "Long.:";
								key   = "Longitude";
								value = "-8.5";
								width = 3;
							}
							:edit_box {
								label = "Lat.: ";
								key   = "Latitude";
								value = "47.5";
								width = 3;
							}
							:edit_box {
								label = "TZ.:  ";
								key   = "TZ";
								value = "-1";
								width = 3;
							}
						}
						: column {
							: edit_box {
								label = " Month:";
								key   = "Month";
								value = "08";
								width = 3;
							}
							: edit_box {
								label = " Day:  ";
								key   = "Day";
								value = "01";
								width = 3;
							}
							: edit_box {
								label = " Hour: ";
								key   = "Hour";
								value = "16.5";
								width = 3;
							}
						}
					}
				}
				: boxed_column {
					label = "sampling modes:";
					key   = "modes";
					: text {
						label = "Sample entities by:";
					}
					: radio_row {
						key   = "sample";
						value = "Color";
						:radio_button {
							label = "Color ";
							key   = "Color";
						}
						:radio_button {
							label = "Layer ";
							key   = "Layer";
						}
						:radio_button {
							label = "Toplayer";
							key   = "Toplayer";
						}
					}
					spacer_0;
					: edit_box {
						label = "Seg./circle for arcs:";
						key   = "nsegs";
						value = "16";
						width = 2;
					}
				}
			}
		}
		: row {
			: edit_box {
				label = "Filename prefix:";
				key   = "prefix";
			}
			ok_cancel;
		}
	}
}
