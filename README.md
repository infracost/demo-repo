# Example Terraform Project

Use our [Get Started](https://www.infracost.io/docs) guide and the example AWS Terraform projects in this repo to see how Infracost works. The AWS Terraform project contains an EC2 instance and a Lambda function.
There is also a google and azure example.

## Generate runs

1. Install [Task runner](https://taskfile.dev):
   ```
   brew install go-task/tap/go-task
   ```
2. Set `GITHUB_TOKEN` env var:
   ```
   export GITHUB_TOKEN=<GitHub token>
   ```
3. Checkout the feature branch:
   ```
   git checkout <branch name>
   ```
4. Run the task:
   ```
   task infracost BRANCH=<main|development> PR=<pr number>
   ```

This will generate 3 runs: breakdown, diff and comment in Infracost Cloud and
will post a new comment the PR specified by `PR`.
