  #install.packages("MatchIt")
  #安装Match It包（匹配）

  #install.packages("tableone")
  #安装tableone包（数据特征提取）

  #install.packages("cobalt")
  #安装cobalt包（评估匹配的结果）

  #installed.packages()
  #查看所有已经安装的包

  #主要参考：https://www.jianshu.com/p/8575c1eb7d3b
  #通过该代码，实现PSM方法，主要依赖MatchIt包，Really好用捏

  #install.packages("DataEditR")
  #交互式数据框数据编辑包：DataEditR https://zhuanlan.zhihu.com/p/432055215
  #在出版物中，R包同样需要引用

library("MatchIt")
library("tableone")
library("cobalt")
library("foreign")
library("DataEditR")

data(lalonde)#从MatchIt中取出范例数据
head(lalonde,4)#查看数据集的前4行

str(lalonde)

#dput(names(lalonde))
preBL <- CreateTableOne(vars=c("treat","age","educ","race","married","nodegree","re74","re75","re78"),
                        strata="treat",data=lalonde,
                        factorVars=c("treat","race","married","nodegree"))
print(preBL,showAllLevels = TRUE)

f1=matchit(treat~re74+re75+educ+age+race+married+nodegree,data=lalonde,method="nearest",caliper=0.1)
# treat是感兴趣变量,re78为结局变量(评价Treat与否对RE78的影响)

summary(f1)

matchdata1=match.data(f1)
mBL1 <- CreateTableOne(vars=c("treat","age","educ","race","married","nodegree","re74","re75","re78"),
                       strata="treat",data=matchdata1,
                       factorVars=c("treat","race","married","nodegree"))

print(mBL1,showAllLevels = TRUE)
#plot(f1, type = 'jitter', interactive = FALSE) #绘图，都是用来可视化匹配效果
bal.plot(f1,var.name = 'distance',which = 'both') #绘制密度图，可视化匹配效果！

#matchdata1$id<-1:nrow(matchdata1)
#write.csv(matchdata1,"matchdata.csv")
#导出数据为CSV格式
