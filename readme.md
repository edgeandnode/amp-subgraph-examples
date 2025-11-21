# Amp-powered subgraphs

This repository contains Amp-powered subgraph examples.

# Deployment

The Amp-powered subgraphs feature will soon be integrated into the Graph CLI.
This is a temporary method for deploying an Amp-powered subgraph to a local graph-node instance for testing:

1. Upload the subgraph to IPFS:

```bash
IPFS_URL=http://127.0.0.1:5001 ./upload.sh 1_schema_generation
```

2. Get the subgraph CID from the output:

```text
Uploaded BlockValue.sql -> QmV72XBeZtTJbWKJspVA7DSV2PD3CqtDwjgm7574tC3ToG
Uploaded subgraph.generated.yaml -> QmahhFmAhDwyKRsCxTo8TpZyyCCc5R2QoyLWo44EsBE5tL
Uploaded subgraph.template.yaml -> QmPvmFdMubqr3vj7VrK6sAVmmQmihjk7D8GbR43yDxJxPX
Subgraph Hash: QmahhFmAhDwyKRsCxTo8TpZyyCCc5R2QoyLWo44EsBE5tL
               ^ COPY the last CID
```

3. Deploy the subgraph using graphman:

```bash
graphman deploy --create first_amp_subgraph QmahhFmAhDwyKRsCxTo8TpZyyCCc5R2QoyLWo44EsBE5tL
```

# GraphQL queries

After deploying an Amp-powered subgraph to a local graph-node instance,
it is possible to query it at the following address:

```text
http://localhost:8000/subgraphs/name/first_amp_subgraph/graphql
                                     ^ replace with the deployed subgraph name
```

> [!NOTE]
> The GraphQL web interface contains all the schemas and all the available queries for the subgraph.
