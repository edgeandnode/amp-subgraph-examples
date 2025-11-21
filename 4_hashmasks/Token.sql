SELECT
    data._block_num,
    data.dec['tokenId'] AS id,
    last_value(data.dec['to'] ORDER BY data._block_num, data.log_index) AS owner
FROM
(
    SELECT
        l._block_num,
        l.log_index,
        evm_decode(
            l.topic1,
            l.topic2,
            l.topic3,
            l.data,
            sg_event_signature('ERC721', 'Transfer')
        ) AS dec
    FROM
        "edgeandnode/ethereum_mainnet".logs l
    WHERE
        l.address = sg_source_address()
        AND l.topic0 = evm_topic(sg_event_signature('ERC721', 'Transfer'))
) AS data
GROUP BY
    _block_num,
    id
