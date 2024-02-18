SELECT ROUND(AVG(g.grade), 2) AS average_grade
FROM students s
JOIN grades g ON s.id = g.student_id
JOIN subjects sub ON g.subject_id = sub.id
JOIN teachers t ON sub.teacher_id = t.id
WHERE s.fullname = 'Мартин Рябошапка'
  AND t.name = 'Ярина Павлик';