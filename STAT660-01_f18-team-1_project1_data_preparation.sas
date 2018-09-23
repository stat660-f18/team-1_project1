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



* check raw fifa18 dataset for duplicates with respect to its composite key;
proc sort
        nodupkey
        data=fifa18_raw
        dupout=fifa18_raw_dups
        out=_null_
    ;
    by
       Player ID
    ;
run;

* build analytic dataset from fifa18 dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;

data fifa18_analytic_file;
    retain
        Club
        Special
        Age
        League
        birth_date
        height_cm
        weight_kg
        body_type
        nationality
        eur_value
        eur_wage
        overall
    ;
    keep
        
        Club
        Special
        Age
        League
        birth_date
        height_cm
        weight_kg
        body_type
        nationality
        eur_value
        eur_wage
        overall
    ;
    set fifa18_raw;
run;



* 
Use PROC MEANS to compute the mean of eur_wage for
League, and output the results to a temporary dataset, and use PROC SORT
to extract and sort just the means the temporary dateset, which will be used as
part of data analysis by LL.
;

proc freq data=fifa18_analytic_file; 
   tables league*eur_wage*body_type; 
run;

title1 'Research Question: What is the Euro Value distribution amongst each league and nationality in FIFA 18?'
; 
title2 'Rationale: This could correlate based off the first question determining which teams "buy their trophies" as opposed to work for them'
;

footnote1
'based on the above tables we can see that the german, african, and english leagues 
favor a bigger body type then latin teams who prefer a smaller body type'
;


proc freq data=fifa18_analytic_file; 
   tables league*nationality*euro_value / crosslist; 
run;

title1 'Research Question: How does the body type distribution differ in each league and is there a correlation with salary based on the preferences of each league?'
; 
title2 'Rationale: This would help determine if leagues prefer different types of player body types based on league playstyles'
;

footnote1
'body type does not necessarily correlate with value, might want to check and see if we
can tie this more over to skill level or game statistics as body type does not
associate over with skill level'
;


proc freq data=fifa18_analytic_file; 
   tables age*club; 
run;

title1 'Research Question: What is the age distribution amongst each club in FIFA 18?'
;

title2 'Rationale: This could help identify which countries tend to focus on creating their players from youth as opposed to those who purchase their players'
;

footnote1
'seems that most leagues with a higher age distribution are amongst asian, usa, and english leagues
while a  much younger age distribution is amongst latin american teams and african teams'
;


proc means
        mean
        noprint
        data=fifa18_analytic_file
    ;
    class
        League
    ;
    var
        eur_wage
    ;
    output
        out=fifa18_analytic_file_temp
    ;
run;

proc sort
        data=fifa18_analytic_file_temp(where=(_STAT_="MEAN"))
    ;
    by
        descending eur_wage
    ;
run;


*
Use PROC MEANS to compute the mean of eur_value for user club, 
and output the results to a temportatry dataset. Use PROC SORT extract and 
sort just the means the temporary dateset


proc means mean noprint data=fifa18_analytic_file;
    class club;
    var eur_value;
    output out=fifa18_analytic_file_temp1;
run;

proc sort data=fifa18_analytic_file_temp1(where=(_stat_="mean"));
    by descending eur_value;
run;
