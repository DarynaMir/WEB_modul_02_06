SELECT s.group_id, ROUND(AVG(g.grade),2) AS avg_grade
FROM students s
JOIN grades g ON s.id = g.student_id
WHERE g.subject_id = 3
GROUP BY s.group_id;