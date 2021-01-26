---
title: Mysql左连接查询记录行数
date: 2021-01-26 14:50:19
tags:
- MySQL
---

> 最近修复一个数据问题，其中用到了左连接，我的意识里还以为A左连接B，查询出的记录数量会是A的记录数，然而实际操作后发现认知严重错。

## 网上关于左连接的一张图



![](https://static.1991421.cn/2021/2021-01-26-145404.jpeg)



摘自网上的一张图，图确实没毛病，但我却产生了误解，我会认为记录数量依然是A表的记录数量。

这里举个例子来说明问题

## 举个例子

student表数据如下

```
id,name,address
1,stu_1,beijing
3,stu_3,dalian
22,alan,wuhan
55,alan,xinjiang
```

address表记录如下

```
address,id,description
xinjiang,1,xinjiang真是美
xinjiang,2,xinjiang真是大
```



左连接操作如下

```sql
select *
from student a
         left join address b on a.address = b.address
```



最终结果集记录数为`5`，注意到address为xinjiang的数据有两条。WHY？因为address为xinjiang确实在address表中是两条记录。



## 结论

W3Schools中对于左连接是这么说的

> The LEFT JOIN keyword returns all records from the left table (table1), and the matched records from the right table (table2). The result is NULL from the right side, if there is no match.

这句话应该完善下即table2中所有匹配的记录都会显示。

对于最终左连接的记录数量，一定是>=table1表记录数，因为即使关联条件在table2中没有找到相关记录也需要显示，但如果找到了且不唯一，那么这不唯一的多条也都要组合显示。



当然对于右链接，还是内连接，对于条件多条匹配情况，结果类似。

## 写在最后

问题虽然简单，但还是需注意下。