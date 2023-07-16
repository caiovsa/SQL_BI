-- Primeira query, so pra olhar
SELECT *
FROM hrproject;

-- Trocar ID de formato de texto
ALTER TABLE hrproject
ALTER COLUMN id TYPE VARCHAR(20);

-- Vamos mudar agora a data
SELECT birthdate, hire_date, termdate
FROM hrproject;

ALTER TABLE hrproject
ALTER COLUMN birthdate TYPE date;

ALTER TABLE hrproject
ALTER COLUMN hire_date TYPE date;

ALTER TABLE hrproject
ALTER COLUMN termdate TYPE date USING termdate::DATE;

-- Criando uma coluna AGE
SELECT (date_part('year', CURRENT_DATE) - date_part('year', birthdate)) AS age
FROM hrproject;

ALTER TABLE hrproject 
ADD COLUMN age INT;

UPDATE hrproject
SET age = (date_part('year', CURRENT_DATE) - date_part('year', birthdate));

-- Tem pessoas com idade negativa, vamos corrigir isso
SELECT birthdate, age
FROM hrproject
WHERE age > 0;

SELECT min(age) AS Novo, max(age) AS velho
FROM hrproject
WHERE AGE > 0;

SELECT COUNT(*)
FROM hrproject
WHERE age < 0;

DELETE FROM hrproject
WHERE age < 0;



