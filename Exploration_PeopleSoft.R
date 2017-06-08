#YZPER014_ReOrg_Before<- read.table(file = "C:/Aditya/Data_PeopleSoft/YZPER014_ReOrg_Before_AsOf060114.csv", header=T,sep=",")

#YZPER006_ActivewithSalary<-read.table(file = "C:/Aditya/Data_PeopleSoft/YZPER006_ActivewithSalary_AsOf053117.csv", header=T,sep=",")
YZPER003_ActiveWithinRange<- fread("C:/Aditya/Data_PeopleSoft/YZPER003_ActiveWithinRange_060114to053117.csv")
#YZPER009_ActivewithYrsofSvc<- read.table(file = "C:/Aditya/Data_PeopleSoft/YZPER009_ActivewithYrsofSvc_060114to053117.csv", header=T,sep=",")
YZPER032_Last3SalaryIncrease<- fread("C:/Aditya/Data_PeopleSoft/YZPER032_Last3SalaryIncreases_060114to053117.csv")
YZPER037_AAPEEO<- fread("C:/Aditya/Data_PeopleSoft/YZPER037_AAPEEO_060114to053117.csv")

#str(YZPER014_ReOrg_Before)
#str(YZPER006_ActivewithSalary)

str(YZPER003_ActiveWithinRange)
str(YZPER009_ActivewithYrsofSvc)
str(YZPER032_Last3SalaryIncrease)
str(YZPER037_AAPEEO)
?cbind
library(data.table)
#YZPER037_AAPEEO_temp<-merge(YZPER037_AAPEEO,YZPER009_ActivewithYrsofSvc, by.x = YZPER037_AAPEEO$Emplid,by.y = YZPER009_ActivewithYrsofSvc$Emplid)
#remove(YZPER009_ActivewithYrsofSvc)
#summary(YZPER009_ActivewithYrsofSvc)  
length(unique(YZPER003_ActiveWithinRange$EmplId))==nrow(YZPER003_ActiveWithinRange)
?merge
class(YZPER003_ActiveWithinRange)
class(YZPER037_AAPEEO)
#YZPER037_AAPEEO<-data.table(YZPER037_AAPEEO)
#YZPER003_ActiveWithinRange<-data.table(YZPER003_ActiveWithinRange)
colnames(YZPER003_ActiveWithinRange)
#e<-colnames(YZPER037_AAPEEO)[4]
setkey(YZPER037_AAPEEO,Emplid)
colnames(YZPER003_ActiveWithinRange)[4]<-"Emplid"
setkey(YZPER003_ActiveWithinRange, Emplid)

Final_Emp_Demograph<-merge(YZPER037_AAPEEO,YZPER003_ActiveWithinRange,all.x = TRUE)


anyDuplicated(YZPER037_AAPEEO)
anyDuplicated(YZPER003_ActiveWithinRange)
Final_Emp_Demograph[,c("DeptId","DeptName","EffDt.y", "Std Hours", "Birth Dt.y","Hire Dt.y","Rehire Dt.y","Pos Nbr","Reg/Temp.y","Annual Rt"):=NULL]

colnames(Final_Emp_Demograph)[5]<-"EffDt"
colnames(Final_Emp_Demograph)[4]<-"Dept_Name"
colnames(Final_Emp_Demograph)[20]<-"Hire_Date"
colnames(Final_Emp_Demograph)[21]<-"Rehire_Date"
colnames(Final_Emp_Demograph)[22]<-"Ter_Date"
colnames(Final_Emp_Demograph)[24]<-"Reg/Temp"
colnames(Final_Emp_Demograph)[25]<-"Birth_Date"
colnames(Final_Emp_Demograph)[8]<-"Ethn_Descr"
colnames(Final_Emp_Demograph)[11]<-"Last_Sal_Inc"
colnames(Final_Emp_Demograph)[12]<-"Sal_Inc_EffDt"
colnames(Final_Emp_Demograph)[23]<-"Billing_Rate"
colnames(Final_Emp_Demograph)[27]<-"Job_Family"
colnames(Final_Emp_Demograph)[29]<-"Current_Pos_Nbr"
colnames(Final_Emp_Demograph)[30]<-"Current_Position_Title"
colnames(Final_Emp_Demograph)[40]<-"Supervisor_Title"
colnames(Final_Emp_Demograph)[43]<-"Action_Reason"
colnames(Final_Emp_Demograph)[44]<-"Positon_Title"
Final_Emp_Demograph[,c("Curr EEO1CODE","Military Status Code","Military Status Desc","Disabled Vet"):=NULL]
Final_Emp_Demograph$Birth_Date<-as.Date(Final_Emp_Demograph$Birth_Date,"%m/%d/%Y")
Final_Emp_Demograph$Hire_Date<-as.Date(Final_Emp_Demograph$Hire_Date,"%m/%d/%Y")
Final_Emp_Demograph$Rehire_Date<-as.Date(Final_Emp_Demograph$Rehire_Date,"%m/%d/%Y")
Final_Emp_Demograph$Ter_Date<-as.Date(Final_Emp_Demograph$Ter_Date,"%m/%d/%Y")
Final_Emp_Demograph$EffDt<-as.Date(Final_Emp_Demograph$EffDt,"%m/%d/%Y")
Final_Emp_Demograph$Pos_Entry_Dt<-as.Date(Final_Emp_Demograph$Pos_Entry_Dt,"%m/%d/%Y")
Final_Emp_Demograph$Sal_Inc_EffDt<-as.Date(Final_Emp_Demograph$Sal_Inc_EffDt,"%m/%d/%Y")
factor_col<-c("Emplid","Lob","Deptid","Dept_Name","Gender","Ethnicity","Ethn_Descr","Jobcode","Job_Title","P/F","Grade","FLSA","Billing_Rate","Reg/Temp","Job_Family","Current_Pos_Nbr","Current_Position_Title","Officer_CD","Officer_Descr","Empl_Status","City","State","Postal","Mar_Status","Supervisor_Title","Disabled","Action","Action_Reason","Positon_Title")
Final_Emp_Demograph <- Final_Emp_Demograph[,(factor_col):=lapply(.SD, as.factor), .SDcols=factor_col]
str(Final_Emp_Demograph)
