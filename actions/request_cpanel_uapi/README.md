# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `base-url`
**Required** Api base url

## `user`
**Required** User authentication

## `token`
**Required** Token authentication

## `resource_path`
**Required** Path to resource, example '/execute/Variables/get_user_information?name=mailbox_format'.

## method:
**Required** Request http method. Default: GET

## `fields`
Comma-separated list of key-value pairs to include as form data. Default ``

## Outputs

## `status_code`
Api status code'

## `errors`
Array of error json strings or empty

## Example usage

uses: ./actions/request_cpanel_uapi
with:
  base-url: 'http://example.com/'
  user: 'my-user'
  token: 'XXXXXXXXXXXXXX'