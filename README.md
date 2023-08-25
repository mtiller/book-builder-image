# CI

The CI process here is run on Gitlab (just as with the book). But it requires
a Personal Access Token. GitHub could generate a token that never expires but
the problem is that the scope cannot be limited. As such, I'm generating a
token that will expire. That means that the CI/CD process of this repository
will break when the token expires.

To get a new token, just go [here](https://github.com/settings/tokens/new). But
I'm not sure how to update the token in Gitlab (it is prompting me when I
create the repository...not sure where it will store it or how it can be
updated).
