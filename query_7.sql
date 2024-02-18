SELECT s.fullname AS student_name, g.grade, g.grade_date
FROM students s
JOIN grades g ON s.id = g.student_id
WHERE s.group_id = 1 AND g.subject_id = 2;