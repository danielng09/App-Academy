DROP TABLE question_likes;
DROP TABLE replies;
DROP TABLE question_follows;
DROP TABLE questions;
DROP TABLE users;


CREATE TABLE users (
  id INTEGER PRIMARY KEY autoincrement,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY autoincrement,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY autoincrement,
  question_id INTEGER NOT NULL,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY autoincrement,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY autoincrement,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Daniel', 'Ng'),
  ('Kevin', 'Xu'),
  ('Phillip', 'Yoo'),
  ('CJ', 'Avila');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ("Why does my SQL not work?", "Please help", 4),
  ("Why does Kevin drink so much water?", "SOS there is no water left", 3),
  ("Why are apple earbuds white?", "I wish there was more color", 1),
  ("Why am I here?", "I can't remember who I am", 2),
  ("What is cake?", "I don't know", 1),
  ("How much wood coulda?", "Wood chuck chuck?", 1),
  ("If a wood chuck could?", "Chuck wood?", 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 1),
  (1, 3),
  (2, 2),
  (4, 4),
  (3, 2);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 2, "Because you aren't trying hard enough"),
  (1, 1, 1, "I tried very hard and it's still not working!"),
  (1, NULL, 4, "You should take my course and find out."),
  (3, NULL, 3, "Because it's cheap and white paint looks good"),
  (4, NULL, 1, "I am lost too");

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (2, 2),
  (4, 4),
  (3, 2),
  (2, 5),
  (4, 7),
  (3, 6),
  (1, 6),
  (2, 6);

.print 'users'
SELECT * FROM users;
.print 'questions'
SELECT * FROM questions;
.print 'question_follows'
SELECT * FROM question_follows;
.print 'replies'
SELECT * FROM replies;
.print 'question_likes'
SELECT * FROM question_likes;
