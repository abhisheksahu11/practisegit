select * from blinkit_data; 

select count(*) from blinkit_data;

update blinkit_data
set Item_Fat_Content = 
case 
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
end;

select cast(sum(Total_Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from blinkit_data;

select cast(avg(Total_sales) as decimal(10,2)) as Average_Sales from blinkit_data;

select Item_Fat_Content ,cast(sum(Total_sales) as decimal(10,2)) AS Total_Sales,
         cast(avg(Total_sales) as decimal(10,2)) as Average_Sales,
		 count(*) as No_of_Items
from blinkit_data
group by Item_Fat_Content
order by Total_Sales desc;

select Item_Fat_Content ,cast(sum(Total_sales) as decimal(10,2)) AS Total_Sales,
         cast(avg(Total_sales) as decimal(10,2)) as Average_Sales,
		 count(*) as No_of_Items
from blinkit_data
where Outlet_Establishment_Year = 2022
group by Item_Fat_Content
order by Total_Sales desc;

select Outlet_Location_Type,Item_Fat_Content ,
         cast(sum(Total_sales) as decimal(10,2)) AS Total_Sales,
         cast(avg(Total_sales) as decimal(10,2)) as Average_Sales,
		 count(*) as No_of_Items
from blinkit_data
group by Outlet_Location_Type,Item_Fat_Content
order by Total_Sales;

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC

