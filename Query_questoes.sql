-- QUESTÕES
SELECT *
FROM hrproject;

-- 1) Qual é a distribuição de gênero dos funcionários da empresa?
SELECT gender, COUNT(*) AS value_count
FROM hrproject
WHERE termdate IS NULL
GROUP BY gender;

-- 2) Qual é a distribuição de raça/etnia dos funcionários da empresa?
SELECT race, COUNT(*) AS value_count
FROM hrproject
WHERE termdate IS NULL
GROUP BY race
ORDER BY value_count DESC;

-- 3) Qual é a distribuição etária dos funcionários da empresa?
SELECT age, COUNT(*) AS value_count
FROM hrproject
WHERE termdate IS NULL
GROUP BY age
ORDER BY age;

SELECT MAX(age) AS Velho, MIN(age) AS Jovem
FROM hrproject
WHERE termdate IS NULL;

SELECT CASE
	WHEN age >= 18 AND age <= 24 THEN '18-24'
	WHEN age >= 25 AND age <= 34 THEN '25-34'
	WHEN age >= 35 AND age <= 44 THEN '35-44'
	WHEN age >= 45 AND age <= 54 THEN '45-54'
	ELSE '55+'
END AS age_group, count(*) AS Grupos
FROM hrproject
WHERE termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

SELECT CASE
	WHEN age >= 18 AND age <= 24 THEN '18-24'
	WHEN age >= 25 AND age <= 34 THEN '25-34'
	WHEN age >= 35 AND age <= 44 THEN '35-44'
	WHEN age >= 45 AND age <= 54 THEN '45-54'
	ELSE '55+'
END AS age_group, count(*) AS Grupos, gender
FROM hrproject
WHERE termdate IS NULL
GROUP BY age_group, gender
ORDER BY age_group;

-- 4) quantos funcionários trabalham na sede e em outros locais (remoto)?
SELECT location, COUNT(*) AS value_count
FROM hrproject
WHERE termdate IS NULL
GROUP BY location;

-- 5) Qual é o tempo médio de permanência dos funcionários que foram demitidos?
SELECT hire_date, termdate, (termdate - hire_date) AS Duração_Dias
FROM hrproject
WHERE termdate IS NOT NULL;

SELECT CAST(AVG(termdate - hire_date) AS int) AS Media_dias
FROM hrproject;

-- 6) Como a distribuição de gênero varia entre departamentos e cargos?
SELECT gender, department, jobtitle
FROM hrproject;

SELECT gender, department, COUNT(*) AS count
FROM hrproject
WHERE termdate IS NULL
GROUP BY department, gender
ORDER BY department, count DESC;

-- 7) Qual é a distribuição de cargos na empresa?
SELECT jobtitle, COUNT(*) AS value_count
FROM hrproject
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY value_count DESC;

-- 8) Qual é a distribuição dos funcionários entre os locais por cidade e estado?
SELECT location_state, location_city, COUNT(*) AS count
FROM hrproject
WHERE termdate IS NULL
GROUP BY location_city, location_state
ORDER BY location_state;

-- 9) Como o número de funcionários da empresa mudou ao longo do tempo com base nas datas de contratação e de término?
-- Esse foi mais elaborado, eu fiz duas tabelas temporarias e mandei o join para facilitar

SELECT DATE_PART('year', hire_date) AS Ano_entrada,count(*) Entrada
INTO temp_entr
FROM hrproject
GROUP BY Ano_entrada
ORDER BY Ano_entrada;

SELECT DATE_PART('year', termdate) AS Ano_saida, count(*) Saida
INTO temp_entr2
FROM hrproject
WHERE DATE_PART('year', termdate) <= 2020
GROUP BY Ano_saida
ORDER BY Ano_saida;

SELECT Ano_saida, Saida
FROM temp_entr2;

SELECT Ano_entrada AS Ano, Entrada, Saida, (Entrada - Saida) AS Diferença
FROM temp_entr
JOIN temp_entr2
ON temp_entr.Ano_entrada = temp_entr2.Ano_saida

-- 10) Qual é a distribuição de tempo de serviço para cada departamento?
SELECT department, CAST(AVG(termdate - hire_date) AS int) AS Media_dias
FROM hrproject
WHERE termdate IS NOT NULL
GROUP BY department
ORDER BY media_dias;
