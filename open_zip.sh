#/bin/bash

responses=()
for response in $( grep -o 'status=[0-9]*' /var/log/nginx/old.log | grep -o '[0-9]*' | grep -v 200 ); do
        if [[ -z ${responses["$response"]} ]]; then
                responses+=(["$response"]=1)
        else
                responses["$response"]=$((${responses["$response"]}+1))
        fi
done

max=0
for response in ${!responses[@]}; do
        if [[ $max -lt ${responses["$response"]} ]]; then
                max=${responses["$response"]}
                A=$response
        fi
done

B=$( grep 'remote_addr=8.8.8.8' /var/log/nginx/old.log | wc -l )
C=$( curl -Is hint.macpaw.io | grep ETag | cut -d \" -f2 | cut -c -2 )
printf "a) %d\nb) %d\nc) %d\n" $A $B $C

CODE=$(( $A + $B + $C ))
printf "password for unzip file: %d\n" $CODE

unzip -P $CODE additional.zip