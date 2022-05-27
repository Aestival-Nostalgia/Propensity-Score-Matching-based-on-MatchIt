  #install.packages("MatchIt")
  #安装Match It包（匹配）

  #install.packages("tableone")
  #安装tableone包（数据特征提取）

  #install.packages("cobalt")
  #安装cobalt包（评估匹配的结果）

  #install.packages("readxl")
  #读取xlsx的包

  #install.packages("cli")
  #不知道干什么的，但是使用str()函数要用

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
library("readxl")
library("cli")

my_data <- read_excel("C:/Users/Charlie林川/Desktop/PSM1.xlsx", sheet = "sheet")
#读取xlsx到数据框，默认都是num形
my_data$Treat <- as.integer(my_data$Treat)
my_data$LC <- as.integer(my_data$LC)
#改变数据类型

#is.na(my_data)
#complete.cases(my_data)
#判断缺失值,请注意，如果原始xlsx数据中存在缺失值，那么PSM模型将无法使用，在进行匹配前，请务必清除原始数据中的缺失值。

#data(lalonde)#从MatchIt中取出范例数据
#head(lalonde,4)#查看数据集的前4行

#str(lalonde)
#str()函数查看数据的基本情况

#dput(names(lalonde))
preBL <- CreateTableOne(vars=c("Treat","LC","Elevation","Slope","Precipitation","Temperature","DistanceToRiver","DistanceToRoad","DistanceToSettlement","SoilOrganicMatter"),
                        strata="Treat",
                        factorVars=c("Treat","LC"),
                        data=my_data,
                        )
print(preBL,
      catDigits = 2,contDigits = 2,pDigits = 3,
      showAllLevels = TRUE)

f1=matchit(Treat ~ Elevation+Slope+Precipitation+Temperature+DistanceToRiver+DistanceToRoad+DistanceToSettlement+SoilOrganicMatter,data=my_data,method="nearest",caliper=0.0001)
# TREAT是感兴趣变量,LC为结局变量(评价Treat与否对LC的影响)，就是对谁结局变量不写入公式中

summary(f1)

matchdata1=match.data(f1)
mBL1 <- CreateTableOne(vars=c("Treat","LC","Elevation","Slope","Precipitation","Temperature","DistanceToRiver","DistanceToRoad","DistanceToSettlement","SoilOrganicMatter"),
                        strata="Treat",
                        factorVars=c("Treat","LC"),
                        data=matchdata1,
                        )

print(mBL1, 
      catDigits = 2,contDigits = 2,pDigits = 3, #小数点
      showAllLevels = TRUE)

#plot(f1, type = 'jitter', interactive = FALSE) #绘图，都是用来可视化匹配效果。

#bal.plot(f1,var.name = 'distance',which = 'both') #绘制密度图，可视化匹配效果！

#matchdata1$id<-1:nrow(matchdata1)
#write.csv(matchdata1,"matchdata.csv")
#导出数据为CSV格式
