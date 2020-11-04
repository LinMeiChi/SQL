-- 作業5
-- 1.	以不列舉欄位的方式新增一筆食物資料
INSERT INTO food VALUES ('CK006', '蛋糕', '2020/05/25', 'TW', 650, '點心');

-- 2.	以列舉欄位的方式新增一筆食物資料
INSERT INTO food (id,name,expiredate,placeid,price,catalog)VALUES ('SG003', '甜辣醬', '2020/10/28', 'TW', 30, '調味品');

-- 3.	以不列舉欄位的方式新增多產地資料
INSERT INTO food VALUES ('CK007', '蛋塔', '2020/05/10', 'US', 40, '點心'),
						('DK004', '奶茶', '2020/05/10', 'TW', 70, '飲料');

-- 4.	修改一筆食物資料的價格
UPDATE food
SET price=55
where id = 'CK007';

-- 5.	按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
select  name,price,											-- 未用UPDATE SET
case 
when price <= 250 THEN round(price*(1+0.08),0)
when price between 251 and 500  THEN round(price*(1+0.05),0)
when price >501  THEN round(price*(1+0.03),0)
end 'new price'
from food;

UPDATE food													-- 用UPDATE SET
SET price=(case 
when price <= 250 THEN round(price*(1+0.08),0)
when price between 251 and 500  THEN round(price*(1+0.05),0)
when price >501  THEN round(price*(1+0.03),0)
end );


-- 6.	刪除一筆食物資料
delete from food where id='CK006';