--使用数据库
USE crashcourse;
--返回：
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
函数的可移植性没有SQL的可移植性高，几乎每个主要的DBMS都会支持其他DBMS不支持的函数
如果决定使用函数，应该保证做好代码注释，以便以后你或者其他人能够确切地知道所编写SQL代码的含义
--SQL支持以下类型的函数：
用于处理字符串（如删除或填充值，转换为大写或小写）的文本函数
用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数
用于处理日期和时间值并从这些值中提取特定成分（例如，返回两个日期之差，检查日期有效性）的日期和时间函数
返回DBMS正使用的特殊信息（如返回用户登录信息，检查版本信息）的系统函数

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
如果指定列名，则指定列的值为空的行被Count()函数忽略，但是如果Count()函数中用的星号(*),则不忽略

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
WHERE 过滤指定的行而不是分组。
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

--INSERT
--插入完整的行
INSERT INTO customers
VALUES(10006,
	'myname',
	'CS',
	NULL,
	NULL);

INSERT INTO customers(cust_name,
	cust_address,
	cust_city,
	cust_email)
VALUES('PEabbd',
	'100 Main Street',
	'Los Angeles',
	NULL);

可以省略某些列，前提是该列允许NULL值，或者该表定义中给出默认值

INTO 关键字是可选的

SQL Server的单条INSERT语句不支持多个VALUES子句，一次只能插入一行值

插入检索出的数据：
INSERT INTO customers(cust_contact,
	cust_email,
	cust_name,
	cust_zip)
SELECT a_contact,
	a_email,
	a_name,
	a_zip
FROM custnew;


SELECT cust_contact,
	cust_email,
	cust_name,
	cust_zip
INTO customersExport
FROM customers;

可以把 INSERT SELECT 视为一个导入操作，而把 SELECT INTO 视为一个导出操作


--更新数据
UPDATE customers
SET cust_email = 'elmer@fudd.com',
	cust_name = 'The Fudds'
WHERE cust_id = 10005;


--为了删除某个列的值，可以设置它为NULL
UPDATE customers
SET cust_email = NULL
WHERE cust_id = 10005;

--删除一行数据
DELETE FROM customers
WHERE cust_id = 10006;

DELETE 不需要列名或通配符。 DELETE 删除整行而不是删除列 

为了删除列：
ALTER TABLE vendors
DROP COLUMN vend_phone;
--删除表的一个属性列
UPDATE TABLE vendors
SET vend_phone = NULL
--把某个属性列的值都变为NULL

DELETE 只删除行 甚至可以删除所有行，但是不删除表本身

SQL Server没有撤销按钮，所以应该小心地使用 UPDATE 和 DELETE
WHERE 子句非常重要

CREATE TABLE 用来创建新表
ALTER TABLE 用来更改表列
DROP TABLE 用来完整的删除一个表

CREATE TABLE orders
(
	order_num INT NOT NULL IDENTITY(1, 1),
	order_date DATETIME NOT NULL,
	cust_id INT NOT NULL,
	PRIMARY KEY (order_num, cust_id)
);

IDENTITY(1, 1) --从1开始，每次生成编号的增量为1
每个表只允许一个IDENTITY列，而且identity列一般用作主键 

@@IDENTITY 可获得当前最后生成的IDENTITY值

在 CREATE 时候在列属性末尾加 DEFAULT 1 可指定默认值 1
也可以
DEFAULT GetDate()   --GetDate()返回的是当前系统的日期和时间


--更改表的结构
ALTER TABLE vendors
ADD vend_phone CHAR(20);
--给表增加一个属性列

ALTER TABLE vendors
DROP COLUMN vend_phone;
--删除表的一个属性列

--ALTER TABLE 最常见的用途是定义外键
ALTER TABLE orderitems
ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_num)
REFERENCES orders (order_num);

DROP TABLE customers2;
--删除表

--重命名表
EXEC sp_rename 'customers2', 'customers';
使用sp_rename可用来重命名各种对象，包括表


视图可以嵌套，可以利用其他视图从检索数据的查询来构造一个视图
ORDER BY 不可以用在视图中，但是可以用在视图中检索数据的 SELECT 语句里
视图不能索引，也不能有关联的触发器和默认值
视图可以和表一起使用。例如，编写一条联结表和视图的 SELECT 语句

--用视图联结多个表
CREATE VIEW productcustomers AS
SELECT cust_name, cust_contact, prod_id
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
	AND orderitems.order_num = orders.order_num;

--用视图重新格式化检索出的数据
CREATE VIEW vendorlocations AS
SELECT RTrim(vend_name) + '(' + RTrim(vend_country) + ')'
	AS vend_title
FROM vendors;

--使用视图与计算字段
CREATE VIEW orderitemsexpanded AS
SELECT order_num,
	prod_id,
	quantity * item_price AS expanded_price
FROM orderitems;

--查看视图
SELECT *
FROM orderitemsexpanded
WHERE order_num = 20005;

视图是可更新的，更改视图将更新其基本表。
如果视图定义中有以下操作，则不能进行视图更新：
多个基本表、分组（GROUP BY 和 HAVING）、联结、子查询、并、聚集函数（Min() Count() Sum()）
DISTINCT 、导出（计算）列

--T-SQL程序设计
变量名以@开始，局部变量@为前缀，全局变量以@@为前缀
变量使用 DECLARE 声明它们
声明一个变量时必须指定它的数据类型
变量在被声明后直到处理完成前都会一直存在
DECLARE @age INT;
DECLARE @firstName CHAR(20), @lastName CHAR(20);

变量刚声明的时候为 NULL
用 SET 给变量赋值
SET @lastName = 'Forta';
SET @firstName = 'Ben';
SET @age = 21;

也可以： SELECT @age = 21;
SET 只设置单个变量，赋值多个变量要用多条 SET 语句
SELECT 可用来在单条语句中给多个变量赋值

--查看变量的值
SELECT @lastName, @firstName, @age
也可以用print语句
PRINT @lastName + ', ' + @firstName;
PRINT @age;

PRINT 'Age: ' + Convert(CHAR, @age);

使用定义变量的方法把 10005 转换为变量 @num 的名称，然后在用到 10005 的地方用变量名 @num 代替以防出错

在给串变量赋值时需要使用单引号，但是实际使用变量时不应该使用单引号


--使用条件语句
DECLARE @open BIT
IF DatePart(dw, GetDate()) = 1
	SET @open = 0
ELSE
	SET @open = 1

--如果使用多条if或者else语句
IF @dow = 1 OR @dow = 7
	BEGIN
		SET @open = 0
		SET @process = 0
	END
ELSE
	BEGIN
		SET @open = 0
		SET @process = 0
	END

--while语句
WHILE @counter <= 10
BEGIN
	PRINT @counter
	SET @counter = @counter + 1
END

while语句中也可以使用 BREAK 和 CONTINUE

--执行存储过程
EXECUTE productpricing @cheap OUTPUT,
					   @expensive OUTPUT,
					   @average OUTPUT
--创建存储过程
CREATE PROCEDURE productpricing 
	@price_min MONEY OUTPUT
	@PRICE_max MONEY OUTPUT
	@price_avg MONEY OUTPUT
AS
BEGIN
	SELECT @price_min = Min(prod_price)
	FROM products;
	SELECT @price_max = Max(prod_price)
	FROM products;
	SELECT @price_avg = Avg(prod_price)
	FROM products;
END;

--删除
DROP PROCEDURE productpricing;

--执行（不返回任何数据）
DECLARE @cheap MONEY
DECLARE @expensive MONEY
DECLARE @AVERAGE MONEY
EXECUTE productpricing @cheap OUTPUT,
					   @expensive OUTPUT,
					   @average OUTPUT

--显示
SELECT @cheap;

SELECT @cheap, @expensive, @average;

OUTPUT 表示从存储过程中返回计算的值到变量，这个过程并不会输出，要查看变量的值要用SELECT语句

所有存储过程基本上都是封装简单的T-SQL语句


--游标
游标是一个存储在SQL Server上的数据库查询，它不是一条 SELECT 语句，而是被该语句检索出来的结果集
在存储了游标之后，应用程序可以根据需要滚动或浏览其中的数据

--创建游标
DECLARE orders_cursor CURSOR
FOR
SELECT order_num FROM orders ORDER BY order_num;

--删除游标
DEALLOCATE orders_cursor;

--打开关闭游标
OPEN orders_cursor;
CLOSE orders_cursor;

声明游标后可以多次打开和关闭，打开游标后可多次使用它直到它被关闭

--使用游标数据
FETCH NEXT FROM orders_cursor INTO @order_num;
--FETCH
FETCH NEXT --取下一行
FETCH PRIOR --检索前一行
FETCH FIRST --检索第一行
FETCH LAST --检索最后一行
FETCH ABSOLUTE --取从顶端开始的特定行数的行
FETCH RELATIVE --取从当前行开始的特定行数的行

@@FETCH_STATUS --获得fetch的状态码。如果fetch成功返回0，否则返回一个负值

--使用触发器
触发器就是SQL Server响应 DELETE、INSERT、UPDATE 中的任何语句而自动执行的T-SQL语句
表和视图支持触发器，但临时表不支持

CREATE TRIGGER newproduct_trigger ON products
AFTER INSERT
AS
SELECT 'Product added';

每个表每个事件每次只允许一个触发器，因此每个表最多支持3个触发器（INSERT、UPDATE、DELETE各一个触发器）

单个触发器可以与多个事件关联
AFTER INSERT, UPDATE

--删除触发器
DROP TRIGGER newproduct_trigger;

--禁用和重新启用触发器
DISABLE TRIGGER newproduct_trigger ON products;
ENABLE TRIGGER newproduct_trigger ON products;

--确定触发器的任务 --返回响应表明所拥有的触发器的列表
SP_HELPTRIGGER products;

--INSERT触发器 访问被插入的行
CREATE TRIGGER neworder_trigger ON orders
AFTER INSERT
AS
SELECT @@IDENTITY AS order_num;

--DELETE触发器 访问被删除的行
CREATE TRIGGER deleteorder_trigger ON orders
AFTER DELETE
AS
BEGIN
	INSERT INTO orders_achive(order_num, order_date, cust_id)
	SELECT order_num, order_date, cust_id FROM DELETED;
END;

--UPDATE触发器 --引用名为DELETED的虚拟表访问以前的值，引用名为INSERTED的虚拟表访问新更新的值
CREATE TRIGGER vendor_trigger ON vendors
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE vendors
	SET vend_state = Upper(vend_state)
	WHERE vend_id IN (SELECT VEND_ID FROM INSERTED)
END;

--事务处理
事务：一组SQL语句
回退：撤销指定SQL语句的过程
提交：将为存储的SQL语句结果写入数据库表
保留点：事务处理中设置的临时占位符，可以对它发布回退（与回退整个事务处理不同）

事务处理用来管理 INSERT 、 UPDATE 和 DELETE
不能回退 SELECT CREATE 和 DROP 操作

事务处理块中，提交不会隐含地进行，需要明确的提交，使用COMMIT语句
BEGIN TRANSACTION;
DELETE FROM orderitems WHERE order_num = 20010;
DELETE FROM orders WHERE order_num = 20010;
COMMIT;

--使用保留点
SAVE TRANSACTION delete1;
--退回到保留点
ROLLBACK TRANSACTION delete1;
--退回到事务的开始
ROLLBACK TRANSACTION;

保留点越多越好。越能让我们随时回滚到想要回到的位置。

--更改自动提交行为，使SQL Server不自动提交更改
SET IMPLICIT_TRANSACTIONS ON;

XML已经成了一个标准的机制，可通过它交换、分发和持久化存储数据

--FOR XML 指示SQL Server生成 XML 输出
SELECT vend_id, RTrim(vend_name) AS vend_name
FROM vendors
ORDER BY vend_name
FOR XML AUTO;

--SQL Server中提供了XML这种数据类型 可用来存储合式的XML
XQuery 是一种用于XML的查询语言：SQL用于关系数据库，而XQuery用于XML数据

--使用Cast()函数把每个串转换为XML
Cast('<state abbrev = "NY">
	<city name = "New York" />
	</state>' AS XML);

字符集：字母和符号的集合。
编码：某个字符集成员的内部表示。
校对：规定字符如何比较的指令。

--返回所有可用的校对顺序列表
SELECT * FROM fn_helpcollations();
--查看默认的校对程序
SELECT ServerProperty('Collation') AS Collation;

指定校对顺序
SELECT * FROM customers
ORDER BY cust_name COLLATE SQL_Latin1_General_CP1_CS_AS;

SELECT cust_id, cust_name
FROM customers
WHERE cust_name COLLATE SQL_Latin1_General_CP1_CS_AS LIKE '%E%';

COLLATE还可以用作 GROUP BY、HAVING、聚集函数、别名

VALUES(1000, N'≈ÇÍ∑')
在前面加'N'作为串的前缀，告诉SQL Server把后跟的文本视为Unicode对待

sa(System Administrator)对整个SQL Server具有完全的控制
在现实世界的日常工作中，决不能使用sa。应该创建一系列帐号，有的用于管理，有的供用户使用，有的供开发人员使用等等

--返回所有登录信息
EXEC sp_helplogins;

--创建用户帐号
CREATE LOGIN BenF WITH PASSWORD = "888888";

--删除用户帐号
DROP LOGIN BenF;

--禁用和启用帐号
ALTER LOGIN BenF DISABLE;
ALTER LOGIN BenF ENABLE;

--重命名登录：
ALTER LOGIN BenF WITH NAME = BenForta;

--更改口令
ALTER LOGIN BenF WITH PASSWORD = '000000';

--设置访问权限
GRANT CREATE TABLE TO BenF;
在末尾加 WITH GRANT OPTION 表示允许用户把相同的访问权限授予别的用户
--删除访问权限
REVOKE CREATE TABLE FROM BenF;

--改善性能
使用Windows Systems Monitor见识SQL Server的磁盘以及内屏使用、关键事件的更改等
存储过程执行比一条一条地执行其中的各条SQL Server语句快
绝对不要检索比需求还要多的数据 不要用SELECT * 除非你真的需要每一列
如果SELECT中有一系列复杂的OR，创始改变成多条SELECT语句和连接它们的UNION语句
索引改善数据检索的性能，但是损害数据插入、删除和更新的性能。如果你又一些表，它们收集数据但是不经常用作搜索，就没必要索引它们
LIKE很慢。一般来说最好用FREETEXT或者CONTAINS进行全文本搜索








