SELECT
  mov.title, act.name
FROM
  (
    SELECT
      m.id, m.title
    FROM
      movies AS m
    INNER JOIN
      castings AS c ON c.movie_id = m.id
    INNER JOIN
      actors AS a ON c.actor_id = a.id
    WHERE
      a.name = 'Julie Andrews'
  ) AS mov
INNER JOIN
  castings AS cst ON cst.movie_id = mov.id
INNER JOIN
  actors AS act ON cst.actor_id = act.id
WHERE cst.ord = 1;
