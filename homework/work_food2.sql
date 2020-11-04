-- 作業1

-- 1.建立一資料表名為食物(food)，有編號、名稱、到期日、產地編號、價格、種類六個欄位，分別定義如下：
-- 		id(char(5),PK), name(varchar(30)), expiredate(datetime), placeid(char(2)), price(int unsigned), catalog(varchar(20)) 
CREATE TABLE food(					-- 建立名為food的表格
id char(5) primary key,				-- 將編號設成固定長度,為主鍵
name varchar(30) NOT NULL,			-- 名稱設為變動長度
expiredate datetime NOT NULL,		-- 到期日
placeid char(2) NOT NULL,			-- 產地編號
price int unsigned NOT NULL,		-- 價格(無負數)
catalog varchar(20) NOT NULL		-- 種類
);
DESC food;					-- 查看food表格欄位的設計

-- 2.	建立一資料表名為產地(place)，有編號、名稱兩個欄位，分別定義如下：id(char(2),PK), name(varchar(20))
CREATE TABLE place(			-- 建立名為place的表格
id char(2) primary key,		-- 編號
name varchar(20) NOT NULL		-- 名稱
);
DESC place;					-- 查看place表格欄位的設計

-- 3.利用複製表格結構的方式複製food產生一個新的表格名為food1
CREATE TABLE food1 LIKE food;		-- 複製food,產生一個名為food1的新表格
DESC food1;							-- 查看place表格欄位的設計

-- 4.利用food1新增、修改、重新命名和刪除一個欄位
ALTER TABLE food1 ADD buyid char(5) NOT NULL;		-- 在food1表格中新增一個名為buyid的欄位
ALTER TABLE food1 ADD a char(4) FIRST;				-- 在food1表格中新增一個名為a的欄位放置第一個alter
ALTER TABLE food1 ADD b varchar(20) AFTER price;	-- 在food1表格中新增一個名為b的欄位,放置在price欄位的下方
ALTER TABLE food1 MODIFY  name char(3);				-- 修改food表格中name欄位的資料型態
ALTER TABLE food1 MODIFY  placeid varchar(5) FIRST;	-- 修改food表格中placeid 欄位的資料型態和順序(放置第一位)
ALTER TABLE food1 MODIFY  b varchar(30) AFTER expiredate;	-- 修改food表格中b欄位的資料型態和順序(放置expiredate下方)
ALTER TABLE food1 CHANGE  name name1 varchar(2);	-- 將food表格中的name欄位重新命名為name1
ALTER TABLE food1 DROP name1 ;						-- 將food表格中的name1欄位刪除

-- 5.將food1重新命名為food2
ALTER TABLE food1 RENAME food2 ;			-- 將food1表格名稱重新命名為food2
DESC food2;									-- 查看food2表格欄位的設計

-- 6.刪除food2資料表
DROP table food2;


-- 作業2 

-- 1.查詢所有食物表格中所有欄位的資料
SELECT * FROM food;				

-- 2.查詢所有食物名稱、到期日和價格		
SELECT name,expiredate,price			
FROM food;

-- 3.查詢所有食物名稱、到期日和價格，並將表頭重新命為'名稱'、'到期日'和'價格'
SELECT name '名稱',expiredate'到期日',price'價格'
FROM food;

-- 4.查詢所有食物的種類有哪些？(重覆的資料只顯示一次)
SELECT DISTINCT catalog
FROM food;

-- 5.查詢所有食物名稱和種類，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & catalog'
SELECT CONCAT(name,' ',catalog)'Food name & catalog'
FROM food;

-- WHERE子句

-- 6.查詢所有食物價格超過400的食物名稱和價格
SELECT name,price
FROM food
WHERE price>400;

-- 7.查詢所有食物價格介於250~530之間的食物名稱和價格
SELECT name,price					-- 方法一
FROM food
WHERE price BETWEEN 250 AND 530;

SELECT name,price					-- 方法二
FROM food
WHERE price>=250 AND price<=530;

-- 8.查詢所有食物價格不介於250~530之間的食物名稱和價格
SELECT name,price
FROM food
WHERE price NOT BETWEEN 250 AND 530;

-- 9.查詢所有食物種類為'點心'的食物名稱和價格
SELECT name,price
FROM food
WHERE catalog='點心';

-- 10.查詢所有食物種類為'點心'和'飲料'的食物名稱、價格和種類
SELECT name,price,catalog				-- 方法一
FROM food
WHERE catalog IN('點心','飲料');

SELECT name,price,catalog				-- 方法二
FROM food
WHERE catalog='點心'OR catalog='飲料';

-- 11.查詢所有食物產地為'TW'和'JP'的食物名稱和價格
SELECT name,price
FROM food 
WHERE  placeid IN('TW','JP');

-- 12.查詢所有食物名稱有'油'字的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE name LIKE '%油%';

-- 13.查詢所有食物到期日在今年底以前到期的食物名稱和價格
SELECT name,price
FROM food
WHERE expiredate <= '2020/12/31';

-- 14.查詢所有食物到期日在明年6月底以前到期的食物名稱和價格
SELECT name,price
FROM food
WHERE expiredate <= '2021-06-30';

-- 15.查詢所有食物6個月內到期的食物名稱和價格
SELECT name,price
FROM food
WHERE expiredate<=ADDDATE(CURDATE(),INTERVAL 6 month);

-- ORDER BY子句

-- 16.查詢所有食物名稱、到期日和價格，並以價格做降冪排序
SELECT name,expiredate,price
FROM food
ORDER BY price DESC;

-- 17.查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序(P.84)
SELECT name,expiredate,price
FROM food
ORDER BY price DESC LIMIT 3;

-- 18.查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
SELECT name,price
FROM food
WHERE catalog='點心' AND price<=250
ORDER BY price ASC;

-- 19.顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
SELECT name,price,ROUND(price*(1+0.05))'New Price'
FROM food;

-- 20.接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
SELECT name,price,ROUND(price*(1+0.05))'New Price',ROUND(price*(1+0.05))-price'Increase'
FROM food;

-- 21.顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
select name,price,
case 
when price<=250 then FLOOR(price*(1+0.08))					-- 無條件捨去用FLOOR
when price BETWEEN 251 AND 500 then FLOOR(price*(1+0.05))
when price>501 then FLOOR(price*(1+0.03))
 end 'New Price'
from food;

-- 22.查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
select name,catalog,
case 
when DATEDIFF(expiredate,CURDATE())<0 then DATEDIFF(expiredate,CURDATE())
when DATEDIFF(expiredate,CURDATE())>=0 then DATEDIFF(expiredate,CURDATE())
end 'Days of expired' ,
case 
when DATEDIFF(expiredate,CURDATE())<0 then '已過期'
when DATEDIFF(expiredate,CURDATE())>=0 then '未過期'
 end 'expired of not'
from food;

-- 23.接續上題，並以過期天數做升冪排序
select name,catalog,				-- 方法一
case 
when DATEDIFF(expiredate,CURDATE())<0 then abs(DATEDIFF(expiredate,CURDATE()))
 end 'Days of expired' 
from food
where DATEDIFF(expiredate,CURDATE())<0
ORDER BY abs(DATEDIFF(expiredate,CURDATE())) ASC;

select name,catalog,abs(DATEDIFF(expiredate,CURDATE()))'過期天數'	-- 方法二
from food
where DATEDIFF(expiredate,CURDATE())<0
ORDER BY abs(DATEDIFF(expiredate,CURDATE())) ASC;

-- GROUP BY & HAVING子句

-- 24.查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT max(price)'Max',min(price)'Min',sum(price)'Sum',round(avg(price))'Avg'
FROM food;

-- 25.接續上題，查詢每個種類
SELECT catalog,max(price)'Max',min(price)'Min',sum(price)'Sum',round(avg(price))'Avg'
FROM food
GROUP BY catalog;

-- 26.接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
SELECT catalog'價格',ROUND(AVG(price))'平均價格'
FROM food
GROUP BY catalog
HAVING AVG(price)>300
ORDER BY AVG(price) DESC;

-- 27.顯示查詢每個種類的食物數量
SELECT catalog,count(*)
FROM food 
GROUP BY catalog;

-- 28.查詢不同產地和每個種類的食物數量  
SELECT placeid'產地編號',catalog'種類',count(*)'數量'
FROM food f
GROUP BY placeid,catalog;

SELECT p.name'產地',f.catalog'種類',count(*)'數量'
FROM food f,place p
WHERE f.placeid=p.id
GROUP BY placeid,catalog;

-- 作業3 JOIN
-- 1.查詢所有食物名稱、產地編號、產地名稱和價格(P.99 使用Equal join)
SELECT f.name,p.id,p.name,f.price		-- 方法一
FROM food f,place p
WHERE f.placeid=p.id;

SELECT f.name,p.id,p.name,f.price		-- 方法二
FROM food f join place p
	ON f.placeid=p.id;

-- 2.查詢所有食物名稱和產地名稱，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & place'
SELECT CONCAT(f.name,' ',p.name) 'Food name & place'
FROM food f,place p
WHERE f.placeid=p.id;

-- 3.查詢所有'台灣'生產的食物名稱和價格
SELECT f.name,f.price
FROM food f,place p
WHERE f.placeid=p.id AND
		p.name='台灣';
        
-- 4.查詢所有'台灣'和'日本'生產的食物名稱和價格，並以價格做降冪排序
SELECT p.name'產地',f.name'食物名稱',f.price'價格'			-- 方法一
FROM food f,place p
WHERE f.placeid=p.id 
GROUP BY f.name,f.price
HAVING p.name='台灣'OR p.name='日本'
ORDER BY f.price DESC;

SELECT p.name'產地',f.name'食物名稱',f.price'價格'			-- 方法二
FROM food f,place p
WHERE f.placeid=p.id AND
		p.name IN('台灣','日本')
ORDER BY price DESC;
    
-- 5.查詢前三個價格最高且'台灣'生產的食物名稱、到期日和價格，並以價格做降冪排序
SELECT f.name'食物名稱',f.expiredate'到期日',f.price'價格',p.name'產地'
FROM food f,place p
WHERE f.placeid=p.id and p.name='台灣'	
ORDER BY price DESC LIMIT 3 ;	-- P.84

-- 6.查詢每個產地(顯示產地名稱)最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT p.name,round(Max(f.price))'Max',round(Min(f.price)) 'Min',round(Sum(f.price)) 'Sum',round(Avg(f.price)) 'Avg'
FROM food f,place p
WHERE f.placeid=p.id 
GROUP BY p.name;

-- 7.查詢不同產地(顯示產地名稱)和每個種類的食物數量
SELECT p.name'產地名稱',f.catalog'種類',count(*)'數量'
FROM food f,place p
WHERE f.placeid=p.id 
GROUP BY p.name,f.catalog;

