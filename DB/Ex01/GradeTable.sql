SELECT
s.matriculation_number,
s.name,
g.course,
g.grade
FROM
students s
JOIN
grades g
ON s.matriculation_number = g.matriculation_number
GROUP BY
s.matriculation_number, s.name, g.course, g.grade;