-- 1.	查詢所有比'鳳梨酥'貴的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where price > (select price
				from food
                where name='鳳梨酥');
-- 2.	查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where price < (select price
				from food
                where name='曲奇餅乾' )
	  AND catalog='點心';
-- 3.	查詢所有和'鳳梨酥'同一年到期的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where  year(expiredate) = (select year(expiredate)
							from food 
                            where name='鳳梨酥')
		AND  name NOT IN('鳳梨酥');
						
-- 4.	查詢所有比平均價格高的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where price>(select avg(price)
			from food);
            
-- 5.	查詢所有比平均價格低的'台灣'食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where price<(select avg(price)
			from food);
            
-- 6.	查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'
from food
where price < (select price
				from food 
                where name='仙貝');

-- 7.	查詢所有產地和'仙貝'相同且過期超過6個月以上的食物名稱、到期日和價格
select name'食物名稱',expiredate'到期日',price'價格'			-- 方法一
from food
where placeid in (select placeid
				from food 
                where name='仙貝')
	  and expiredate<=(select sysdate()-interval 6 month);
      
select name'食物名稱',expiredate'到期日',price'價格'			-- 方法二
from food
where placeid in (select placeid
				from food 
                where name='仙貝')  
and expiredate<= subdate(CURDATE(),INTERVAL 6 month);
-- 8.	查詢每個產地價格最低的食物名稱、到期日和價格(p.65)
select placeid'產地編號',name'食物名稱',expiredate'到期日',price'價格'			
from food f
where price in(select min(price)
			from food
            group by placeid
            having placeid=f.placeid);

-- 9.	查詢每個種類的食物價格最高者的食物名稱和價格
select catalog'種類',name'食物名稱',price'價格'			
from food f
where price in(select max(price)
			from food
            group by catalog
            having catalog=f.catalog);
-- 10.	查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
select name'食物名稱',catalog'種類',price'價格'	
from food
where price > all (select price
			     from food
                 where catalog = "點心")
and catalog <> "點心"
order by price DESC; 
		
-- 11.	查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
select p.name,f.name'食物名稱',f.price'價格'
from food f,place p
where  f.placeid=p.id AND
		price IN (select max(price)
					from food
					group by placeid
                    );