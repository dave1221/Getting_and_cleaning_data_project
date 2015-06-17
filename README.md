# READ ME : How the script work

##Before you read:
Considering the purpose of this project is to be graded by peers, and this course is Chinese version. Just in case there are chinese peers, this readme instruction are both in English and Chinese.

考虑到这个项目是同学互评，而且是中文课程，所以说明书会有中文和英文



Updated time 2015-06-17 18:03:13 ; R version R version 3.2.0 (2015-04-16) ; Platform x86_64-apple-darwin13.4.0

更新时间 2015-06-17 18:03:13 ; R 版本 R version 3.2.0 (2015-04-16); 平台 x86_64-apple-darwin13.4.0

#Background 

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

The purpose of this project is to prepare tidy data that can be used for later analysis. Download the [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


现在，所有数据科学中最令人兴奋的领域之一就是可穿戴计算请看[这篇文章](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)。公司（例如，Fitbit、Nike和JawboneUp）正在竞相发展最先进的算法来吸引新用户。与课程网站关联的数据表示从三星Galaxy S智能手机的加速器上收集的数据。完整的解释可在获得数据的网站上获取：

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

这项课程的目的是准备用于后续分析的整洁数据, 可以从[这里](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)下载

#Download and Unzip the Data
下载和解压数据


```r
if(!file.exists("/data")) dir.create("./data")
```

```
## Warning in dir.create("./data"): './data' already exists
```

```r
Url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, "./data/UCI HAR Dataset.zip", method = "curl")
unzip("./data/UCI HAR Dataset.zip",exdir = "./data")
```

#Read data
读数据


```r
wd<-"./data/UCI HAR Dataset"
Teset<-read.table(file.path(wd, "test/X_test.txt"))
Telabel<-read.table(file.path(wd, "test/y_test.txt"))
Tesubject<-read.table(file.path(wd, "test/subject_test.txt"))
Trset<-read.table(file.path(wd, "train/X_train.txt"))
Trlabel<-read.table(file.path(wd, "train/y_train.txt"))
Trsubject<-read.table(file.path(wd, "train/subject_train.txt"))
```

Inside: Te means test, Tr means train, label means activity label
其中：Te表示测试，Tr表示培训，label表示活动标签

#Merges the training and the test sets to create one data set.
整合培训和测试集，创建一个数据集


```r
te<-cbind(Tesubject,Telabel,Teset)
tr<-cbind(Trsubject,Trlabel,Trset)
da<-rbind(tr,te)
```

da means raw data frame to be processed
da表示要处理的原始数据框

#Extracts only the measurements on the mean and standard deviation for each measurement. 
仅提取测量的平均值以及每次测量的标准差.

Note that characters in feature.txt include "mean" are "...mean()" and "...meanFreq()"
注意到在feature.txt中包含mean的字符有"...mean()" 和 "...meanFreq()"


```r
feature<-read.table(file.path(wd,"features.txt"))
meancol<-setdiff(grep("mean", feature[,2]),grep("meanFreq", feature[,2]))
stdcol<-grep("std", feature[,2])
Col<-sort(c(meancol,stdcol))+2
da<-da[,c(1,2,Col)]
```

#Uses descriptive activity names and descriptive variable names. 
使用描述性活动名和变量名


```r
colnames(da)<-c("subject","activity",as.character(feature[Col-2,2]))
activityname<-read.table(file.path(wd,"activity_labels.txt"), col.names = c("activity","Activitynames"))
da<-merge(da,activityname,by="activity",all=T)
da<-da[,c(69,2,3:68)]
```

#From the data set in last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

从上一步的数据集中，针对每个活动和每个主题使用每个表里的平均值建立第2个独立的整洁数据集.


```r
library(reshape2)
da<-melt(da,c("Activitynames","subject"))
da<-acast(da, variable~Activitynames~subject, mean)
da<-as.data.frame(da)
da<-t(da)
da<-format(da, nsmall = 10)
```


#upload data set as a txt file 
上传txt格式的数据


```r
write.table(da,"run_analysis.txt",col.names = F,row.names = F)
```

Thank you for your time !

谢谢！

License:
===============================================================================================
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
