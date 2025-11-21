SELECT
    data.dec['tokenId'] AS token,
    data.dec['from'] AS from,
    data.dec['to'] AS to,
    data._block_num AS block_number,
    data.block_hash,
    data.tx_hash AS transaction_hash
FROM
(
    SELECT
        l._block_num,
        l.block_hash,
        l.tx_hash,
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
