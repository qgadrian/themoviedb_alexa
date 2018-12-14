# ThemoviedbAlexa

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
	* [Current status](#current-status)
* [Testing](#testing)
* [Prepare system](#prepare-system)
	* [Create AWS user to deploy lambda](#create-aws-user-to-deploy-lambda)
	* [Setup an Alexa skill](#setup-an-alexa-skill)
	* [Create a lambda role](#create-a-lambda-role)
	* [Get a TMDB api key](#get-a-tmdb-api-key)
	* [Create an .env file](#create-an-env-file)
* [Package and deploy](#package-and-deploy)
	* [Create the release](#create-the-release)
	* [Create the lambda](#create-the-lambda)
	* [Update the lambda](#update-the-lambda)
	* [Testing the lambda](#testing-the-lambda)

<!-- vim-markdown-toc -->

## Introduction

This project deploys an [Alexa skill](https://developer.amazon.com/alexa-skills-kit/learn) to interact with [The movie database](https://www.themoviedb.org) using an [AWS Lamba](https://aws.amazon.com/lambda/).

### Current status

Right now the integration with TMDB is pretty simple, just allowing request movie ratings in spanish.

This project pretends to teach how to deploy Elixir application into AWS lambdas, as well how to create any Elixir integrations with Alexa.

## Testing

Get dependencies with `mix deps.get` and run `mix test`

## Prepare system

You will need:

* docker
* elixir
* asdf (recommended, not mandatory)
* [awscli](https://aws.amazon.com/cli/)

### Create AWS user to deploy lambda

To be able to deploy the lambda to AWS, you will need:

* Go to the IAM console
* Add new user
* Add the policy roles:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1482712489000",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:PutRolePolicy",
                "lambda:CreateFunction",
                "lambda:InvokeAsync",
                "lambda:InvokeFunction",
                "iam:PassRole",
                "lambda:UpdateAlias",
                "lambda:CreateAlias",
                "lambda:GetFunctionConfiguration",
                "lambda:AddPermission",
                "lambda:UpdateFunctionCode"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```
* Create a new access key
* Run `aws configure` and pat your credentials

### Setup an Alexa skill

Create an [Alexa skill](https://developer.amazon.com/alexa/console/ask) and create an intent to ask for a movie rating.

You will need to use a slot name `movie_name`.

### Create a lambda role

Create a role which the permissions `AWSLambdaMicroserviceExecutionRole` and `AWSLambdaBasicExecutionRole`.

This role will be used to execute the lambda.

### Get a TMDB api key

An [api key from TMDB](https://www.themoviedb.org/documentation/api?language=en-US) is needed, and it will be need into `config/config.secret.exs`:

```
import Mix.Config

config :tmdb,
  api_key: "replace_this_with_your_tmdb_api_key"
```

### Create an .env file

An .env file will be used to get your AWS lambda info:

| name           | description                                      |
|----------------|--------------------------------------------------|
| AWS_REGION     | AWS region where the lambda is created           |
| ROLE_ARN       | Role ARN which was created to execute the lambda |
| LAMBDA_NAME    | The lambda name                                  |
| ALEXA_SKILL_ID | The Alexa skill id                               |

## Package and deploy

### Create the release

To create an AWS lambda release, package into a zip, run the target `make docker_package`.

This target will use a Docker container to generate the Erlang binaries compatible with AWS, and the generated result will be copied to the `/output` directory.

### Create the lambda

Once the release is generated, you can create an AWS lambda by executing `make create_lambda`.

This will upload the lambda package to AWS, which will be excuted by demand.

### Update the lambda

Once the lambda is created, it can be updated at any time running the target `make update_lambda`.

### Testing the lambda

The lambda can be invoked with test data by running `make test_lambda`.

This target can be used to verify the lambda deployment and is not its intention to test the Alexa skill.
