CREATE TABLE IF NOT EXISTS payments_for_parents
(
    id       String,
    date     Date,
    category String,
    purpose Nullable(String),
    money Decimal(18, 2),
    `index` Int64
) ENGINE = SummingMergeTree()
ORDER BY (date, category, id);

CREATE MATERIALIZED VIEW IF NOT EXISTS payments_for_parents_mv TO payments_for_parents
AS
SELECT JSONExtractString(value, 'id') AS id,
       toDate(JSONExtractString(value, 'date')) AS date,
       JSONExtractString(value, 'category') AS category,
       if(JSONHas(value, 'purpose'), JSONExtractString(value, 'purpose'), NULL) AS purpose,
       CAST(JSONExtractFloat(value, 'money') AS Decimal(18, 2)) AS money,
       JSONExtractInt(value, 'index') AS index
FROM source
WHERE JSONExtractString(value, 'type') = 'payment'
  AND category NOT IN ('gaming', 'useless');

SELECT category, sum(money) AS money FROM payments_for_parents FINAL GROUP BY category;
