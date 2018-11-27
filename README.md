# DevmakerRailsSdk
Bunch of helper code for your DevMaker Rails project

## Usage


## Installation
Add this line to your application's Gemfile:
```ruby
gem "devmaker_rails_sdk", git: "https://bitbucket.org/RudineyFranceschi/devmaker_rails_sdk.git"
```

You need access to this private bitbucket repo. You can set your username and password with:
```bash
bundle config bitbucket.org user:pwd
```

on heroku, you need to set it as an ENV var:
```bash
heroku config:set BUNDLE_BITBUCKET__ORG=user:pwd
```

And then execute:
```bash
$ bundle
```
