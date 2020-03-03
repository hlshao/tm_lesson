### Basic Skill of Text Mining in R 
## designed by Hsuanlei Shao
## 邵軒磊 20200303

rm(list = ls())
library(networkD3) 
library(dplyr) 
library(quanteda)
library(tm)

### LESSON 1: Read Text Data
# 1. input

a1= "text"
a2= "民進黨台北市議員王世堅今（19）日針對台北市長柯文哲砲轟民進黨一事出面回應，王世堅說，他向來問政犀利，自比是「獸性問政」"
a3= readLines("data/ko3.txt",encoding="UTF-8")
Judge_text= readLines("data/realJudge.txt")
rj_text= readLines("data/romeo.txt")

### LESSON 2: small technic 

#1.字串黏合
paste("A","B",sep="")

#2.字串切割
b=strsplit("A.B",split=".",fixed=T)

# 3.精確穩合
x <- c("AB","AA")
x %in% "AB"

"text" %in% a1
"test" %in% a1

#4.部份吻合 + (回傳 which)
x <- c("AB","AA")
grep("B",x)                          #---->>> 1
grep("A",x)                          #---->>> 1 2
grep("B",x,value=T)                  #---->>> "AB"
grep("B",x,value=T,invert=T)         #---->>> "AA"
grep("C",x)                          #---->>> integer(0)

grep("王世堅",a2) 
grep("柯文哲",a3) 
grep("毒品",a4)

#4-2.部份吻合 + (回傳判斷式)
x <- c("AB","AA")
grepl("B",x)                         #---->>> TRUE FALSE

grepl("王世堅",a2) 
grepl("柯文哲",a3) 
grepl("毒品",a4)


#4-3.部份吻合 + (回傳位置) + (回傳??)
x <- c("BBB","AAA","CCB")
regexpr("B",x)                         #---->>>  1 -1  3 (第一次 "hit" 的位置)

regexpr("王世堅",a2) 
regexpr("柯文哲",a3) 
regexpr("法院",a4)


#5.子字串
substr("human123456",start=1,stop=5)   #---->>> "human"

#6.特定字元取代 (1st hit)
x <- "AABB"
sub("A",replacement="C",x)           #---->>>  "CABB"

#6-2.全部特定字元取代 (global hit, 貪婪模式，較常用)
x <- "AABB"
gsub("A",replacement="C",x)          #---->>>  "CCBB"

# 7.計算字串長度
x <- c("A","AAA","AAAAA")
nchar(x)                               #---->>> 1 3 5
nchar(a4)


### LESSON 3: 小遊戲
# 8. 字元反轉
x <- c("A B","*.")
sapply(lapply(strsplit(as.character(x), NULL), rev), paste, collapse="")

# 9.字元檢查
x <- c("A B","*.")
unique(unlist(strsplit(as.character(x),split="",fixed=T)))

## 請想一個題目：比如說做出a2裡面，王世堅的頭銜是什麼。
# hint: substr(a2,DIY,DIY) 

### LESSON 4: KWIC 
## (Key Word In Context)
#install.packages("rlang")

rj_text= readLines("data/romeo.txt")
kw_romeo=kwic(rj_text, "romeo", window = 5, valuetype = "glob")
kw_drug=kwic(Judge_text, "毒品", window = 1, valuetype = "glob")

