SELECT
  t.name, d.name
FROM
  teachers AS t
LEFT OUTER JOIN
  depts AS d ON t.dept_id = d.id;
