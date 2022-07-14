#!"C:\Program Files\Git\bin\sh.exe"

total=`curl -i  -u Mohit04tomar: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  https://api.github.com/orgs/fledge-iot/repos?per_page=100 | grep -i link: | sed 's/link://g' | awk -F',' -v ORS='\n' '{for (i = 1; i <= NF; i++) print $i}' | grep last | awk '{print $1}' | tr -d '\<\>' | tr '\?\&' ' ' | awk '{print $3}' | tr -d  'page=;' `
echo $total
i=1
> tmp.txt
while (( $i<=$total ))
do
    r=`curl -si  -u Mohit04tomar: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  https://api.github.com/orgs/fledge-iot/repos?per_page=100\&page=$i | grep full_name | cut -f2 -d ":" | tr ',' ' '`
    for j in ${r[@]};
    do
            echo $j
          repo=` echo $j | sed 's/"//g' `
          query=`curl -is  -u Mohit04tomar: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  https://api.github.com/repos/${repo}/git/trees/master?recursive=1 | grep -w path | cut -f2 -d ':' | tr '",' ' ' | grep -qE 'test | tests' ; echo $?`
          if (( $query==0 ))
          then
                  echo $j >> tmp.txt
          fi
    done
    ((i=$i+1))
 done

cat tmp.txt