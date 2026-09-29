create database customer_shopping_behaviour ;
use customer_shopping_behaviour ;

select * from customercustomers_shopping ;

# q1. total revenue by gender
select sum(`Purchase Amount (USD)`) AS total_revenue_by_gender, Gender from customercustomers_shopping group by Gender ;

# q2. customers who paid more than avg purchase amount still with discount
select `Customer ID`, `Purchase Amount (USD)` from customercustomers_shopping 
where `Discount Applied` = "yes" and `Purchase Amount (USD)` > (select avg(`Purchase Amount (USD)`) from customercustomers_shopping) ;

# q3. top 5 products with highest avg review rating ;
select `Item Purchased`, avg(`Review Rating`) from customercustomers_shopping group by `Item Purchased` order by avg(`Review Rating`) desc limit 5 ;

# q4. compare the average purchase amount between standard and express shiping;
select `Shipping Type` , avg(`Purchase Amount (USD)`) from customercustomers_shopping WHERE `Shipping Type` IN ('Express', 'Standard') group by `Shipping Type` ;

# Q5. compare avg spend and total revenue based on subscriber and non subsriber
select `Subscription Status` , count(`Customer ID`) as total_customers,  sum(`Purchase Amount (USD)`) as total_revenue,
avg(`Purchase Amount (USD)`) as avg_spend from customercustomers_shopping group by `Subscription Status`;

# q6. top 5 products have highest purchase rate including discount
select `Item Purchased`, round((total_purchase/(select count(`Item Purchased`) from customercustomers_shopping where `Discount Applied`= "yes"))*100, 2) as total_purchase_rate
     from (select `Item Purchased`, count(`Item Purchased`) as total_purchase from customercustomers_shopping
	 where `Discount Applied`= "yes"  group by `Item Purchased` order by total_purchase desc limit 5) as a ;

# Q7. customers who are repeat buyers ( more than 5 time previous purchase) also likely to subsribe
select `Customer ID`, `Previous Purchases`, `Subscription Status` from customercustomers_shopping where `Previous Purchases` > 5 order by `Previous Purchases` desc  ;
select `Subscription Status`, count(`Customer ID`) as total_customers from customercustomers_shopping where  `Previous Purchases` > 5 group by `Subscription Status` ;
 
