## 2. Joining Three Tables ##

select il.track_id track_id, t.name track_name, mt.name track_type, il.unit_price unit_price, il.quantity quantity
from invoice_line il
inner join track t on t.track_id = il.track_id
inner join media_type mt on mt.media_type_id = t.media_type_id
where il.invoice_id = 4;

## 3. Joining More Than Three Tables ##

SELECT
    il.track_id,
    t.name track_name,
    a.name artist_name,
    mt.name track_type,
    il.unit_price,
    il.quantity
FROM invoice_line il
INNER JOIN track t ON t.track_id = il.track_id
INNER JOIN media_type mt ON mt.media_type_id = t.media_type_id
inner join album on album.album_id = t.album_id
inner join artist a on album.artist_id = a.artist_id
WHERE il.invoice_id = 4;

## 4. Combining Multiple Joins with Subqueries ##

select ta.album_title album, ta.artist_name artist, count(*) tracks_purchased
from invoice_line il
inner join (
            select 
                t.track_id,
                al.title album_title, 
                ar.name artist_name
             from artist ar 
             inner join album al on al.artist_id = ar.artist_id 
             inner join track t on al.album_id = t.album_id
            ) ta on ta.track_id = il.track_id
group by 1
order by 3 desc
limit 5;

## 5. Recursive Joins ##

select 
    e1.first_name || " " || e1.last_name as employee_name,
    e1.title as employee_title,
    e2.first_name || " " || e2.last_name as supervisor_name,
    e2.title as supervisor_title
from employee e1
left join employee e2 on e1.reports_to = e2.employee_id
order by 1;

## 6. Pattern Matching Using Like ##

select first_name, last_name, phone
from customer
where first_name like "%belle%";

## 7. Generating Columns With The Case Statement ##

select 
    c.first_name || " " || c.last_name as customer_name,
    count(i.invoice_id) as number_of_purchases,
    sum(i.total) as total_spent,
    CASE
        when sum(i.total) < 40 then 'small spender'
        when sum(i.total) > 100 then 'big spender'
        else 'regular'
        END
        as customer_category
FROM invoice as i
inner join customer as c on i.customer_id = c.customer_id
group by 1 order by 1;