GITHUB_REF=hostgator/devops

BRANCH_NAME="${GITHUB_REF##*/}"
echo "BRANCH_NAME: $BRANCH_NAME"

curl_command="curl -s\
    -H'Authorization: cpanel witsoftc:2D58NOEAEODQLTAK6IHHF8T2XFK7LODL' \
    'https://shared18.hostgator.co:2083/execute/SubDomain/addsubdomain?domain=$BRANCH_NAME&rootdomain=witsoft.co&dir=%2F$BRANCH_NAME.witsoft.co'"
echo "curl command: $curl_command"
echo "executing..."
result=$(eval $curl_command)
echo "result log: $result"
status=$(echo $result | jq '.status')
if [ $status -eq 0 ]
then
    echo "ERROR: could not create subdomain"
    exit 1;
fi
echo "Successful domain creation"
exit 0
