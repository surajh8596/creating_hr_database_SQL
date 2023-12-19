-- MULTIPLE ROW FUNCTION
-- AVG, SUM,MIN,MAX,COUNT

USE HR;

SELECT AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES;

SELECT JOB_ID, AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID;

SELECT JOB_ID, AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID = 'IT';

SELECT JOB_ID, AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > 10000;
