library(ggplot2)

# Nb<-testActMes$Nb
# 
# num<-as.data.frame(Nb)
# # ggplot(testActMes, aes(x=Nb)) + 
# #   geom_histogram(color="black", fill="white")
# ggplot(num, aes(x=Nb)) + 
#   geom_histogram(color="black", fill="white")
# 
# 
# qplot(testActMes, data = Nb, geom = "histogram")
# ggplot(donnees, aes(x = cnt)) + geom_histogram()
str(testActMes3)

graph <- ggplot(data = testActMes3, mapping = aes(x=datePrev)) + geom_histogram()

graph