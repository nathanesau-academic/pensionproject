# options(warn=-1)
# 
# activeAgeDist_2012 <- read.csv("C:/Users/nate/Dropbox/SFU/Acma475/Project/images/activeAgeDist_2012.csv", header=FALSE, stringsAsFactors=FALSE)
# activeAgeDist_2013 <- read.csv("C:/Users/nate/Dropbox/SFU/Acma475/Project/images/activeAgeDist_2013.csv", header=FALSE, stringsAsFactors=FALSE)
# 
# males.ages = numeric(0)
# females.ages = numeric(0)
# 
# for(i in 1:45) {
#   temp = activeAgeDist_2012[[1]][i]
#   if(temp=="M") {
#     activeAgeDist_2012[[1]][i] = 1
#     males.ages = c(males.ages, activeAgeDist_2012[[2]][i])
#   }
#   else {  # temp=="F"
#     activeAgeDist_2012[[1]][i] = 0
#     females.ages = c(females.ages, activeAgeDist_2012[[2]][i])
#   }
# }
# 
# barplot(rbind(table(males.ages-(males.ages-0.00000000000001)%%5), table(females.ages-(females.ages-0.00000000000001)%%5)), axisnames=TRUE,
#         xlab="Age", ylab="Frequency", col=c("light blue", "pink"))
# 
# males.ages = numeric(0)
# females.ages = numeric(0)
# 
# for(i in 1:41) {
#   temp = activeAgeDist_2013[[1]][i]
#   if(temp=="M") {
#     activeAgeDist_2013[[1]][i] = 1
#     males.ages = c(males.ages, activeAgeDist_2013[[2]][i])
#   }
#   else {  # temp=="F"
#     activeAgeDist_2013[[1]][i] = 0
#     females.ages = c(females.ages, activeAgeDist_2013[[2]][i])
#   }
# }
# 
# barplot(rbind(table(males.ages-(males.ages-0.00000000000001)%%5), table(females.ages-(females.ages-0.00000000000001)%%5)), axisnames=TRUE,
#         xlab="Age", ylab="Frequency", col=c("light blue", "pink"))
#
# m2012 = c(rep("Active", 45), rep("Deferred", 5), rep("Pensioner", 10))
# m2013 = c(rep("Active", 41), rep("Deferred", 6), rep("Pensioner", 14))
# barplot(table(m2013), col="light pink")
# barplot(table(m2012), col="light blue", add=TRUE, axisnames=FALSE)
# misc = rep("Active", 41)
# barplot(table(misc), col="light pink", add=TRUE, axisnames=FALSE)
salaryAssumption <- read.csv("C:/Users/nate/Dropbox/SFU/Acma475/Project/images/salaryAssumption.csv")
plot(salaryAssumption[[1]], type='l', col="black")
plot(salaryAssumption)