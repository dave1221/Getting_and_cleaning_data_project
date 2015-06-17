#download and unzip
if(!file.exists("/data")) dir.create("./data")
Url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, "./data/UCI HAR Dataset.zip", method = "curl")
unzip("./data/UCI HAR Dataset.zip",exdir = "./data")
#read
wd<-"./data/UCI HAR Dataset"
Teset<-read.table(file.path(wd, "test/X_test.txt"))
Telabel<-read.table(file.path(wd, "test/y_test.txt"))
Tesubject<-read.table(file.path(wd, "test/subject_test.txt"))
Trset<-read.table(file.path(wd, "train/X_train.txt"))
Trlabel<-read.table(file.path(wd, "train/y_train.txt"))
Trsubject<-read.table(file.path(wd, "train/subject_train.txt"))
#merge
te<-cbind(Tesubject,Telabel,Teset)
tr<-cbind(Trsubject,Trlabel,Trset)
da<-rbind(tr,te)
# mean and sd  , found that: mean and meanFreq
feature<-read.table(file.path(wd,"features.txt"))
meancol<-setdiff(grep("mean", feature[,2]),grep("meanFreq", feature[,2]))
stdcol<-grep("std", feature[,2])
Col<-sort(c(meancol,stdcol))+2
da<-da[,c(1,2,Col)]
#names
colnames(da)<-c("subject","activity",as.character(feature[Col-2,2]))
activityname<-read.table(file.path(wd,"activity_labels.txt"),col.names = c("activity","Activitynames"))
da<-merge(da,activityname,by="activity",all=T)
da<-da[,c(69,2,3:68)]
#tidy data set
library(reshape2)
da<-melt(da,c("Activitynames","subject"))
da<-acast(da, variable~Activitynames~subject, mean)
da<-as.data.frame(da)
da<-t(da)
da<-format(da, nsmall = 10)
write.table(da,"run_analysis.txt",col.names = F,row.names = F)

