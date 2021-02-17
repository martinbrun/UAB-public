#PUBLIC SECTOR ECONOMICS - INTRODUCTION TO R: DATA MANIPULATION
#UNIVERSITAT AUTONOMA DE BARCELONA
#SEPTEMBER 2020
#MARTÍN BRUN

#########################################
#VECTORS#################################
#########################################

#CONSTRUCTION
##Types of variables
my_numeric <- 42	      		            #Numeric 
my_character1 <- "universe"	            #Character: string variable. We need to specify term between " "
my_logical <- FALSE 			  	          #Logical: variable with only two values: TRUE or FALSE
my_numeric2 <- as.numeric(FALSE)        #Numeric: as.numeric treats values as numeric. TRUE=1, and FALSE=0
my_factor <- as.factor("France")        #Factor: special case of Character. Use to represent categorical variables. We need to tell R that a string is a factor


##Checking classes
class(my_numeric) #class returns the class of the object 
class(my_character1)
class(my_logical)
class(my_factor)

##Types of vectors
numeric_vector1 <- c(1, 10, 50)			  #Numeric
numeric_vector2 <- c(2, 20, 100)		  #Numeric
character_vector <- c("a", "b", "c")	#Character
boolean_vector <- c(TRUE,FALSE,TRUE)	#Logical

##Assigning vector as names
names(numeric_vector1) <- character_vector

##Selecting element within vector
numeric_second1	<- numeric_vector1[2]												#Allows choosing position of element
numeric_finals1	<- numeric_vector1[2:3]											#Allows choosing various elements 
numeric_finals1	<- numeric_vector1[c("b","c")]							#Allows choosing various elements by their names
numeric_comparisson1 <- numeric_vector1[numeric_vector1>0]	#Allows choosing various elements by complying with a condition

#CALCULATIONS
##Sum	
total <- sum(numeric_vector1 + numeric_vector2) #sum returns the sum of all values in the arguments

#MORE ABOUT FACTORS
###Nominal levels: There is not an inherent ordering of the levels
country_vector <- c("France", "United Kingdom", "Germany", "Italy")
factor_country_vector <- factor(country_vector) #factor encodes a vector as a factor

##Ordinal LEVELS: There is notan inherent ordering of the levels
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High")) #We can tell R which is the ordering of the levels directly when creating the vector

###Specifying the levels 
levels(factor_temperature_vector) <- c("Lowest","Middle","Highest") #levels changes the name of levels

#########################################
#MATRICES################################
#########################################

#CONSTRUCTION
##Inputs
new_hope <- c(460.998, 314.4) #US and nonUS box office in million USD for Star Wars: A New Hope (1977)
empire_strikes <- c(290.475, 247.900) #US and nonUS box office in million USD for Star Wars: The Empire Strikes Back (1980)
return_jedi <- c(309.306, 165.8) #US and nonUS box office in million USD for Star Wars: Return of the Jedi (1983)

##Constructing matrix
star_wars_matrix <- matrix(c(new_hope, empire_strikes, return_jedi), nrow = 3, byrow = TRUE) #matrix creates a matrix from inputs. We need to specify the structure of the inputs we use to get desired results 
box_office = star_wars_matrix #We create a copy of star_wars_matrix 

##Naming the columns
region <- c("US", "non-US")
colnames(star_wars_matrix) <- region #colnames sets the column names of a matrix

##Name the rows
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")
rownames(star_wars_matrix) <- titles #rownames sets the row names of a matrix

##Naming the columns and rows when defining matrix
star_wars_matrix2 <- matrix(box_office, nrow = 3, byrow = TRUE,dimnames = list(c("A New Hope","The Empire Strikes Back", "Return of the Jedi"), c("US", "non-US"))) #matrix creates a matrix from a given set of values 
rm(star_wars_matrix2) #rm deletes object

##Binding
all_wars_matrix <- cbind(star_wars_matrix,worldwide_vector) #Binding by columns. rbind performs the same, by rows

#SELECTING PARTS OF MATRICES
non_us_all <- all_wars_matrix[,2]

#CALCULATIONS
worldwide_vector <- rowSums(star_wars_matrix) #rowSums gives totals by rows. colSums performs the same, by columns

#########################################
#DATA FRAMES#############################
#########################################

#CONSTRUCTION
#Defining vectors
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune") #Names of Solar System planets
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant") #Types of planets
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883) #Diameter of planets from the Solar System, as ratio of Earth diameter
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE) #Posession of rings of planets from the Solar System

#Construncting data frame
planets_df <- data.frame(name,type,diameter,rings) #data.frame creates a data frame from arguments

#Ordering
positions <-  order(planets_df$diameter) #order rearranges objects into ascending/descending order
planets_df[positions,]

#EXPLORATION
##Print selected observations
head(planets_df)                          #head prints first observations and header
tail(planets_df)                          #tail prints last observations and header	
planets_df[1:5,"diameter"]                #Select selected rows from selected column
planets_df$diameter                       #Select selected column
subset(planets_df, subset= diameter < 1)	#Select planets with diameter < 1

##Structure
str(planets_df)							              #str prints: Number of observations; Number of variables; Variables names; Data type of each variable; First observations

#########################################
#LISTS###################################
#########################################

my_vector <- 1:10 
my_matrix <- matrix(1:9, ncol = 3)
my_df <- planets_df[1:6,]
my_list <- list(vec=my_vector, mat=my_matrix, df=my_df) #list creates a list from arguments

#Select elements
my_list$vec 								#Select my_vector
my_list[["vec"]]  					#Select my_vector
my_list[[1]]								#Select my_vector

#########################################
#READING DATA############################
#########################################

#IMPORTANT: you MUST change ALL the "/" in the filepath for "\"
#SETTING WORKING DIRECTORY
setwd("YOUR_FILE_PATH!!") #setwd sets the filepath for working: here is from where input files are loaded and output files are stored

#READING FROM EXCEL
data <- read_excel("Public-goods-experimental-data.xlsx",range = "A2:Q12") #read_excel reads xls and xlsx files