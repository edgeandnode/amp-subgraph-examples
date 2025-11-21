SELECT
    b._block_num AS block_number,
    coalesce(sum(t.value), 0) AS total_value
FROM
    "edgeandnode/ethereum_mainnet".blocks b
LEFT JOIN
    "edgeandnode/ethereum_mainnet".transactions t ON
        b._block_num = t._block_num
GROUP BY
    block_number
