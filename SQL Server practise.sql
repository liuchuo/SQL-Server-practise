--使用数据库
USE crashcourse;
--返回
Command(s) completed successfully

--显示所有数据库的列表
sp_databases;
--显示当前选择的数据库内所有表的列表（包括系统表和视图）
sp_tables;

--显示表列
sp_columns customers;

--检索单个列
SELECT prood_name
FROM products;
--检索多个列
SELECT prod_id, prod_name, prod_price
FROM products;
--检索所有列
SELECT *
FROM products;
-- * 叫做通配符

--检索不同的行
--使用DISTINCT关键字
SELECT DISTINCT vend_id
FROM products;

--限制只显示结果中的几行
--SQL Server 6.5及更新版本
SELECT TOP(5) prod_name
FROM products;
--更早的版本
SET ROWCOUNT 5;
SELECT prod_name
FROM products;

--通过添加PERCENT关键字，使用TOP来获得行的百分比
SELECT TOP(25) PERCENT prod_name
FROM products;

--检索任意的行
SELECT * FROM products
TABLESAMPLE (3 ROWS);
SELECT * FROM products
TABLESAMPLE (50 PERCENT);

--完全限定表名
SELECT products.prod_name
FROM crashcourse.dbo.products;
dbo == database owner 是表所有名的默认所有者


--ORDER BY 语句
SELECT prod_name
FROM products
ORDER BY prod_name;
--会以字母顺序排序

--按照多个列排序
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price, prod_name;
--先按价格排序，后按名称排序

SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC;

--使用order by和top组合，可能会找到一列中的最大值和最小值
SELECT TOP(1) prod_price
FROM products
ORDER BY prod_price DESC;

--使用where进行过滤
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 2.50;
--如果在应用层过滤，因为在客户机上过滤数据会导致服务器会不得不通过网络发送多条多余的数据，会导致网络带宽的浪费

<>   !=  不等于

--范围值检查
SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 5 AND 10;

--空值检查
SELECT prod_name
FROM products
WHERE prod_price IS NOT NULL;

--通配符
--百分号%通配符，匹配出现任意次数的任何字符
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '%hello%';
--SQL Server配置可以改成区分大小写的，但是SQL Sever安装的默认行为是不区分大小写
--不能匹配到NULL

--下划线_通配符
--只匹配单个字符
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '_ike';

--方括号[]通配符(可以用前缀字符^来否定)
WHERE cust_contact LIKE '[ABC]%'
--以A或者B或者C开头的字符串
WHERE cust_contact LIKE '^[ABC]%'
--不以A或B或C开头的字符串

--通配符使用技巧
--不要过度使用通配符，如果能够用其他操作符达到相同的目的，就用其他操作符
--尽量不要把通配符放在搜索模式的开始处，因为这样是搜索最慢的
--仔细注意通配符的位置。如果放错地方，可能不会返回想要的数据

--创建计算字段
--字段的意思和列的意思相同，数据库列一般称为列，而术语字段通常用在计算字段的连接上
--拼接：将值联结到一起构成单个值
SELECT vend_name + '(' + RTrim(vend_number) + ')'
FROM vendors
ORDER BY vend_name;
--RTrim()函数用来删除数据右侧多余的空格
--LTrim()函数可以删除数据左边的空格
RTrim(LTrim(vend_name))
--同时删除两边的空格

--给计算字段一个名字，用AS语句
ELECT vend_name + '(' + RTrim(vend_number) + ')'
AS vend_title
FROM vendors
ORDER BY vend_name;
--AS这两个字母是可以省略的
--别名有时候也称为派生列

--可以使用AS重新命名表名，在原表名左右加上[]
SELECT [Last Name] AS LastName

--SQL算术操作符：+ - * / %
SELECT quantity * item_price AS expanded_price
FROM prderitems
WHERE order_num = 2016
--输出中就会把新计算生成的expanded_price列为一个计算字段
--不一定需要从表中检索数据计算，也提供直接计算数字、字母表达式等（不需要from语句）
SELECT 3*2;  --返回6
SELECT Trim('  abc  ');
SELECT GetDate(); --GetDate()函数返回当前日期和时间


--第10章 使用数据处理函数
RTrim()去除字符串右边空格
--函数的可移植性没有SQL的可移植性高，几乎每个主要的DBMS都会支持其他DBMS不支持的函数
--如果决定使用函数，应该保证做好代码注释，以便以后你或者其他人能够确切地知道所编写SQL代码的含义
--SQL支持以下类型的函数：
--用于处理字符串（如删除或填充值，转换为大写或小写）的文本函数
--用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数
--用于处理日期和时间值并从这些值中提取特定成分（例如，返回两个日期之差，检查日期有效性）的日期和时间函数
--返回DBMS正使用的特殊信息（如返回用户登录信息，检查版本信息）的系统函数

--Upper()函数
SELECT vend_name, Upper(vend_name) AS vend_name_upcase FROM vendors
FROM vendors
ORDER BY vend_name;
--Upper()函数将文本转换为大写

CharIndex() --返回字符串指定字符的位置
Left()      --返回字符串左边的字符
Len()       --返回字符串的长度
Lower()     --将字符串转换为小写
LTrim()     --去掉字符串左边的空格
Replace()   --用其他特殊字符替换字符串中的字符
Right()     --返回字符串右边的字符
RTrim()		--去掉字符串右边的空格
Soundex()	--返回字符串的SOUNDEX的值(SOUNDEX)
--SOUNDEX返回由四个字符组成的代码 (SOUNDEX) 以评估两个字符串的相似性
Str()		--将数值转换为字符串
SubString()	--返回字符串中的字符
Upper()     --将字符串转换为大写

--Soundex()函数
SOUNDEXOUNDEX考虑了类似的发音字符和音节，使能对字符串进行发音比较而不是字母比较
SELECT cust_name, cust_contact
FROM customers
WHERE Soundex(cust_contact) = Soundex('Y Lie');
此时会返回Y Lee的这条数据，因为这两个发音类似

--日期和时间处理函数
DateAdd()	--添加日期（天、周等）
DateDiff()	--计算两个日期的差
DateName()  --返回部分日期的字符串表示
DatePart()  --返回日期的一部分（星期几、月、年等）
Day()		--返回日期中的天
GetDate()   --返回当前日期和时间
Month()		--返回日期中的月
Year()		--返回日期中的年

T-SQL支持的几种日期的串表示格式：
2006-08-17;
August 17, 2006;
20060817;
8/17/2006;
应该总是使用4位数字的年份以避免歧义

SELECT cust_id, order_num
FROM orders
WHERE DateDiff(day, order_date, '2005-09-01') = 0;
--因为日期存储的方式不同，可能只存了年月日，可能存了完整的时间
--所以应该总是使用DateDiff() 不要假定日期是如何存储的

--想要检索出2005年9月的所有订单
SELECT cust_id, order_num
FROM orders
WHERE DateDiff(month, order_date, '2005-09-01') = 0;
或者
SELECT cust_id, order_num
FROM orders
WHERE Year(order_date) = 2005 AND Month(order_date) = 9;

--数值处理函数
--在主要的DBMS的函数中，数值函数是最一致最统一的函数
Abs()	--返回一个数的绝对值
Cos()	--返回一个角度的余弦
Exp()   --返回一个数的指定值
Pi()	--返回圆周率
Rand()	--返回一个随机数
Round() --返回四舍五入为特定长度或精度的数值
Sin()	--返回一个角度的正弦
Sqrt()	--返回一个数的平方根
Square()--返回一个数的平方
Tan()	--返回一个角度的正切

--聚集函数
--5个SQL聚集函数
Avg()	--返回某列的平均值
Count()	--返回某列的行数
Max()   --返回某列的最大值
Min()   --返回某列的最小值
Sum()   --返回某列值的和

--Avg()函数  --Avg()忽略列值为NULL的行
SELECT Avg(prod_price) AS avg_price
FROM products
WHERE vend_id = 1003;

--Count()函数  --返回表中行的数目或者复合特定条件的行的数目
--包括了NULL行
能够使用Count(*)对表中的行数目进行计数

Count(cust_email) AS num_cust
FROM customers;
--选取具有电子邮件的客户计数,计数值在以num_cust命名的列中返回
--如果指定列名，则指定列的值为空的行被Count()函数忽略，但是如果Count()函数中用的星号(*),则不忽略

--Max()函数  --返回指定列中的最大值
Max()函数忽略列值为NULL的行
如果对于非数值数据使用Max()，在用于文本数据时，如果数据按照相应的列排序，则Max()返回最后一行

--Min()函数  --和上一条类比
如果对于非数值数据，返回最前面的行

--Sum()用来返回指定列值的和
SELECT Sum(item_price * quantity) AS total_price
FROM prderitems
WHERE order_num = 20005;
--利用标准的算术操作符，所有聚集函数都可以用来执行多个列上的计算

--DISTINCT参数	--如果想要只聚集不同的值
SELECT Avg(DISTINCT prod_price) AS avg_price
FROM products
WHERE wend_id = 1003;

--SELECT语句课根据需要包含多个聚集函数
SELECT Count(*) AS num_items,
	   Min(prod_price) AS price_min,
	   Max(prod_price) AS price_max,
	   Avg(prod_price) AS price_avg
FROM products;

--GROUP BY分组
SELECT vend_id, Count(*) AS num_prods
FROM products
GROUP BY vend_id;

--如果分组列中具有NULL值，则NULL将作为一个分组返回。如果列中有多个NULL值，他们将分为一组

--过滤分组
--WHERE 过滤指定的行而不是分组。
HAVING 支持所有WHERE操作符
在指定的GROUP BY子句中用HAVING代替其中的WHERE，其效果是一样的

--HAVING和WHERE的差别
WHERE在数据分组前进行过滤，HAVING在数据分组后进行过滤

SELECT vend_id, Count(*) AS num_prods
FROM products
WHERE prod_price >= 10
GROUP BY vend_id
HAVING Count(*) >= 2;


--SELECT字句顺序
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY


--子查询（嵌套在其他查询中的查询）
SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
					FROM orderitems
					WHERE prod_id = 'TNT2');
在SELECT语句中，子查询总是从内向外处理
与EXISTS结合使用的子查询只能检索单个列

--作为计算字段使用子查询
SELECT cust_name.
	   cust_state,
	   (SELECT Count(*)
	   	FROM orders
	   	WHERE orders.cust_id = customers.cust_id) AS orders
FROM customers
ORDER BY cust_name;


--子查询的另一个用途是与EXISTS谓词联合使用。
SELECT cust_id, cust_name
FROM customers
WHERE EXISTS (SELECT * 
			  FROM orders
			  WHERE DateDiff(month, order_date,
			  		'2005-09-01') = 0
			  AND customers.cust_id = orders.cust_id);
EXISTS语句比IN语句处理地快

逐步用子查询建立查询时，应该从内而外地建立

数据库的可伸缩性：能够适应不断增加的工作量而不失败。设计良好的数据库或应用程序称为可伸缩性好（scale well）

使用联结：可以联结多个表返回一组输出，联结在运行时关系表中正确的行

SELECT vend_name, prod_name, prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id
ORDER BY vend_name, prod_name;

联结：FROM语句后面跟着好几张表

笛卡尔积：由没有联结条件的表关系返回的结果为笛卡尔积
SELECT vend_name, prod_name, prod_price
FROM vendors, products
ORDER BY vend_name, prod_name;

不要联结不必要的表，否则可能很影响性能。通过为外键列有效地创建索引可以明显地改善这种性能下降

联结是SQL最重要最强大的特性，是因为关系数据库性质的要求而产生的。
等值联结也称为内部联结。这是最经常使用的联结方式

SQL允许给表名起别名，这样做主要有两个理由：
缩短SQL语句
允许在单条SELECT语句中多次使用相同的表
表别名只在查询执行中使用，与列别名不一样，表别名只在查询执行中使用，不返回到客户机

--自联结
SELECT p1.prod_id, p1.prod_name
FROM products AS p1, products AS p2
WHERE p1.vend_id = p2.vend_id
	AND p2.prod_id = 'DTNTR';

自联结一般比子查询性能好效率快

自然联结——排除多余的列出现，每个列只返回一次
事实上，迄今为止我们建立的每一个内部联结都是自然联结，很可能我们永远都不会用到不是自然联结的内部联结

--外部联结——包含了那些在相关表中没有关联行的行
LEFT OUTER JOIN 从左边表中选择所有行
RIGHT OUTER JOIN 从右边表中选择所有行
SELECT customers.cust_id, orders.order_num
FROM customers LEFT OUTER JOIN orders
 ON customers.cust_id = orders.cust_id;
--检索所有的客户，包括了那些没有订单的客户，左边可能会重复

--简化的外部联结：
SELECT customers.cust_id, orders.order_num
FROM customers, orders
WHERE customers.cust_id *= orders.cust_id;

*=指示SQL Server从第一个表（customers，靠近*的表）中检索所有行，并且关联到第二个表（orders,靠近=的表）的行
*= 左外部联结
=* 右外部联结
这种形式的语法不是ANSI标准的成分，在未来的SQL Server版本中并不支持它

FULL OUTER JOIN
--用来从两个表中检索相关的行，以及从每个表中检索不相关的行（这些行对另一表的非选择列具有NULL值）

--使用带聚集函数的联结
SELECT customers.cust_name,
	   customers.cust_id,
	   Count(orders.order_num) AS num_ord
FROM customers INNER JOIN orders
  ON customers.cust_id = orders.cust_id
GROUP BY customers.cust_name,
		 customers.cust_id;

因为使用了聚集函数（Count()函数），该NULL被转换为一个数0

--组合查询
可用UNION操作符来组合数条SQL语句

第一条 SELECT 检索价格不高于5的所有商品的所有行。
第二条 SELECT 使用IN找出供应商1001和1002生产的所有物品
SELECT vend_id, prod_id, prod_price
FROM products
WHERE prod_price <= 5
UNION
SELECT vend_id, prod_id, prod_price
FROM products
WHERE vend_id IN (1001, 1002);

如果使用多条 WHERE 子句而不是使用 UNION 的相同查询：
SELECT vend_id， prod_id, prod_price
FROM products
WHERE prod_price <= 5
	OR vend_id IN (1001, 1002);

UNION 规则：
UNION 必须以两条或两条以上的 SELECT 语句组成，语句之间用关键字 UNION 分隔
UNION 中的每个查询必须包含相同的列、表达式或聚集函数，而且各个列必须以相同的次序列出
列数据类型必须兼容，类型不必完全相同，但必须是SQL Server 可以隐含地转换的类型

UNION 从查询结果集中自动去除了重复的行
如果使用 UNION ALL 那么就会保留相同的行，不取消重复的行
UNION ALL 完成了 WHERE 字句完成不了的工作，如果确实需要每个条件的匹配行都全部出现，那么必须使用 UNION ALL 而不是 WHERE

对组合查询的结果排序，只能使用一条 ORDER BY 子句，它必须出现在最后一条 SELECT 语句之后

UNION 的组合查询实际上也可以应用不同的表
使用 UNION 可极大地简化复杂的 WHERE 子句，简化从多个表中检索数据的工作

--全文本搜索
--创建全文本目录
CREATE FULLTEXT CATALOG catalog_crashcourse;

--创建全文本索引
CREATE FULLTEXT INDEX ON productnotes(note_text)
KEY INDEX pk_productnotes
ON catalog_crashcourse;

不要在导入数据时使用全文本索引，因为更新索引需要花时间
先导入数据再建立索引

ALTER FULLTEXT CATALOG catalog_crashcourse REBUILD;
SELECT * FROM sys.fulltext_catalogs;
SELECT * FROM sys.fulltext_indexes;

--使用FREETEXT进行搜索
SELECT note_id, note_text
FROM productnotes
WHERE FREETEXT(note_text, 'rabbit food');
--查找可能含有rabbit food含义的任何东西（不一定要连在一起，不一定要包含）

--用CONTAINS进行搜索
SELECT note_id, note_text
FROM productnotes
WHERE CONTAINS(note_text, 'handsaw');

CONTAINS搜索通常比LIKE更快，表越大越如此
CONTAINS 中可以使用*通配符：CONTAINS(note_text, '"anvil*"');
表示匹配任何以anvil开始的词

支持在CONTAINS中使用AND、OR和NOT（布尔操作符）
SELECT note_id, note_text
FROM productnotes
WHERE CONTAINS(note_text, 'safe AND handsaw');

SELECT note_id, note_text
FROM productnotes
WHERE CONTAINS(note_text, 'rabbit AND NOT food');

--词尾变化搜索（inflectional search）
'FORMSOF(INFLECTIONAL, vary)' --全文本引擎查找与指定词（vary）具有相同词干的词，包括varies
'FORMSOF(THESAURUS, vary)'--可以找出指定词的同义词（不过为了使用此功能，必须首先用词及其同义词填写一个XML辞典文件）


--FULLTEXT搜索用FULLTEXTTABLE()函数排序
--CONTAINS搜索用CONTAINSTABLE()函数排序
SELECT f.rank, note_id, note_text
FROM productnotes,
	 FREETEXTTABLE(productnotes, note_text, 'rabbit food') f
WHERE productnotes.note_id = f.[key]
ORDER BY rank DESC;

rank列显示匹配的等级值。等级值越高越匹配
还可以用ISABLOUT()函数给特定的词赋予权重值。然后，全文本搜索引擎会在决定等级时使用这些权重值






























