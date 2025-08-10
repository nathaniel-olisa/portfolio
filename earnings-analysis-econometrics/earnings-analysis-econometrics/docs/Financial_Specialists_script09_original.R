#==============================================================================
#   A tool to find most popular college majors and average earnings by major for
#   any occupation. 
#==============================================================================

# How to use this script.

# Find line 294: subset3 = subset(subset2, OCC1990==229 & ...)
# Change OCC1990==229 to a different code (See Section 4 for list of codes)
# Find line 344: write.csv(reformat_sorted_major, file="software_developers.csv",...)
# Change "software_developers" to whichever occupation you chose for line 294
# Run line 294 and all lines in Section 3
# Select the csv file you created under Files in bottom right pane, More>export

# First version by Matt Holian 2/22/2019
# Austin Tse 12/3/2019 added the automated analysis (section 3)
# This version 4/1/2020 is by Matt Holian.

# This script is part of a broader replication project described in my 
# forthcoming monograph, titled, Data and the American Dream: Contemporary 
# Social Controversies and the American Community Survey. 

# See: https://sites.google.com/site/profholian/home/dad

# The analysis carried out here is a generalized version of that presented in:

# John V. Winters (2016) Is economics a good major for future lawyers? 
# Evidence from earnings data, The Journal of Economic Education, 47:2, 187-191.

# I base the format of this script off of tutorials by Bill Sundstrom and 
# Michael Kevane; see their Guide to R at: https://rpubs.com/wsundstrom/home

#==============================================================================
#   1. Settings, packages, and options
#==============================================================================

# You should generally run all of the commands in this Section 1 

# Clear the working space
rm(list = ls())

# Set working directory 
# setwd("/Users/mattholian/Desktop/StoriesAndStatistics/Rscripts")

#install.packages("stargazer")
#install.packages("car")
#install.packages("plyr")
#install.packages("spatstat")

library(stargazer)
library(car)
library(plyr)
library(spatstat)

# Load the packages; you may not need them all but it's better than not loading a package you need
# Install them if they are not already installed. stargazer is for creating tables of reg results
# car is for recoding; plyr contains the function "count"
# data.table and bit64 enable the fread function for reading in large CSV fies
# spatstat contains a weighted median function 



# turn off scientific notation except for big numbers
options(scipen = 9)


#==============================================================================
#   2. Data section
#==============================================================================

# Because the data has already been loaded and cleaned, most users can skip to 
# to line 294

# If a user wants to run this on their machine they can start from line 93, if
# the data file: EarningsMajor.RData is saved to their directory folder. 
# Lines 80-91 in this section show how to produce EarningsMajor.RData, by using 
# the full IPUMS-USA data extract. The ACS_master.RData file is produced using 
# the IPUMS extract described in the Appendix to Data and the American Dream. 

#ACS_master <-fread('usa_00025.csv', header = T, sep = ',')
#save(ACS_master, file = "ACS_master.RData")

# To load the RData file, after it has been saved to your directory

#load("ACS_master.RData")

# Next I carve out a smaller sample for users with memory limitations

#subset2 = subset(ACS_master, YEAR>2014 & GQ!=3 & GQ!=4 & AGE>22 & AGE<51, select=c(OCC1990, EDUCD, AGE, YEAR, INCEARN, DEGFIELDD, PERWT, CPI99))

#save(subset2, file = "EarningsMajor.RData")

load("EarningsMajor.RData")


# the next line creates a new variable, the name in English of the respondent's degree field (DEGFIELDD). Note, extra D indicates "detailed version" used
subset2$major<-recode(subset2$DEGFIELDD,  
                      "0	=	'	N/A	'	;
                         1100	=	'	General Agriculture	'	;
                         1101	=	'	Agriculture Production and Management	'	;
                         1102	=	'	Agricultural Economics	'	;
                         1103	=	'	Animal Sciences	'	;
                         1104	=	'	Food Science	'	;
                         1105	=	'	Plant Science and Agronomy	'	;
                         1106	=	'	Soil Science	'	;
                         1199	=	'	Miscellaneous Agriculture	'	;
                         1300	=	'	Environment and Natural Resources	'	;
                         1301	=	'	Environmental Science	'	;
                         1302	=	'	Forestry	'	;
                         1303	=	'	Natural Resources Management	'	;
                         1401	=	'	Architecture	'	;
                         1501	=	'	Area, Ethnic, and Civilization Studies	'	;
                         1900	=	'	Communications	'	;
                         1901	=	'	Communications	'	;
                         1902	=	'	Journalism	'	;
                         1903	=	'	Mass Media	'	;
                         1904	=	'	Advertising and Public Relations	'	;
                         2001	=	'	Communication Technologies	'	;
                         2100	=	'	Computer and Information Systems	'	;
                         2101	=	'	Computer Programming and Data Processing	'	;
                         2102	=	'	Computer Science	'	;
                         2105	=	'	Information Sciences	'	;
                         2106	=	'	Computer Information Management and Security	'	;
                         2107	=	'	Computer Networking and Telecommunications	'	;
                         2201	=	'	Cosmetology Services and Culinary Arts	'	;
                         2300	=	'	General Education	'	;
                         2301	=	'	Educational Administration and Supervision	'	;
                         2303	=	'	School Student Counseling	'	;
                         2304	=	'	Elementary Education	'	;
                         2305	=	'	Mathematics Teacher Education	'	;
                         2306	=	'	Physical and Health Education Teaching	'	;
                         2307	=	'	Early Childhood Education	'	;
                         2308	=	'	Science  and Computer Teacher Education	'	;
                         2309	=	'	Secondary Teacher Education	'	;
                         2310	=	'	Special Needs Education	'	;
                         2311	=	'	Social Science or History Teacher Education	'	;
                         2312	=	'	Teacher Education Multiple Levels	'	;
                         2313	=	'	Language and Drama Education	'	;
                         2314	=	'	Art and Music Education	'	;
                         2399	=	'	Miscellaneous Education	'	;
                         2400	=	'	General Engineering	'	;
                         2401	=	'	Aerospace Engineering	'	;
                         2402	=	'	Biological Engineering	'	;
                         2403	=	'	Architectural Engineering	'	;
                         2404	=	'	Biomedical Engineering	'	;
                         2405	=	'	Chemical Engineering	'	;
                         2406	=	'	Civil Engineering	'	;
                         2407	=	'	Computer Engineering	'	;
                         2408	=	'	Electrical Engineering	'	;
                         2409	=	'	Engineering Mechanics, Physics, and Science	'	;
                         2410	=	'	Environmental Engineering	'	;
                         2411	=	'	Geological and Geophysical Engineering	'	;
                         2412	=	'	Industrial and Manufacturing Engineering	'	;
                         2413	=	'	Materials Engineering and Materials Science	'	;
                         2414	=	'	Mechanical Engineering	'	;
                         2415	=	'	Metallurgical Engineering	'	;
                         2416	=	'	Mining and Mineral Engineering	'	;
                         2417	=	'	Naval Architecture and Marine Engineering	'	;
                         2418	=	'	Nuclear Engineering	'	;
                         2419	=	'	Petroleum Engineering	'	;
                         2499	=	'	Miscellaneous Engineering	'	;
                         2500	=	'	Engineering Technologies	'	;
                         2501	=	'	Engineering and Industrial Management	'	;
                         2502	=	'	Electrical Engineering Technology	'	;
                         2503	=	'	Industrial Production Technologies	'	;
                         2504	=	'	Mechanical Engineering Related Technologies	'	;
                         2599	=	'	Miscellaneous Engineering Technologies	'	;
                         2600	=	'	Linguistics and Foreign Languages	'	;
                         2601	=	'	Linguistics and Comparative Language and Literature	'	;
                         2602	=	'	French, German, Latin and Other Common Foreign Language Studies	'	;
                         2603	=	'	Other Foreign Languages	'	;
                         2901	=	'	Family and Consumer Sciences	'	;
                         3200	=	'	Law	'	;
                         3201	=	'	Court Reporting	'	;
                         3202	=	'	Pre-Law and Legal Studies	'	;
                         3300	=	'	English Language, Literature, and Composition	'	;
                         3301	=	'	English Language and Literature	'	;
                         3302	=	'	Composition and Speech	'	;
                         3400	=	'	Liberal Arts and Humanities	'	;
                         3401	=	'	Liberal Arts	'	;
                         3402	=	'	Humanities	'	;
                         3501	=	'	Library Science	'	;
                         3600	=	'	Biology	'	;
                         3601	=	'	Biochemical Sciences	'	;
                         3602	=	'	Botany	'	;
                         3603	=	'	Molecular Biology	'	;
                         3604	=	'	Ecology	'	;
                         3605	=	'	Genetics	'	;
                         3606	=	'	Microbiology	'	;
                         3607	=	'	Pharmacology	'	;
                         3608	=	'	Physiology	'	;
                         3609	=	'	Zoology	'	;
                         3611	=	'	Neuroscience	'	;
                         3699	=	'	Miscellaneous Biology	'	;
                         3700	=	'	Mathematics	'	;
                         3701	=	'	Applied Mathematics	'	;
                         3702	=	'	Statistics and Decision Science	'	;
                         3801	=	'	Military Technologies	'	;
                         4000	=	'	Interdisciplinary and Multi-Disciplinary Studies (General)	'	;
                         4001	=	'	Intercultural and International Studies	'	;
                         4002	=	'	Nutrition Sciences	'	;
                         4003	=	'	Neuroscience	'	;
                         4005	=	'	Mathematics and Computer Science	'	;
                         4006	=	'	Cognitive Science and Biopsychology	'	;
                         4007	=	'	Interdisciplinary Social Sciences	'	;
                         4008	=	'	Multi-disciplinary or General Science	'	;
                         4101	=	'	Physical Fitness, Parks, Recreation, and Leisure	'	;
                         4801	=	'	Philosophy and Religious Studies	'	;
                         4901	=	'	Theology and Religious Vocations	'	;
                         5000	=	'	Physical Sciences	'	;
                         5001	=	'	Astronomy and Astrophysics	'	;
                         5002	=	'	Atmospheric Sciences and Meteorology	'	;
                         5003	=	'	Chemistry	'	;
                         5004	=	'	Geology and Earth Science	'	;
                         5005	=	'	Geosciences	'	;
                         5006	=	'	Oceanography	'	;
                         5007	=	'	Physics	'	;
                         5008	=	'	Materials Science	'	;
                         5098	=	'	Multi-disciplinary or General Science	'	;
                         5102	=	'	Nuclear, Industrial Radiology, and Biological Technologies	'	;
                         5200	=	'	Psychology	'	;
                         5201	=	'	Educational Psychology	'	;
                         5202	=	'	Clinical Psychology	'	;
                         5203	=	'	Counseling Psychology	'	;
                         5205	=	'	Industrial and Organizational Psychology	'	;
                         5206	=	'	Social Psychology	'	;
                         5299	=	'	Miscellaneous Psychology	'	;
                         5301	=	'	Criminal Justice and Fire Protection	'	;
                         5400	=	'	Public Affairs, Policy, and Social Work	'	;
                         5401	=	'	Public Administration	'	;
                         5402	=	'	Public Policy	'	;
                         5403	=	'	Human Services and Community Organization	'	;
                         5404	=	'	Social Work	'	;
                         5500	=	'	General Social Sciences	'	;
                         5501	=	'	Economics	'	;
                         5502	=	'	Anthropology and Archeology	'	;
                         5503	=	'	Criminology	'	;
                         5504	=	'	Geography	'	;
                         5505	=	'	International Relations	'	;
                         5506	=	'	Political Science and Government	'	;
                         5507	=	'	Sociology	'	;
                         5599	=	'	Miscellaneous Social Sciences	'	;
                         5601	=	'	Construction Services	'	;
                         5701	=	'	Electrical and Mechanic Repairs and Technologies	'	;
                         5801	=	'	Precision Production and Industrial Arts	'	;
                         5901	=	'	Transportation Sciences and Technologies	'	;
                         6000	=	'	Fine Arts	'	;
                         6001	=	'	Drama and Theater Arts	'	;
                         6002	=	'	Music	'	;
                         6003	=	'	Visual and Performing Arts	'	;
                         6004	=	'	Commercial Art and Graphic Design	'	;
                         6005	=	'	Film, Video and Photographic Arts	'	;
                         6006	=	'	Art History and Criticism	'	;
                         6007	=	'	Studio Arts	'	;
                         6099	=	'	Miscellaneous Fine Arts	'	;
                         6100	=	'	General Medical and Health Services	'	;
                         6102	=	'	Communication Disorders Sciences and Services	'	;
                         6103	=	'	Health and Medical Administrative Services	'	;
                         6104	=	'	Medical Assisting Services	'	;
                         6105	=	'	Medical Technologies Technicians	'	;
                         6106	=	'	Health and Medical Preparatory Programs	'	;
                         6107	=	'	Nursing	'	;
                         6108	=	'	Pharmacy, Pharmaceutical Sciences, and Administration	'	;
                         6109	=	'	Treatment Therapy Professions	'	;
                         6110	=	'	Community and Public Health	'	;
                         6199	=	'	Miscellaneous Health Medical Professions	'	;
                         6200	=	'	General Business	'	;
                         6201	=	'	Accounting	'	;
                         6202	=	'	Actuarial Science	'	;
                         6203	=	'	Business Management and Administration	'	;
                         6204	=	'	Operations, Logistics and E-Commerce	'	;
                         6205	=	'	Business Economics	'	;
                         6206	=	'	Marketing and Marketing Research	'	;
                         6207	=	'	Finance	'	;
                         6209	=	'	Human Resources and Personnel Management	'	;
                         6210	=	'	International Business	'	;
                         6211	=	'	Hospitality Management	'	;
                         6212	=	'	Management Information Systems and Statistics	'	;
                         6299	=	'	Miscellaneous Business and Medical Administration	'	;
                         6402	=	'	History	'	;
                         6403	=	'	United States History	'	")

# generating an inflation-adjusted income measure (to 2015 dollars), method 1.
# See: https://cps.ipums.org/cps/cpi99.shtml for an explanation
subset2$INCEARNadj= (subset2$INCEARN)*(subset2$CPI99)*1.430


# Next we generate a user-specified estimation subsample

# NOTE TO USER: Change OCC1990 code from 229 (software developers) to 195 (Editors and reporters) or a different occupation; 
# SEE Section 4 of this R script for a list of occupations and their corresponding OCC1990 codes.


subset3 = subset(subset2, OCC1990==229 & EDUCD>100 & AGE>24 & AGE<51 & YEAR>2014 & YEAR<2018)

# Note: Occupation code 229	is Computer software developers, and 178 is Lawyers


#==============================================================================
#   3. A generalizable, automated analysis 
#==============================================================================

# The code in this subsection produces a table of most popular majors and average earnings by major, for any occupation specified.
# A user specifies the occupation by modifying line 294 above.
# The industry, and other characteristics of the estimation subsample, are specified by the user in defining subset3 in Section 2.
# There we set OCC1990 equal to 229,	Computer software developers

# This is the first of several functions, this one counts of workers by major.
major_freq <- count(subset3, 'major')
major_freq

# the next two lines produces a table that is sorted from most to least common
sorted_major_freq <- major_freq[order(-major_freq$freq),]
sorted_major_freq

# calculate cumulative percentages of majors
sorted_major_freq$cumul_percent <- (sorted_major_freq$freq / sum(sorted_major_freq$freq))*100

# this function simply takes a degree code input and calculates weighted averages
get_means <- function(x) {
  return (weighted.mean(subset(
    subset3,major==x)$INCEARNadj,
    subset(subset3,major==x)$PERWT))
}

get_medians <- function(deg) {
  return (weighted.median(subset(
    subset3,major==deg)$INCEARNadj,
    subset(subset3,major==deg)$PERWT))
}

# append all means to the sorted majors table 
sorted_major_freq$mean <- lapply(sorted_major_freq$major, get_means)
sorted_major_freq

sorted_major_freq$median <- lapply(sorted_major_freq$major, get_medians)
sorted_major_freq

# Coerce df to all-character to prep for csv export
reformat_sorted_major <- data.frame(lapply(sorted_major_freq, as.character), stringsAsFactors = FALSE)
reformat_sorted_major

# export file for viewing
write.csv(reformat_sorted_major, file="software_developers.csv",row.names = FALSE)

# The user can elect to modify the file name in the line immediately above, for example from "software_developers" to "lawyers".

#==============================================================================
#   4. Appendix: Occupation codes
#==============================================================================

# There is no code to run in this section; instead I just reproduce the codebook definitions of DEGFIELDD, i.e. the degree field
# codes are matched to the name of the major (in English). This is for easy reference.

#	 OCC1990	Occupation, 1990 basis
#		MANAGERIAL AND PROFESSIONAL SPECIALTY OCCUPATIONS
#		Executive, Administrative, and Managerial Occupations:
#	3	Legislators
#	4	Chief executives and public administrators
#	7	Financial managers
#	8	Human resources and labor relations managers
#	13	Managers and specialists in marketing, advertising, and public relations
#	14	Managers in education and related fields
#	15	Managers of medicine and health occupations
#	16	Postmasters and mail superintendents
#	17	Managers of food-serving and lodging establishments
#	18	Managers of properties and real estate
#	19	Funeral directors
#	21	Managers of service organizations, n.e.c.
#	22	Managers and administrators, n.e.c.
#		Management Related Occupations:
#	23	Accountants and auditors
#	24	Insurance underwriters
#	25	Other financial specialists
#	26	Management analysts
#	27	Personnel, HR, training, and labor relations specialists
#	28	Purchasing agents and buyers, of farm products
#	29	Buyers, wholesale and retail trade
#	33	Purchasing managers, agents and buyers, n.e.c.
#	34	Business and promotion agents
#	35	Construction inspectors
#	36	Inspectors and compliance officers, outside construction
#	37	Management support occupations
#		Professional Specialty Occupations
#		Engineers, Architects, and Surveyors:
#	43	Architects
#		Engineers:
#	44	Aerospace engineer
#	45	Metallurgical and materials engineers, variously phrased
#	47	Petroleum, mining, and geological engineers
#	48	Chemical engineers
#	53	Civil engineers
#	55	Electrical engineer
#	56	Industrial engineers
#	57	Mechanical engineers
#	59	Not-elsewhere-classified engineers
#		Mathematical and Computer Scientists:
#	64	Computer systems analysts and computer scientists
#	65	Operations and systems researchers and analysts
#	66	Actuaries
#	67	Statisticians
#	68	Mathematicians and mathematical scientists
#		Natural Scientists:
#	69	Physicists and astronomers
#	73	Chemists
#	74	Atmospheric and space scientists
#	75	Geologists
#	76	Physical scientists, n.e.c.
#	77	Agricultural and food scientists
#	78	Biological scientists
#	79	Foresters and conservation scientists
#	83	Medical scientists
#		Health Diagnosing Occupations:
#	84	Physicians
#	85	Dentists
#	86	Veterinarians
#	87	Optometrists
#	88	Podiatrists
#	89	Other health and therapy
#		Health Assessment and Treating Occupations:
#	95	Registered nurses
#	96	Pharmacists
#	97	Dietitians and nutritionists
#		Therapists:
#	98	Respiratory therapists
#	99	Occupational therapists
#	103	Physical therapists
#	104	Speech therapists
#	105	Therapists, n.e.c.
#	106	Physicians' assistants
#		Teachers, Postsecondary:
#	113	Earth, environmental, and marine science instructors
#	114	Biological science instructors
#	115	Chemistry instructors
#	116	Physics instructors
#	118	Psychology instructors
#	119	Economics instructors
#	123	History instructors
#	125	Sociology instructors
#	127	Engineering instructors
#	128	Math instructors
#	139	Education instructors
#	145	Law instructors
#	147	Theology instructors
#	149	Home economics instructors
#	150	Humanities profs/instructors, college, nec
#	154	Subject instructors (HS/college)
#		Teachers, Except Postsecondary:
#	155	Kindergarten and earlier school teachers
#	156	Primary school teachers
#	157	Secondary school teachers
#	158	Special education teachers
#	159	Teachers , n.e.c.
#	163	Vocational and educational counselors
#		Librarians, Archivists, and Curators:
#	164	Librarians
#	165	Archivists and curators
#		Social Scientists and Urban Planners:
#	166	Economists, market researchers, and survey researchers
#	167	Psychologists
#	168	Sociologists
#	169	Social scientists, n.e.c.
#	173	Urban and regional planners
#		Social, Recreation, and Religious Workers:
#	174	Social workers
#	175	Recreation workers
#	176	Clergy and religious workers
#		Lawyers and Judges:
#	178	Lawyers
#	179	Judges
#		Writers, Artists, Entertainers, and Athletes:
#	183	Writers and authors
#	184	Technical writers
#	185	Designers
#	186	Musician or composer
#	187	Actors, directors, producers
#	188	Art makers: painters, sculptors, craft-artists, and print-makers
#	189	Photographers
#	193	Dancers
#	194	Art/entertainment performers and related
#	195	Editors and reporters
#	198	Announcers
#	199	Athletes, sports instructors, and officials
#	200	Professionals, n.e.c.
#		TECHNICAL, SALES, AND ADMINISTRATIVE SUPPORT OCCUPATIONS
#		Technicians and Related Support Occupations
#		Health Technologists and Technicians:
#	203	Clinical laboratory technologies and technicians
#	204	Dental hygenists
#	205	Health record tech specialists
#	206	Radiologic tech specialists
#	207	Licensed practical nurses
#	208	Health technologists and technicians, n.e.c.
#		Technologists and Technicians, Except Health
#		Engineering and Related Technologists and Technicians:
#	213	Electrical and electronic (engineering) technicians
#	214	Engineering technicians, n.e.c.
#	215	Mechanical engineering technicians
#	217	Drafters
#	218	Surveyors, cartographers, mapping scientists and technicians
#	223	Biological technicians
#		Science Technicians:
#	224	Chemical technicians
#	225	Other science technicians
#		Technicians, Except Health, Engineering, and Science:
#	226	Airplane pilots and navigators
#	227	Air traffic controllers
#	228	Broadcast equipment operators
#	229	Computer software developers
#	233	Programmers of numerically controlled machine tools
#	234	Legal assistants, paralegals, legal support, etc
#	235	Technicians, n.e.c.
#		Sales Occupations:
#	243	Supervisors and proprietors of sales jobs
#		Sales Representatives, Finance and Business Services:
#	253	Insurance sales occupations
#	254	Real estate sales occupations
#	255	Financial services sales occupations
#	256	Advertising and related sales jobs
#		Sales Representatives, Commodities:
#	258	Sales engineers
#	274	Salespersons, n.e.c.
#	275	Retail sales clerks
#	276	Cashiers
#	277	Door-to-door sales, street sales, and news vendors
#		Sales Related Occupations:
#	283	Sales demonstrators / promoters / models
#		Administrative Support Occupations, Including Clerical
#		Supervisors, Administrative Support Occupations:
#	303	Office supervisors
#		Computer Equipment Operators:
#	308	Computer and peripheral equipment operators
#		Secretaries, Stenographers, and Typists:
#	313	Secretaries
#	314	Stenographers
#	315	Typists
#		Information Clerks:
#	316	Interviewers, enumerators, and surveyors
#	317	Hotel clerks
#	318	Transportation ticket and reservation agents
#	319	Receptionists
#	323	Information clerks, nec
#		Records Processing Occupations, Except Financial:
#	326	Correspondence and order clerks
#	328	Human resources clerks, except payroll and timekeeping
#	329	Library assistants
#	335	File clerks
#	336	Records clerks
#		Financial Records Processing Occupations:
#	337	Bookkeepers and accounting and auditing clerks
#	338	Payroll and timekeeping clerks
#	343	Cost and rate clerks (financial records processing)
#	344	Billing clerks and related financial records processing
#		Duplicating, Mail, and Other Office Machine Operators:
#	345	Duplication machine operators / office machine operators
#	346	Mail and paper handlers
#	347	Office machine operators, n.e.c.
#		Communications Equipment Operators:
#	348	Telephone operators
#	349	Other telecom operators
#		Mail and Message Distributing Occupations:
#	354	Postal clerks, excluding mail carriers
#	355	Mail carriers for postal service
#	356	Mail clerks, outside of post office
#	357	Messengers
#		Material Recording, Scheduling, and Distributing Clerks:
#	359	Dispatchers
#	361	Inspectors, n.e.c.
#	364	Shipping and receiving clerks
#	365	Stock and inventory clerks
#	366	Meter readers
#	368	Weighers, measurers, and checkers
#	373	Material recording, scheduling, production, planning, and expediting clerks
#		Adjusters and Investigators:
#	375	Insurance adjusters, examiners, and investigators
#	376	Customer service reps, investigators and adjusters, except insurance
#	377	Eligibility clerks for government programs; social welfare
#	378	Bill and account collectors
#		Miscellaneous Administrative Support Occupations:
#	379	General office clerks
#	383	Bank tellers
#	384	Proofreaders
#	385	Data entry keyers
#	386	Statistical clerks
#	387	Teacher's aides
#	389	Administrative support jobs, n.e.c.
#		SERVICE OCCUPATIONS
#		Private Household Occupations:
#	405	Housekeepers, maids, butlers, stewards, and lodging quarters cleaners
#	407	Private household cleaners and servants
#		Protective Service Occupations
#		Supervisors, Protective Service Occupations:
#	415	Supervisors of guards
#		Firefighting and Fire Prevention Occupations:
#	417	Fire fighting, prevention, and inspection
#		Police and Detectives:
#	418	Police, detectives, and private investigators
#	423	Other law enforcement: sheriffs, bailiffs, correctional institution officers
#		Guards:
#	425	Crossing guards and bridge tenders
#	426	Guards, watchmen, doorkeepers
#	427	Protective services, n.e.c.
#		Service Occupations, Except Protective and Household
#		Food Preparation and Service Occupations:
#	434	Bartenders
#	435	Waiter/waitress
#	436	Cooks, variously defined
#	438	Food counter and fountain workers
#	439	Kitchen workers
#	443	Waiter's assistant
#	444	Misc food prep workers
#		Health Service Occupations:
#	445	Dental assistants
#	446	Health aides, except nursing
#	447	Nursing aides, orderlies, and attendants
#		Cleaning and Building Service Occupations, Except Households:
#	448	Supervisors of cleaning and building service
#	453	Janitors
#	454	Elevator operators
#	455	Pest control occupations
#		Personal Service Occupations:
#	456	Supervisors of personal service jobs, n.e.c.
#	457	Barbers
#	458	Hairdressers and cosmetologists
#	459	Recreation facility attendants
#	461	Guides
#	462	Ushers
#	463	Public transportation attendants and inspectors
#	464	Baggage porters
#	465	Welfare service aides
#	468	Child care workers
#	469	Personal service occupations, nec
#		FARMING, FORESTRY, AND FISHING OCCUPATIONS
#		Farm Operators and Managers:
#	473	Farmers (owners and tenants)
#	474	Horticultural specialty farmers
#	475	Farm managers, except for horticultural farms
#	476	Managers of horticultural specialty farms
#		Other Agricultural and Related Occupations:
#		Farm Occupations, Except Managerial:
#	479	Farm workers
#	483	Marine life cultivation workers
#	484	Nursery farming workers
#		Related Agricultural Occupations:
#	485	Supervisors of agricultural occupations
#	486	Gardeners and groundskeepers
#	487	Animal caretakers except on farms
#	488	Graders and sorters of agricultural products
#	489	Inspectors of agricultural products
#		Forestry and Logging Occupations:
#	496	Timber, logging, and forestry workers
#		Fishers, Hunters, and Trappers:
#	498	Fishers, hunters, and kindred
#		PRECISION PRODUCTION, CRAFT, AND REPAIR OCCUPATIONS
#		Mechanics and Repairers:
#	503	Supervisors of mechanics and repairers
#		Mechanics and Repairers, Except Supervisors
#		Vehicle and Mobile Equipment Mechanics and Repairers:
#	505	Automobile mechanics
#	507	Bus, truck, and stationary engine mechanics
#	508	Aircraft mechanics
#	509	Small engine repairers
#	514	Auto body repairers
#	516	Heavy equipment and farm equipment mechanics
#	518	Industrial machinery repairers
#	519	Machinery maintenance occupations
#		Electrical and Electronic Equipment Repairers:
#	523	Repairers of industrial electrical equipment
#	525	Repairers of data processing equipment
#	526	Repairers of household appliances and power tools
#	527	Telecom and line installers and repairers
#	533	Repairers of electrical equipment, n.e.c.
#	534	Heating, air conditioning, and refigeration mechanics
#		Miscellaneous Mechanics and Repairers:
#	535	Precision makers, repairers, and smiths
#	536	Locksmiths and safe repairers
#	538	Office machine repairers and mechanics
#	539	Repairers of mechanical controls and valves
#	543	Elevator installers and repairers
#	544	Millwrights
#	549	Mechanics and repairers, n.e.c.
#		Construction Trades
#		Supervisors, Construction Occupations:
#	558	Supervisors of construction work
#		Construction Trades, Except Supervisors:
#	563	Masons, tilers, and carpet installers
#	567	Carpenters
#	573	Drywall installers
#	575	Electricians
#	577	Electric power installers and repairers
#	579	Painters, construction and maintenance
#	583	Paperhangers
#	584	Plasterers
#	585	Plumbers, pipe fitters, and steamfitters
#	588	Concrete and cement workers
#	589	Glaziers
#	593	Insulation workers
#	594	Paving, surfacing, and tamping equipment operators
#	595	Roofers and slaters
#	596	Sheet metal duct installers
#	597	Structural metal workers
#	598	Drillers of earth
#	599	Construction trades, n.e.c.
#		Extractive Occupations:
#	614	Drillers of oil wells
#	615	Explosives workers
#	616	Miners
#	617	Other mining occupations
#		Precision Production Occupations:
#	628	Production supervisors or foremen
#		Precision Metal Working Occupations:
#	634	Tool and die makers and die setters
#	637	Machinists
#	643	Boilermakers
#	644	Precision grinders and filers
#	645	Patternmakers and model makers
#	646	Lay-out workers
#	649	Engravers
#	653	Tinsmiths, coppersmiths, and sheet metal workers
#		Precision Woodworking Occupations:
#	657	Cabinetmakers and bench carpenters
#	658	Furniture and wood finishers
#	659	Other precision woodworkers
#		Precision Textile, Apparel, and Furnishings Machine Workers:
#	666	Dressmakers and seamstresses
#	667	Tailors
#	668	Upholsterers
#	669	Shoe repairers
#	674	Other precision apparel and fabric workers
#		Precision Workers, Assorted Materials:
#	675	Hand molders and shapers, except jewelers
#	677	Optical goods workers
#	678	Dental laboratory and medical appliance technicians
#	679	Bookbinders
#	684	Other precision and craft workers
#		Precision Food Production Occupations:
#	686	Butchers and meat cutters
#	687	Bakers
#	688	Batch food makers
#		Precision Inspectors, Testers, and Related Workers:
#	693	Adjusters and calibrators
#		Plant and System Operators:
#	694	Water and sewage treatment plant operators
#	695	Power plant operators
#	696	Plant and system operators, stationary engineers
#	699	Other plant and system operators
#		OPERATORS, FABRICATORS, AND LABORERS
#		Machine Operators, Assemblers, and Inspectors
#		Machine Operators and Tenders, Except Precision
#		Metal Working and Plastic Working Machine Operators:
#	703	Lathe, milling, and turning machine operatives
#	706	Punching and stamping press operatives
#	707	Rollers, roll hands, and finishers of metal
#	708	Drilling and boring machine operators
#	709	Grinding, abrading, buffing, and polishing workers
#	713	Forge and hammer operators
#	717	Fabricating machine operators, n.e.c.
#		Metal and Plastic Processing Machine Operators:
#	719	Molders, and casting machine operators
#	723	Metal platers
#	724	Heat treating equipment operators
#		Woodworking Machine Operators:
#	726	Wood lathe, routing, and planing machine operators
#	727	Sawing machine operators and sawyers
#	728	Shaping and joining machine operator (woodworking)
#	729	Nail and tacking machine operators  (woodworking)
#	733	Other woodworking machine operators
#		Printing Machine Operators:
#	734	Printing machine operators, n.e.c.
#	735	Photoengravers and lithographers
#	736	Typesetters and compositors
#		Textile, Apparel, and Furnishings Machine Operators:
#	738	Winding and twisting textile/apparel operatives
#	739	Knitters, loopers, and toppers textile operatives
#	743	Textile cutting machine operators
#	744	Textile sewing machine operators
#	745	Shoemaking machine operators
#	747	Pressing machine operators (clothing)
#	748	Laundry workers
#	749	Misc textile machine operators
#		Machine Operators, Assorted Materials:
#	753	Cementing and gluing maching operators
#	754	Packers, fillers, and wrappers
#	755	Extruding and forming machine operators
#	756	Mixing and blending machine operatives
#	757	Separating, filtering, and clarifying machine operators
#	759	Painting machine operators
#	763	Roasting and baking machine operators (food)
#	764	Washing, cleaning, and pickling machine operators
#	765	Paper folding machine operators
#	766	Furnace, kiln, and oven operators, apart from food
#	768	Crushing and grinding machine operators
#	769	Slicing and cutting machine operators
#	773	Motion picture projectionists
#	774	Photographic process workers
#	779	Machine operators, n.e.c.
#		Fabricators, Assemblers, and Hand Working Occupations:
#	783	Welders and metal cutters
#	784	Solderers
#	785	Assemblers of electrical equipment
#	789	Hand painting, coating, and decorating occupations
#		Production Inspectors, Testers, Samplers, and Weighers:
#	796	Production checkers and inspectors
#	799	Graders and sorters in manufacturing
#		Transportation and Material Moving Occupations
#		Motor Vehicle Operators:
#	803	Supervisors of motor vehicle transportation
#	804	Truck, delivery, and tractor drivers
#	808	Bus drivers
#	809	Taxi cab drivers and chauffeurs
#	813	Parking lot attendants
#		Transportation Occupations, Except Motor Vehicles
#		Rail Transportation Occupations:
#	823	Railroad conductors and yardmasters
#	824	Locomotive operators (engineers and firemen)
#	825	Railroad brake, coupler, and switch operators
#		Water Transportation Occupations:
#	829	Ship crews and marine engineers
#	834	Water transport infrastructure tenders and crossing guards
#		Material Moving Equipment Operators:
#	844	Operating engineers of construction equipment
#	848	Crane, derrick, winch, and hoist operators
#	853	Excavating and loading machine operators
#	859	Misc material moving occupations
#		Helpers, Construction and Extractive Occupations:
#	865	Helpers, constructions
#	866	Helpers, surveyors
#	869	Construction laborers
#	874	Production helpers
#		Freight, Stock, and Material Handlers:
#	875	Garbage and recyclable material collectors
#	876	Materials movers: stevedores and longshore workers
#	877	Stock handlers
#	878	Machine feeders and offbearers
#	883	Freight, stock, and materials handlers
#	885	Garage and service station related occupations
#	887	Vehicle washers and equipment cleaners
#	888	Packers and packagers by hand
#	889	Laborers outside construction
#		MILITARY OCCUPATIONS
#	905	Military
#		EXPERIENCED UNEMPLOYED NOT CLASSIFIED BY OCCUPATION
#	991	Unemployed
#	999	Unknown

