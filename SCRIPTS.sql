--1. Найти информацию о всех контрактах, связанных с сотрудниками департамента «Logistic». Вывести: contract_id, employee_name

select ex.contract_id, em.name  from department dp
JOIN employees em on em.department_id = dp.id
join executor ex on ex.tab_no = em.id
where dp.name = 'Logistic'

--2. Найти среднюю стоимость контрактов, заключенных сотрудников Ivan Ivanov. Вывести: среднее значение amount
select round(avg(amount), 2) from contract cn
join executor ex on cn.id = ex.contract_id
join employees em on em.id = ex.tab_no
where em.name = 'Ivan Ivanov'

-- 3. Найти самую часто встречающуюся локации среди всех заказчиков. Вывести: location, count
-- От наставника: HAVING имеет смысл там, где используется несколько функций (например MAX и AVG) или где нам нужно производить действия с использованием просчитанного значения (вычисления, сравнения и прочие), но т.к. в данном случае мы можем сравнение заменить сортировкой и тем самым облегчить конструкцию, можно было having тут не использовать)
select count(cu.location) as count, location from customer cu
group by cu.location
order by count desc
limit 1;
--мой вариант
select cu.location, count(cu.location) as count from customer cu
group by cu.location
having count(cu.location) = (
  select count(cu.location) as count from customer cu
  group by cu.location
  order by count
  desc
  limit 1
  )

-- 4. Найти контракты одинаковой стоимости. Вывести count, amount
select co.amount, count(co.amount) from contract co
group by co.amount
having count(co.amount) > 1
--От наставника: В задании №4 уместно было бы также использовать сортировку, потому что в нашем задании так сошлось, что везде 2-ки, но если бы там были большие и разные значения удобнее было бы с сортировкой:)

-- 5. Найти заказчика с наименьшей средней стоимостью контрактов. Вывести customer_name, среднее значение amount
select cu.customer_name, sum(co.amount)/count(co.amount) as average from customer cu
join contract co on cu.id = co.customer_id
group by cu.customer_name
having sum(co.amount)/count(co.amount) = (
  select sum(co.amount)/count(co.amount) as average from customer cu
  join contract co on cu.id = co.customer_id
  group by cu.customer_name
  order by average
  limit 1
  )

-- От наставника: В задании №5 использовали нестандартное решение с нахождением среднего, на самом деле очень порадовало, что смогли найти решение:)
--но вообще есть функция AVG, которая как раз считает среднюю стоимость. И тут аналогично с заданием 3, можно было оставить только подзапрос, дополнив выводом имени. т.е. :
select sum(co.amount)/count(co.amount) as average, cu.customer_name from customer cu
join contract co on cu.id = co.customer_id
group by cu.customer_name
order by average
limit 1;

-- Найти отдел, заключивший контрактов на наибольшую сумму. Вывести: department_name, sum
--От наставника: В задании №6. точно такая же история как и в 5:)
select dp.name, sum(co.amount) as sum from contract co
join executor ex on ex.contract_id = co.id
join employees em on em.id = ex.tab_no
join department dp on em.department_id = dp.id
group by dp.name
having sum(co.amount) = (
  select sum(co.amount) as sum from contract co
  join executor ex on ex.contract_id = co.id
  join employees em on em.id = ex.tab_no
  join department dp on em.department_id = dp.id
  group by dp.name
  order by sum
  desc
  limit 1
  )