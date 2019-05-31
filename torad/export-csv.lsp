(defun c:Export-CSV (/ count csv lst txt )

 (setq lst '("ITEM" "QUANTITY")) ; given list 

 (setq count 1)

 (setq csv (open(strcat(getvar"dwgprefix")(getvar"dwgname")".csv")"w")) ; create a csv file using drawing prefix & name with .csv file type

 (setq txt (nth 0 lst)) ; place into a text string the first element of the list

 (repeat (1- (length lst)) (setq txt (strcat txt "," (nth count lst))) (setq count (1+ count)))

; loop through the length of the list and place into a long text string separated by a comma

 (write-line txt csv) ; write the long text string to the csv file

 (close csv) ; close the csv file

) 