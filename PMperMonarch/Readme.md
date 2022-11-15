# Number of PMs per UK Monarch

# SQL

```SQL
SELECT
   Monarch,
   COUNT(PMs) AS Count
FROM
   (
      SELECT DISTINCT
         T2.Monarch,
         T1.PM AS PMs
      FROM
         T2,
         T1
      WHERE
         NOT ( (T2.
         End
         < T1.Start)
         OR
         (
            T2.Start > T1.
            End
         )
)
      ORDER BY
         Monarch
   )
GROUP BY
   Monarch
ORDER BY
   Count DESC
   SELECT
      monarch,
      Count(pms) AS Count
   FROM
      (
         SELECT DISTINCT
            t2.monarch,
            t1.pm AS PMs
         FROM
            t2,
            t1
         WHERE
            NOT ( (t2.
            end
            < t1.start)
            OR
            (
               t2.start > t1.
               end
            )
)
         ORDER BY
            monarch
      )
   GROUP BY
      monarch
   ORDER BY
      count DESC
      SELECT
         monarch,
         Count(pms) AS Count
      FROM
         (
            SELECT DISTINCT
               t2.monarch,
               t1.pm AS PMs
            FROM
               t2,
               t1
            WHERE
               NOT ( (t2.
               end
               < t1.start)
               OR
               (
                  t2.start > t1.
                  end
               )
)
            ORDER BY
               monarch
         )
      GROUP BY
         monarch
      ORDER BY
         count DESC
```

# Discussion
