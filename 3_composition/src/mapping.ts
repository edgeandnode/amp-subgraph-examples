import { BlockValue } from "../generated/schema";
import { BlockValue as RemoteBlockValue } from "../generated/subgraph-Qmb86UAQUn8DRD9eMsyL7MpemqPz4J5ywjUeQojzfZ43ZL";

export function handleBlockValue(remote_block_value: RemoteBlockValue): void {
  let blockValue = new BlockValue(remote_block_value.id.toString());
  blockValue.blockNumber = remote_block_value.blockNumber;
  blockValue.totalValue = remote_block_value.totalValue;
  blockValue.save();
}
