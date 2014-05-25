#check if files exist within directory

workingDir<-".";

if(file.exists(workingDir)){

#set working directory

setwd(workingDir)

#strings as factors?? No!

options(stringsAsFactors = FALSE)

#load train activities

train_y<-read.table("train/y_train.txt")

names(train_y)<-c("activity")

#load train subjects

train_s<-read.table("train/subject_train.txt")

names(train_s)<-c("subject")

#load train data

train<-read.table("train/X_train.txt")

q<-read.table("features.txt")

names(q)<-c("num","variable")

names(train)<-q[["variable"]]

#subset train data to isolate means and stds

train_new1<-train[ ,grep("mean",names(train))]

train_new1<-train_new1[ ,-grep("meanFreq",names(train_new1))]

train_new2<-train[ ,grepl("std",names(train))]

train_new<-data.frame(train_new1,train_new2)

q<-data.frame(c(rep("train",dim(train_new)[1])))

names(q)<-c("type")

new_train<-data.frame(q,train_s,train_y,train_new)

#View(new_train)
#dim(new_train) : 7352 rows by 69 cols (63 for data and 3 for "type","subject","activity"

#do as above for the test data

#load test activities

test_y<-read.table("test/y_test.txt")

names(test_y)<-c("activity")

#load test subjects

test_s<-read.table("test/subject_test.txt")

names(test_s)<-c("subject")

#load test data

test<-read.table("test/X_test.txt")

q<-read.table("features.txt")

names(q)<-c("num","variable")

names(test)<-q[["variable"]]

#subset test data to isolate means and stds

test_new1<-test[ ,grep("mean",names(test))]

test_new1<-test_new1[ ,-grep("meanFreq",names(test_new1))]

test_new2<-test[ ,grepl("std",names(test))]

test_new<-data.frame(test_new1,test_new2)

q<-data.frame(c(rep("test",dim(test_new)[1])))

names(q)<-c("type")

new_test<-data.frame(q,test_s,test_y,test_new)

#View(new_test)
#dim(new_test) # 2947 rows by 69 cols (63 for data and 3 for "type","subject","activity"

#combine data to form new dataframe

all<-rbind(new_train,new_test)

#View(all)
#dim(all) # 7352 + 2947 = 10299 rows by 69 cols

#now attempt to create descriptive activity labels

activity<-read.table("activity_labels.txt")

#create tidy dataframe

tidy<-data.frame()

for(i in 1:30){
  for(j in 1:6){
    myrow<-list()
    new<-subset(all,all[["subject"]]==i & all[["activity"]]==j)
    myrow<-append(myrow,i)
    myrow<-append(myrow,j)
    myrow<-append(myrow,activity[["V2"]][j])
    for(k in 4:69){
      q<-mean(new[,k])
      myrow<-append(myrow,q)
    }
    tidy<-rbind(tidy,myrow)
  }
}

#q<-read.table("features.txt")
#names(q)<-c("num","variable")
#names(test)<-q[["variable"]]

#give tidy data cols a name

names(tidy)<-append(c("subject","activity","activity_names"),names(all)[4:69])

#reset the row.names col

rownames(tidy) <- NULL

#View(tidy)
#dim(tidy) # 6 activities x 30 subjects = 180 rows and 69 cols (63 data + "subject", "activity", "activity_names") 
#names(tidy)

#write tidy data to file

write.table(tidy,file="tidy4.txt")

} else{

print("Cannot find data files");

}
