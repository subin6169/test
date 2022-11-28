install.packages('RMariaDB')
library(dplyr)
library(RMariaDB)
library(DBI)


##Database 접속 정보
MDB.host <- "localhost"
MDB.id <- 'root'
MDB.pw <- ""
MDB.db <- "sql_2022"
MDB.port <- 3306

### DB 연결
con <-DBI:: dbConnect(
  RMariaDB::MariaDB(), 
  host = MDB.host,
  username = MDB.id, 
  password = MDB.pw, 
  dbname = MDB.db,
  port = MDB.port
)


##Table list
dbListTables(con)



### 작성한 커리 data frame으로 저장
query.str <- "select * from as_test"
rs <- dbGetQuery(con, query.str)
head(rs)
dim(rs)

#DB -> R
#주민번호 성별 구분한 데이터 불러오기
query.str <- "SELECT
	`주민번호`,
	IF(SUBSTR(`주민번호`,8,1)%2 =1, '남', '여') AS 성별

FROM `as_test`;"
rs <- dbGetQuery(con, query.str)
head(rs)
dim(rs)


query.str <- "create table `as_test_copy1` like `as_test`"
dbGetQuery(con, query.str)

dbSendQuery(con, "drop table `as_test_copy1`")
##Table list
dbListTables(con)

iris
#R -> DB
dbWriteTable(con, "iris", iris)


##database 연결 닫기
dbDisconnect(con)
