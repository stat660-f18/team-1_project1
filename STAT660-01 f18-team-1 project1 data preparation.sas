*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file prepares the dataset described below for analysis.

[Dataset Name] FIFA 18 More Complete Player Dataset

[Experimental Units] FIFA 18 Players

[Number of Observations] 9,758        

[Number of Features] 185

[Data Source] https://www.kaggle.com/kevinmh/fifa-18-more-complete-player-dataset/downloads/complete.csv/5

[Data Dictionary] https://www.kaggle.com/kevinmh/fifa-18-more-complete-player-dataset

[Unique ID Schema] The column "Player ID" is a primary key. 
;


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat660/team-1_project1/blob/master/FIFA_Player_Data.xls?raw=true
;


* load raw FRPM dataset over the wire;
filename tempfile TEMP;
proc http
    method="get"
    url="&inputDatasetURL."
    out=tempfile
    ;
run;
proc import
    file=tempfile
    out=fifa18_raw
    dbms=xls;
run;
filename tempfile clear;
