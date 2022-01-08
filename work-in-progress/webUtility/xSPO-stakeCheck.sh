alliance="eXtra Small Pool Operators (xSPO)"
url="https://raw.githubusercontent.com/xSPO-Alliance/adapools-xspo-alliance/main/xspo-alliance-members.json"
TOTAL_STAKE=0
pools=`curl $ALLIANCE_REGISTRY_URL --silent | jq -r '.adapools.members' | jq -r '.[].pool_id'`

for epoch in {309..312}
do
        for pool in $pools
        do
                stake=`psql -d cexplorer -t -c "SELECT sum(amount) from epoch_stake join pool_hash on epoch_stake.pool_id = pool_hash.id where epoch_no = $epoch and pool_hash.hash_raw = decode('$pool','hex');"`
                ((TOTAL_STAKE=$TOTAL_STAKE+$stake))
        done
        echo Epoch $epoch : xSPO Stake $TOTAL_STAKE
        TOTAL_STAKE=0
done
