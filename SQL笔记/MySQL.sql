mysql语句要求使用语句结束符[;]来结束。
标识符(数据库名)命名规则。大小写取决于当前操作系统(系统认为是区分的).见名知意。推荐使用下划线方式。
标识符的字符:使用任意字符，数字，符号甚至是中文。但是一些特殊的组合。例如纯数字组合，符号组合，包括mysql是内部关键字。应该使用标示符限定符来包裹。
在mysql的数据目录。形成一个目录
限定符[``]。其实也可以使用中文：但是要求客户端编码。
---------------------------------------------操作数据库
create database [数据库名]
	|--创建数据库。
show databases;
	|--显示当前所有的数据库。
show create database [数据库名];
	|--显示数据库的创建语句。
show database like '前缀%';
	|--看含有指定前缀，的数据库！其中%称之为通配符。表示任意字符的任意个数的组合。
drop database[数据库名];
	|--删除指定数据库。
alter database [数据库名] character set [编码格式];
	|--数据库字符编码的属性修改。
show variables;
	|--展示字符集。
---------------------------------------------操作表
	数据库是表的容器。表，必须是属于某个数据库。进行操作时都会指定当前的默认数据库。
use [数据库名];
	|--选择该数据库为当前默认数据库。不会影响操作其他数据库。
create table if not exists [数据库名].[表名](列结构)character set 字符编码 collate 编码校对方式;
	|--在指定数据库下创建一个数据表并且指定编码格式。
show tables;
	|--查看所有表。
show tables like '前缀%';
	|--查看含有指定前缀，的表！其中%称之为通配符。表示任意字符的任意个数的组合。
show tables like '后缀';
	|--查看含有指定后缀，的表！
show create table 表名;
	|--查看指定表的表结构。
show create table 表名\G
	|--查看指定表的表结构。通过另一种显示方式。
describe 表名;
	|--查看指定表的表结构。显示方式不同。
desc 表名;
	|--只是 describe 的简写方式。
drop table 表名;
	|--删除指定表。
rename table 表名 to 新表名;
	|--修改指定表名。
create table 表名1 select * from 表名2;
	|--新建了一个表1.而且内容全部复制表2的！相当于复制了一个表。但是。不能重表2中复制主键(key)。
create table 表明1 like 表名2;
	|--复制表2产生表1.但是只能复制表的结构。不能复制内容。跟上面相反！表2中的(key)可以被复制。
rename table 表名1 to 新表名1,表名2 to 新表名2;
	|--同时修改多个表。表名。(可跨库改)
alter table 表名 add 列名;
	|--在指定表中添加一个新列。 
alter table 表名 drop 列名;
	|--在指定列表中删除一个列。
alter table 表名 modify (已存在)列名 属性;
	|--修改指定表的指定列的属性或者属性值。
alter table 表名 change 列名字 新列名字以及属性;
	|--修改指定表的。指定列的名字以及属性。
alter table 表名 alter 字段名 set default 默认值;
	|--为指定表的指定字段，添加默认值。
alter table 表名 all 字段名 drop default;
	|--删除指定表，指定字段的默认值。
alter table 表名 add primary key (字段名1,字段名2);
	|--为指定表格，指定字段添加主键。
alter table 表名 drop primary key;
	|--删除主键
alter table 表名 character set 字符集名称;
	|--修改指定表的字符集。
alter table 表名 engine 引擎名;
	|--修改指定表的，存储引擎。
---------------------------------------------数据操作【DML】数据管理语言。！！！
【传说中的 --增 删 改 查 】C R U D 
建立数据(插入数据)
insert into 表名(字段名) values(字段值);
	|--向指定表的指定字段中，依次插入字段值。
insert into 表名 values(字段值);
	|--为指定表所有的字段都插入值。values里面的值必须依次跟相对应的字段相对应。
获得数据(查询数据)
select 字段1,字段2 from 表名 查询条件;
	|--根据条件获取指定表里面的指定字段内容。
select * from 表名;
	|--获取指定表所有字的内容。* 代表所有的字段。查询条件可以省略，表示所有记录都获得 相当于 where 1;
select * from 表名 where 查询条件;
	|--从指定表名中查询出符合条件的指定字段的记录。
select 字段 from 数据库名.表名 where 查询条件;
	|--从指定数据库的指定表中根据条件查找到指定的字段。
删除数据
delete from 表名 条件;
	|--从指定列表中删除符合条件的数据。条件必须加上。如果不加。那么就会直接删除掉整个表。后果不可逆。就算需要删除所有数据。也要加上 where 1;
修改数据
update 表名 set 字段1=新值,字段2=新值,...条件;
	|--更新指定表的指定字段的数据。条件同理，更新操作不可逆。
'数据查询'DQL
--------------起别名
select * from 表名 as 缩写(别名);
	|--给指定表，起一个缩写。方便后面的查询。尽量别省略as 。增强阅读性。
select 字段名 as 缩写(别名)，字段名 as 缩写(别名) from 表名;
	|--给指定表格的指定字段。设置一个别名、方便操作！
--------------查询条件
字段 <=> --符号用于表达条件是否为null。比=号多了个检测null而已！
字段 值1 between 值2 --查询出值1到值2中的所有数据。包含值1和值2.
字段 in(值1,值2,值3....) --查询出所有，只要某个字段包含了指定值的记录。查询字符串的时候。会忽略大小写
字段 not in (值1,值2,值3...) --查询出所有。只要某个字段不包含指定值的记录。跟上面相反。
	% :代表的0个，一个或者多个任意字符
	_:代表一个任意字符
字段 like'表达式'; --查询。所有指定字段中包含了表达式的记录。
字段 not like'表达式'; --查询，所有指定字段中不包含表达式的记录。
字段 表达式1 and 表达式2; --查询出指定字段中。既符合表达式1又符合表达式2的所有内容！
字段 表达式1 or 表达式2; --查询出指定字段中。符合字段1或者字段2的记录。
分组查询：
	group by
select * from 表名 group by 字段名1,字段名2,字段名3...;
	|--获取指定表格。按照指定的字段分组。只显示第一个！
 !!!select group_concat(字段1),group_concat(字段2)from 表名 group by 字段名;
 聚合函数：
	 max , min ,avg, sum
	 最后配合 with rollup 记录上面所有记录的总和。
	|--获取指定表格。按照指定的字段分组。显示所有。
select count(字段) from 表名;
	|--统计出指定表格中指定字段的记录数。不统计null值。
select distinct 字段名 from 表名;
	|--从指定表中的指定字段中，去除完全相同元素后返回。
-------------------------------having
having只能用于分组之后。是对分组再次进行筛选。
只有配合group by 才有意义！
-------------------------------order by
order by
asc 升序  desc 降序
select * from 表名 order by 字段名 升/降序
	|--获得指定表格，根据指定字段的的指定排序方式来显示。
select * from 表名 order by 字段名1 升降序，字段名2 升降序....;
	|--根据指定字段的的指定排序方式来显示。
--------------------------------limit
select * from 表名 limit 值;
	|--获取表记录。限制只得到指定值的条数。
select * from 表名 limit 值1，值2;
	|--获取表记录。从值1开始。获取值2条记录。
-----------------------------------链接查询
----内连接查询
	就是指把两个，或者两个以上表连接起来一起查询。
-------------------------------------------------------数值类型--------------------------------------

[数值型 —— 整数类型]
	可以使用 unsigned 控制是否有正负。如果不写就默认可以有符号。
	也可以使用 zerofill 来进行前导0填充。
	也存在布尔 bool 类型，但是就是tinyint(1)的别名。
	0为假，非0为真
tinyint 
	|--是最小的整形只占一个字节。表示的数值范围是：-128 - 127有正负(有符号)  0 - 255 (无符号);
smallint
	|--占用2个字节
mediumint
	|--占用3个字节
int/intege
	|--占用4个字节
bigint
	|--占用8个字节
[数值型 —— 小数类型]
float
	|--默认精度是6位左右
double
	|--默认为16位左右
type(m,d)
	|--支持控制数值范围。其中M表示所有数值位数，不包括小数点和符号。D代表运行的小数位数。
[时间类型]
datetime
	|--年月日时分秒。
date
	|--年月日
timestamp
	|--时间戳。它在存储的时候是一个整型。但是在表示的时候就是个datetime。
	 2038-1-19 03：14：07  检索列时+0可以检索时间戳。
-------------------------------字符类型---------------------------------
char
	|--比较重要经常会用到的。他属于固定长度。属性值(m)代表的是字符数。表示严格限定的长度
	 --效率高。但是占用空间大。
varchar
	|--比较重要经常会用到的。他属于可变长度。属性值(m)代表的是字符数。表示允许的最大长度。其实他最大的长度是65535
	 --效率低，但是占用空间小。
enum
	|--枚举形。类似于单选题。。只是选择列出的条件之一
	--------------------------------------------------------------------类型约束---------------------------------------------------
	约束，保证表的结构和数据的正确性和稳定性。总的来说有五种：唯一性和主键约束，外键约束，检查约束，空值约束，默认值约束。
										五大关键字 ： unique 和 primary key 	foreign key		check	not null	default
not null
	|--规定一个字段的值是否可以是null。如果不写，默认可以为空。
default 值
	|--给列设置默认值。常见的是一个字段不能为空，而且存在默认值。
primary key
	|--可以唯一标示谋条记录的字段，或者是字段的集合。使之为主键。主键，不可以为null。
	主键可以是真实实体的属性，但是常用的解决方案是。利用一个与实体信息不相关的属性，作为唯一标识符，主键与业务逻辑没有关系。
primary key(列名1,列明2)
	|--声明指定列为主键。可以单个，也可以定义组合主键。
	需要注意的是：组合主键的意义：一个主键内包含多个字段。而不是多个字段都是主键。只需要一个唯一标识即可。mysql规定只能存在一个主键。常规设计都必要要有主键。
	而且最好与实体没有联系。
auto_increment
	|--自动增长机制就是为每条记录提供一个唯一的标示。每次插入记录时，将某个字段。自动增加1。需要整形，还需要索引。
	插入数据时可以选择插入null或者不插入。而且主键可以指定更改。只要不重复。
auto_increment 值
	|--初始化自动增长值的。初始值。那么以后的增长，以后数据的添加。都是从值+1开始。
	---------------------------------实体之间的对应关系--------------------------------------------------------------
	1 ： 1
		|--设计：两个实体表内，存在相同主键的字段。如果记录的主键值等于另一个关系表内记录的主键值。则，两条记录对应。也就是一对一对应。
	1 ： 多
		|--一个实体，对应多个学生、例如一个班级对应多个学生。
		 --设计：在多的一段，增加一个字段用于指向该实体所属的另外的实体的标识。用得最多，最典型是数据关系。
	多 : 多
		|--设计：典型的做法是-利用一个中间表。标示实体之间的对应关系。中间表的每个记录。表示一个关系。
		一个m : n  用 1:m,1:n来实现。
	多 ： 1
		|--
	----------------------------外键------------------
概念：
	如果一个实体的某个字段指向(引用)另一个实体的主键，就称之为外键。	
	被指向的实体，称之为主实体(主表),也叫父实体(父表),负责指向的实体称之为从实体(从表),也叫子实体(子表)
作用：
	用于约束处于关系内的实体。
	增加子表记录时，是否有与之对应的父表记录
	在删除或者更新主表记录时，从表应该如何处理相关的记录。
定义一个外键
	在从表上，增加一个外键字段，指向主表的主键，使用关键字
foreign key(外键字段) references 主表名(关联字段)(主表记录/删除时动作)(主表操记录更新时动作)
	|--

设置联级操作：
主表更新 on update
	只有主表的主键发生变化。才会对从表产生影响。
主表删除 on delete
	允许的级联动作
cascade 主表数据被更新时(主键值更新),从表也被更新(外键值更新)。主表记录被删除，从表相关记录也被删除。
set null 主表数据被更新时(主键值更新),从表的外键被设置为null。主表记录被删除。从表相关记录外键被设置成null。但注意要求该外列键，没有not null属性约束。
restrict 拒绝父表删除和更新。
    外键在MYSQL里面。什么时候都起作用。要看存储引擎。。具体看下文
-------------------------------存储引擎----------------------------
存储引擎————是表的数据类型。
默认的服务器类型，通过my.ini可以配置
default-storage-engine=INNODB;
也可以在创建表格时。指定表的存储引擎。
INNODB 与 myisam 的区别
1,保存区别的不同
	MYISAM,一个表三个文件frm(结构)myd(数据)myi(索引)。
	INNODB,只有一个文件。frm(结构)。所有的INNODB表。都使用相同的存储表空间在保存数据和索引(innodb);
选择存储引擎的依据：
	1，性能
	2，功能
--------------------------------------------select-------------------------------
select * from 表名 order by 字段 升/降序;
	|--按照指定字段进行升序或者是降序(asc | desc)。默认是升序-asc.校对规则，决定排序。
	 --允许多字段排序————指的是，先按照第一个字段排序。如果说不能区分。才使用第二个字段。以此类推。
	 如果是分组，则应该使用对分组字段进行排序的group by语法。
select * from 表名 limit x,y;
	|--限制获得的记录。从指定表中x 开始获取。获取y个。x是内部ID，不是我们规定的索引值。
select distinct * from 表名;
	|--去除检索出来的同样记录。重复的记录指的是。字段值，都相同的记录。而不是部分字段相同的目录.相对的是all。默认就是all行为。
(select语句)unnion(select语句)
	|--将多条select语句的结果合并到一起。称之为联合语句。使用uninon关键字联合两条select语句。
	--使用场景：获得数据的条件。出现逻辑冲突。或者很难再一个逻辑内表示。就可以拆分成多个逻辑，分别实现。
	--注意union的结果有重复的记录。那么消除重复。可以通过 union all 。
	子语句结果的排序：
	1，将子语句包裹子括号内。
	2，子语句的order by，只有在 order by 配合union时，才生效。原因是 union 在做子语句时，会对没有limit字句的order by 优化-忽略.

