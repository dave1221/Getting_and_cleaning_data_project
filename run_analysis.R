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
da1<-da[,c(1,2,Col)]
#names da1
colnames(da1)<-c("subject","activity",as.character(feature[Col-2,2]))
activityname<-read.table(file.path(wd,"activity_labels.txt"),col.names = c("activity","Activitynames"))
da1<-merge(da1,activityname,by="activity",all=T)
da2<-da1[,c(69,2,3:68)]
#tidy data set
library(reshape2)
library(plyr)
da3<-melt(da2,c("Activitynames","subject"))
da4<-acast(da3, variable~Activitynames~subject, mean)
da5<-as.data.frame(da4)
da5<-t(da5)
da5<-as.data.frame(da5)
da6<-cbind(activity=rep(as.character(activityname$Activitynames),each=30),object=rep(1:30,times=6),da5)
nof<-ncol(da6)-2
nda<-list()
for(i in 1:nof){
        f1<-colnames(da6[2+i])
        f2<-strsplit(f1,"-",fixed = T)[[1]]
        nda[[i]]<-cbind(da6[,2:1],feature=f2[1],method=f2[2],axial=f2[3],meanvalue=da6[,2+i])
}
mda<-join_all(nda,type="full")
mda<-mda[order(mda$object,mda$activity,mda$feature,mda$method,mda$axial),]
#write
write.table(mda,"run_analysis.txt",row.names = F)
