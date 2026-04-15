
#################################################################
##             Exercise for 1.3 - Basics and Syntax            ##
#################################################################


# Question 1: Create two numeric variables x1 and x2, two character variables y1 and y2. 
# Use *, /, and + operations on them to see what you will get.



# Question 2: Create a numeric vector x3 = c(1,2,3,4,5), 
# calculate the average value, sum, and variance of it.



# Scroll down to view solutions

































###########################################################################
###########################################################################
###                                                                     ###
###                              SOLUTIONS                              ###
###                                                                     ###
###########################################################################
###########################################################################


##################################################################
##                          Question 1                          ##
##################################################################
# Possible solution for Question 1: 
x1 = 20
x2 = 4

x1+x2
x1*x2

x1/x2

y1 = c("basic","syntax")
y2 = "R"

y1+y2 # non-numeric argument to binary operator
c(y1,y2)



##################################################################
##                          Question 2                          ##
##################################################################
# Possible solution for Question 2: 
x3 = c(1,2,3,4,5)
mean(x3)
sum(x3)
var(x3)

