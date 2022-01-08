alliance="eXtra Small Pool Operators Alliance (xSPO)"
url="https://raw.githubusercontent.com/xSPO-Alliance/adapools-xspo-alliance/main/xspo-alliance-members.json"

pools=`curl $url --silent | jq -r '.adapools.members' | jq -r '.[].pool_id'`

blocks=0

for pool in $pools
do
poolBlocks=$(psql -d cexplorer -t -c "select count(*) from block join slot_leader on block.slot_leader_id = slot_leader.id where slot_leader.hash = decode('$pool','hex');")
blocks=$(($blocks + $poolBlocks))
done
echo $blocks
