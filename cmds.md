### timewarrior

Get all from `ts` that includes annotation, print columns, get ids, and tag them
```
ts april | grep Catchup | awk '{ print $1 "\n" $2 "\n" $3 "\n" $4 }' | grep @ | 
```
