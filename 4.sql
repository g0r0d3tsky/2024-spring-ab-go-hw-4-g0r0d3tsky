SELECT *
FROM source
WHERE value LIKE '%"type":"payment"%'
  AND value LIKE '%"id":"recipe1"%'
  AND value LIKE '%"category":"education"%';

ALTER
TABLE
source
UPDATE value =
        '{"category":"education","type":"payment","index":3,"id":"recipe1","money":50000,"date":"2021-01-01","purpose":"подкуп преподавателя"}'
WHERE value =
      '{"category":"education","type":"payment","index":3,"id":"recipe1","money":10000,"date":"2021-01-01","purpose":"подкуп преподавателя"}';

SELECT *
FROM source
WHERE value LIKE '%"type":"payment"%'
  AND value LIKE '%"id":"recipe1"%'
  AND value LIKE '%"category":"education"%';
