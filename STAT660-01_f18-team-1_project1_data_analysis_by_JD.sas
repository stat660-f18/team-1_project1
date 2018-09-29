*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding FIFA 18 user information

Dataset Name: FIFA_Player_Data created in external file
STAT660-01_f18-team-1_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset FIFA18_analytic_file;
%include '.\STAT660-01_f18-team-1_project1_data_preparation.sas';


title 1
'Research Question: Are there any differences in the mean wages for each nationality?'
;

title 2
'Rationale: This should help us understand if the difference of nationality results in various mean wages.'
;

footnote1
'From the output, we can know that users from different country have different mean wages'
;

footnote2
'By analyzing the result, we can infer that users from European countries tend to have hight wages than users from other countries'
;

footnote3
'This conclusion may be explained by the fact that Europeans usually contribute more time in playing this game.'
;
*
Methodology: Use PROC GLM step to perform F test and look at the p-value to decide 
the relationship between nationality and mean wages.

Limitations: Although we reach the conclusion that the difference of nationality 
leads to different mean wage, it's difficult for us to quickly find the 
nationality which has the highest mean wage.

Possible Follow-up Steps: We can add a PROC MEANS and PROC SORT steps to compute 
the mean wages for each nationality and sort the mean in descending order.
;
proc glm 
		data=fifa18_analytic_file
	; 
    class 
		nationality
	;
    model 
		eur_wage = nationality/solution
	; 
run;
quit;
title;
footnote;



title 1
'Research Question:  How does the distribution of special skills for each body type?'
;

title 2
'Rationale: This helps identify the minimum, median, and maximunm "special" value, as well as the special value in first and third quarter for each body type.'
;

footnote1
'From the output, we know that users with the "normal" body type have the highest maximum special. We can also find out that users with "normal" body type have the lowest minimum special too.' 
;

footnote2
'This infers that choosing a "normal" body tpye doesn't affect the "special" value.'
;

footnote3
'The reason is that the special value is not related to body type. There is no direct relationship between them'
;
*
Methodology: Compute five-number summaries by body-type indicator variable

Limitations: The distribution of "special" value is not visualized. 

Possible Follow-up Steps: we can use PROC SGPLOT statement to draw a line 
chart or bar graph, which presents the distribution more explicit.
;
proc means 
		min q1 median q3 max 
		data=fifa18_analytic_file
	;
    class 
		body_type
	;
    var 
		special
	;
run;
title;
footnote;



title 1
'Research Question: What are the top 3 clubs with the highest mean value?'
;

title 2
'Rationale: This would help determine which 3 clubs contribute most to high user value.'
;

footnote1
'From the result, we know that FC Bayern Munich has the highest mean value of 36881250. We can also see that Real Madrid CF and FC Barcelona rank the second and the third, respectively.'
;

footnote2
'This result shows that joing FC Bayern Munich club may be helpful for the users to get a high value'
;

footnote3
'The reason is that the users in the FC Bayern Munich are more skillful in playing FIFA18'
;
*
Methodology: Use PROC PRINT to print just the first three observations 
from the temporary dataset

Limitations: We cannot use this methodology to identify the club with the
highest absolute value(not mean value).

Possible Follow-up Steps: We can leave out the PROC MEANS step to simply 
find out the club with the highest user value
;
proc print 			
		noobs 
		data=fifa18_analytic_file_temp1(obs=3)
	;
    id 
		club
	;
    var 
		eur_value
	;
run;
title;
footnote;
