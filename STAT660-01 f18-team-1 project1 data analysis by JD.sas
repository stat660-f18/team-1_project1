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


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT660-01_f18-team-1_project1_data_preparation.sas';


*
Research Question: What is the nationality distribution percentages of the FIFA 
18 players?

Rationale: This should help identify which country does mostly the FIFA 18 
players come from.

Methodology: 

Limitations: 

Possible Follow-up Steps: 
;


*
Research Question:  How does the distribution of “Skill Moves” for players who 
was born after 1990 compare to that was born before 1990?

Rationale: This would help inform whether players born before 1990 are more 
familiar with using Skill Moves in FIFA 18.

Methodology: 

Limitations: 

Possible Follow-up Steps: 
;


*
Research Question: What is the percentage of each body type in FIFA 18? 

Rationale: This would help determine which body type is the most popular
and the least popular in FIFA 18 players.

Methodology: 

Limitations: 

Possible Follow-up Steps: 
;
