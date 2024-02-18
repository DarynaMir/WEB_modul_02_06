import logging
import psycopg2
from faker import Faker
import random
import datetime
from psycopg2 import DatabaseError

fake = Faker(['uk_UA'])

try:
    # З'єднання з базою даних PostgreSQL
    conn = psycopg2.connect(host='localhost', database='postgres', user='postgres', password='123456')
    cursor = conn.cursor()

    # Додавання груп
    for _ in range(3):
        cursor.execute('INSERT INTO groups (name) VALUES (%s)', (fake.word(),))

    # Додавання викладачів
    for _ in range(4):
        cursor.execute('INSERT INTO teachers (name) VALUES (%s)', (fake.name(),))
    conn.commit()

    # Перевірка існування вчителів
    cursor.execute('SELECT id FROM teachers')
    teacher_ids = cursor.fetchall()

    if not teacher_ids:
        raise ValueError("No teachers available.")

    # Додавання предметів із вказівкою викладача
    for teacher_id in teacher_ids:
        for _ in range(2):
            cursor.execute('INSERT INTO subjects (name, teacher_id) VALUES (%s, %s)', (fake.word(), teacher_id))
    conn.commit()

    # Додавання cтудентів і оцінок
    for group_id in range(1, 4):
        for _ in range(10):
            cursor.execute('INSERT INTO students (fullname, group_id) VALUES (%s, %s) RETURNING id',
                           (fake.name(), group_id))
            student_id = cursor.fetchone()[0]
            for subject_id in range(1, 9):
                for _ in range(4):
                    grade = random.randint(0, 100)
                    grade_date = fake.date_this_decade()
                    cursor.execute(
                        'INSERT INTO grades (student_id, subject_id, grade, grade_date) VALUES (%s, %s, %s, %s)',
                        (student_id, subject_id, grade, grade_date))

    conn.commit()
except (DatabaseError, ValueError) as e:
    logging.error(e)
    conn.rollback()
finally:
    cursor.close()
    conn.close()