
region     = "eu-west-2"
access_key = "enter your access key"
secret_key = "enter you rsecret key"

accountid = "enter your account id"

s3buckets = ["diceresult", "dicesummary", "dicefinal"] //these bucket names are required for the lamba functions

role = "LambdaS3"

functions = [
  {
    name = "dicesimulation"
    file = "dice.zip"
    handler     = "Dice::Dice.Bootstrap::ExecuteFunction"
    runtime     = "dotnetcore3.1"
    memory_size = 512
    timeout     = 900
    http_method = "ANY"
    request_parameters = {                         //use null if not required
      "method.request.querystring.NoOfDice"  = true,
      "method.request.querystring.NoOfSides" = true,
      "method.request.querystring.NoOfRolls" = true,
    }
    mapping_template = {                          //use null if not required
      "application/json" = <<EOF
    {
     "NoOfDice": "$input.params('NoOfDice')",
     "NoOfSides": "$input.params('NoOfSides')",
     "NoOfRolls": "$input.params('NoOfRolls')"
}
    EOF
    }
    stage = "default"

  },

  {
    name               = "dicefinalresult"
    file               = "dice2.zip"
    handler            = "Dice4::Dice4.Bootstrap::ExecuteFunction"
    runtime            = "dotnetcore3.1"
    memory_size        = 512
    timeout            = 900
    http_method        = "ANY"
    request_parameters = null
    mapping_template   = null
    stage              = "default"

  }
]
