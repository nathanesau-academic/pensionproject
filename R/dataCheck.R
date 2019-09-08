data2012 <- read.csv("~/Dropbox/SFU/Past/1147/Acma475/Project/DataCheck/data2012.csv")
data2013 <- read.csv("~/Dropbox/SFU/Past/1147/Acma475/Project/DataCheck/data2013.csv")

salaries2012 = data2012[,5]
salaries2013 = data2013[,5]

members2012 = as.character(data2012[,1]) # analyze active members
members2013 = as.character(data2013[,1])
n2012 = length(members2012) # number of members in 2012
n2013 = length(members2013) # number of members in 2013

expsalaries = numeric(0)
actsalaries = numeric(0)

same = 0 # number of same members in 2012 and 2013
errors = 0 # number of inconsistencies in the data
member2013 = 0 # init
searches = 0 # efficiency of algorithm
j = 1 # init
for(i in 1:n2012) {
  member2012 = as.numeric(strsplit(members2012[i],"A")[[1]][2])
  
  j=ifelse(j>1,j-1,j)
  found=FALSE
  while(member2013 <= member2012 && found==FALSE) { # check whether member2012 exists in members2013
    member2013 = as.numeric(strsplit(members2013[j],"A")[[1]][2])
    searches = searches + 1 
    
    if(member2012 == member2013) { # same member both years
      found=TRUE
      commonFields2012 = c(2,3,4,5,6,7,8)
      commonFields2013 = c(2,3,4,6,7,8,9)
      expsalaries = c(expsalaries, salaries2012[i])
      actsalaries = c(actsalaries, salaries2013[j])
      for(m in 1:7) {
        field2012 = as.character(data2012[,commonFields2012[m]])[i]
        field2013 = as.character(data2013[,commonFields2013[m]])[j]
      }
    }
    j=j+1
  }
  
  if(found==TRUE) same = same + 1
}

expsalaries = expsalaries*(1.0425)
error = expsalaries - actsalaries
hist(error, xlab="Error", main="Salary Estimate Error")
#lines(actsalaries, add=TRUE, col='red', type='l')

cat("Number of inconsistencies in data\n", "\t", errors)