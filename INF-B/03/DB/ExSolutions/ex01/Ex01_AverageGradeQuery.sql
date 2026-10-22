SELECT
s.matriculation_number,
s.name,
ROUND(AVG(g.grade),1) AS average_grade --selects matrNum name and grade
FROM
students s --from the student table
JOIN
grades g --joins it with the grades table
ON s.matriculation_number = g.matriculation_number --on the condition that it has the same matrNum
WHERE
g.grade IN (1.0,1.3,1.7,2.0,2.3,2.7,3.0,3.3,3.7,4.0,5.0) --conditional clause that checks that all the grades are within this grading scheme, redundant
GROUP BY
s.matriculation_number, s.name; --groups it by these attributes