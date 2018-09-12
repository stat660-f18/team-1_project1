

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

X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
;

%include '.\STAT660-01 f18-team-1 project1 data preparation.sas'
;



title1 'Research Question: What is the age distribution amongst each club in FIFA 18?'
;

title2 'Rationale: This could help identify which countries tend to focus on creating their players from youth as opposed to those who purchase their players'
;

*
Methodology: I think we could take the proc means of the age variable and base it off the clubs and even possibly 
get a by league by club break down to understand the age distribution amongst top clubs and top leagues


Limitations: I think our analysis won't account for which players are designated starters on the team and which
players are reserves
 
Possible Follow Up: Maybe a variable for starting position on the team whether it is starter, bench, or reserves
;

title1 'Research Question: How does the body type distribution differ in each league and is there a correlation with salary based on the preferences of each league?'
; 
title2 'Rationale: This would help determine if leagues prefer different types of player body types based on league playstyles'
;

*
Methodology: Could proc sort body type by leagues and then find the mean salary of players based off body types to find
any correlation amongst leagues that might prefer more finesse players versus physical players

Limitations: I can see how the data might not tell us much as I am sure player position might play a role on what body type
a club would want that player to have.
 
Possible Follow Up: Perhaps we could do the focus more on weight and height in order to determine whether a league
prefers a faster/lighter finesse player or a physically bigger and muscular "power" player 
;

title1 'Research Question: What is the Euro Value and Euro Wage distribution amongst each league and nationality in FIFA 18?'
; 
title2 'Rationale: This could correlate based off the first question determining which teams "buy their trophies" as opposed to work for them'
;

*
Methodology: Could we take the median and range of salaries based off of clubs, leagues, and nationality, to see if there is a
possible trend in the types of players that clubs spend money on (i.e. Brazilian) as well as the top clubs versus the smaller clubs

Limitations: I think the question or data might be too broad, would need to identify the best way to determine which leagues and/or clubs
buy their trophies and players as opposed to raising their youth to play in their clubs 
 
Possible Follow Up: Perhaps we could determine the distribution of foreign players in each league and then take the mean salaries and values 
of each leauge based on that percentage of non-home grown players

;
