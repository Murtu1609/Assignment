# Assignment
a terraform script to create lambda functions with rest api's

# Description
The script creates
1) lambda functions with rest api's
2) s3 buckets used to store and read results
3) an iam role with access to s3 and lambda used by the funtcions

# Pre requisites
aws account, access and secret keys

# Usage
Download the reposirtory and edit the terraform.tfvars file with your account id, access and secret keys
run terraform init, validate and apply

# Details
The script creates 2 lambda functions that are invoked by rest api's

the first function dicesimulation takes inputs of NoOfDice, NoOfSides and NoOfRolls via a query string

the url used to invoke the function is ouputed

you will need to add the query string to the url

eg: /default/dicesimulation?NoOfDice=3&NoOfSides=6&NoOfRolls=100

once invoked the below results are stored in s3 bucket diceresult

eg: Roll 3 pieces of 6-sided dice a total of 100 times.

a. For every roll sum the rolled number from the dice (the result will be between 3 and 18).

b. Count how many times each total has been rolled.

c. Return this as a JSON structure.

it also stores the NoOfDice, NoOfSides and NoOfRolls in json format in a bucket called dicesummary



the second lambda function dicefinalresult reads all the files from buckets diceresult and dicesummary, merges them and ouputs

two files TotalDiceResults.json and TotalDiceSummary in a bucket called dicefinal

the url used to invoke it is outputed and will needd to be appended with

/default/dicefinalresult

