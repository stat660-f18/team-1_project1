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


*
Research Question: Are there any differences in the mean wages for each 
nationality?

Rationale: This should help us understand if the difference of nationality results 
in various mean wages.

Methodology: Use PROC GLM step to perform F test and look at the p-value to decide 
the relationship between nationality and mean wages.

Limitations: Although we reach the conclusion that the difference of nationality 
leads to different mean wage, it's difficult for us to quickly find the 
nationality which has the highest mean wage.

Possible Follow-up Steps: We can add a PROC MEANS and PROC SORT steps to compute 
the mean wages for each nationality and sort the mean in descending order.
;

proc glm data=fifa18_analytic_file;
class nationality;
model eur_wage = nationality/solution; 
Run;
Quit;



*
Research Question:  How does the distribution of “special” for each body 
type?

Rationale: This helps identify the minimum, median, and maximunm "special" value, 
as well as the special value in first and third quarter for each body type.

Methodology: Compute five-number summaries by body-type indicator variable

Limitations: The distribution of "special" value is not visualized. 

Possible Follow-up Steps: we can use PROC SGPLOT statement to draw a line 
chart or bar graph, which presents the distribution more explicit.
;

proc means min q1 median q3 max data=fifa18_analytic_file;
    class body_type;
    var special;
run;

*
Research Question: What are the top 3 clubs with the highest mean value?

Rationale: This would help determine which 3 clubs contribute most to high
user value.

Methodology: Use PROC MEANS to compute the mean of eur_value for user club, 
and output the results to a temportatry dataset. Use PROC SORT extract and 
sort just the means the temporary dateset, and use PROC PRINT to print just 
the first three observations from the temporary dataset.

Limitations: We cannot use this methodology to identify the club with the
highest absolute value(not mean value).

Possible Follow-up Steps: We can leave out the PROC MEANS step to simply 
find out the club with the highest user value.
;

proc means mean noprint data=fifa18_analytic_file;
    class club;
    var eur_value;
    output out=fifa18_analytic_file_temp1;
run;

proc sort data=fifa18_analytic_file_temp1(where=(_STAT_="MEAN"));
    by descending eur_value;
run;

proc print noobs data=fifa18_analytic_file_temp(obs=3);
    id club;
    var eur_value;
run;
