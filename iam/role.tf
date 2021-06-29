
resource "aws_iam_role" "role" {
name = var.role
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}



resource "aws_iam_policy_attachment" "lambda-attach" {
  name       = "lambda"
  
  roles      = [aws_iam_role.role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "s3-attach" {
  name       = "s3"
  
  roles      = [aws_iam_role.role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}