.headers on
.mode column

SELECT
 ac.id, ac.body, ac.question_id, COUNT(ac.id)
FROM
  answer_choices AS ac
LEFT OUTER JOIN
  responses AS r
ON
  r.answer_choice_id = ac.id
WHERE
  ac.question_id = 1
GROUP BY
  ac.id;
