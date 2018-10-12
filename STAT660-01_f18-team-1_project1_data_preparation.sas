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

[Data Source] 
https://www.kaggle.com/kevinmh/fifa-18-more-complete-player-dataset
data found in kaggle

[Data Dictionary] 
https://www.kaggle.com/kevinmh/fifa-18-more-complete-player-dataset

[Unique ID Schema] The column "Player ID" is a primary key. 
;


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat660/team-1_project1/blob/master/FIFA_Player_Data.xls?raw=true
;

* load raw FRPM dataset over the wire;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
			filename tempfile TEMP;
			proc http
			    method="get"
			    url="&url."
			    out=tempfile
			    ;
			run;
			proc import
			    file=tempfile
			    out=&dsn.
			    dbms=&filetype.;
			run;
			filename tempfile clear;
		%end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;

%loadDataIfNotAlreadyAvailable(
    fifa18_raw,
    &inputDatasetURL.,
    xls
)


* check raw fifa18 dataset for duplicates with respect to its composite key;
proc sort
        noduprecs
        data=fifa18_raw
        dupout=fifa18_raw_dups
        out=fifa18_nodups
    ;
    by
       ID
    ;
run;

* build analytic dataset from fifa18 dataset with the least number of 
columns and minimal cleaning/transformation needed to address research 
questions in corresponding data-analysis files;

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
    set fifa18_nodups;
run;

* 
Use PROC MEANS to compute the mean of eur_wage for
League, and output the results to a temporary dataset, and use PROC SORT
to extract and sort just the means the temporary dateset, which will be 
used as part of data analysis by LL.
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
        out=fifa18_League_EurWage
    ;
run;

proc sort
      data=fifa18_LEague_EurWage(where=(_stat_="mean"))
    ;
    by
        descending eur_wage
    ;
run;

*
Use PROC MEANS to compute the mean of eur_value for user club, 
and output the results to dataset "fifa18_Club_EurVal". Use PROC SORT extract and 
sort just the means in the dataset "fifa18_Club_EurVal" by descending oreder;

proc means 
	mean 
	noprint 
	data=fifa18_analytic_file
    ;
    class 
	club
    ;
    var 
	eur_value
    ;
    output 
	out=fifa18_Club_EurVal
    ;
run;

proc sort 
	data=fifa18_Club_EurVal(where=(_STAT_="MEAN"))
    ;
    by 
	descending eur_value
    ;
run;
