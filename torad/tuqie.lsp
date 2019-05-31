(defun c:data1()
	(setq data(getdata))
	(while (/= (dxf 0 data) "LINE")
		(setq data(getdata))
	)
	data
)