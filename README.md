[![CircleCI](https://circleci.com/gh/cucumber/cucumber.io-file-generator/tree/master.svg?style=svg)](https://circleci.com/gh/cucumber/cucumber.io-file-generator/tree/master)

# cucumber.io-file-generator

Home of the generation and upload of website sitemaps, rss feed, and robots.txt. Files are built nightly by CircleCI and uploaded to S3 upon completion.

In order to keep our canonical urls and search results good while using multiple providers for our web presence, we process each of the files as needed and set the urls in them to be only `cucumber.io` instead of something like `cucumber.ghost.io`.

## Process

* CirleCI has a nightly scheduled build that runs make commands for rss and for sitemaps.
* Make then calls the appropriate ruby [scripts](https://github.com/cucumber/cucumber.io-file-generator/tree/master/scripts)
* Those then manage the download, checking, sanitizing, writing, etc as needed.
* A final make command is run to upload everything created to S3.

## Testing

Run `make rspec` - builds will fail if these do not pass.

## TODO

* Add rubocop run to CircleCI build
