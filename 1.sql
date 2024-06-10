CREATE TABLE IF NOT EXISTS counters (
                                        id String,
                                        counter Int64
) ENGINE = SummingMergeTree()
      ORDER BY id;

CREATE MATERIALIZED VIEW IF NOT EXISTS counters_mv TO counters AS
SELECT
    JSONExtractString(value, 'id') AS id,
    JSONExtractInt(value, 'value') AS counter
FROM source
WHERE JSONExtractString(value, 'type') = 'counter';

SELECT id, counter FROM counters FINAL;
