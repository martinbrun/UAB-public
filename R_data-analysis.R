#PUBLIC SECTOR ECONOMICS - INTRODUCTION TO R: ANALYZING DATA
#UNIVERSITAT AUTONOMA DE BARCELONA
#SEPTEMBER 2020
#MARTÍN BRUN

#First, we load a dataset
mtcars <- read_excel("C:/Users/1514133/Google Drive/Martin/Trabajo/UAB/Public Economics/Scripts/mtcars.xlsx")
#data comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).
#data source: 1974 Motor Trend US magazine
#mtcars is a commonly used dataset in Data Science. you can find plenty of examples built over this dataset
#the dataset is even built into R. you just have to type "mtcars" to access in R

#########################################
#SUMMARY STATISTICS######################
#########################################

str(mtcars) #str compactly displays the structure of the object
view(mtcars) #view opens a tab with the data frame. same results as clicking the data in the Environment

#SUM
sum(mtcars$cyl) #sum of mtcars$cyl, the cyl column in the mtcars data frame
colSums(mtcars[3:5]) #sum of columns 3 to 5

#MEAN
mean(mtcars$mpg) #mean of mtcars$mpg, the mpg column in the mtcars data frame
colMeans(mtcars[c("mpg","hp")]) #mean of columns "mpg" and "hp"

#STANDARD DEVIATION
sd(mtcars$mpg) #standard deviation of mtcars$mpg, the mpg column in the mtcars data frame

#RANGE
range(mtcars$mpg) #maximum and minimum values of mtcars$mpg, the mpg column in the mtcars data frame

#QUANTILES
quantile(mtcars$mpg) #quantile values of mtcars$mpg, the mpg column in the mtcars data frame
quantile(mtcars$mpg, probs=(c(0.33,0.66))) #p33 and p66 values of mtcars$mpg

#########################################
#PLOTTING DATA###########################
#########################################

plot(mtcars$hp, mtcars$mpg, type = "p") #plot "mpg" over "hp"  

plot(mtcars$hp, mtcars$mpg, type = "p", 
     xlab="Miles per gallon",
     ylab="Horse power") #plot "mpg" over "hp" again, adding x-axis and y-axis labels  

title("Relationship between Horse Power and Miles per gallon") #add a title to plot
lines(stats::lowess(mtcars$mpg, mtcars$hp)) #add smooth line to plot. stats:: calls a function within the stats package
lines(stats::lowess(mtcars$mpg, mtcars$hp),
      col="blue") #add again the smooth line to plot, set color to blue


legend("bottomleft", lty = 1, cex = 1.2, lwd = 2,
       legend = c("Without punishment", "With punishment"),
       col = c("blue", "red"))
