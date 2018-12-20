# DevmakerRailsSdk
Bunch of helper code for your DevMaker Rails project

# Todo
-  move the push notification class (and its `fcm` gem dependency) to a new gem (does not need to be an engine)

## Usage


## Installation
Add this line to your application's Gemfile:
```ruby
gem "devmaker_rails_sdk", git: "https://bitbucket.org/RudineyFranceschi/devmaker_rails_sdk.git"
```

You need to have access to this private bitbucket repo from your bitbucket account. Then you can set your username and password with:
```bash
bundle config bitbucket.org YourBitbucketUsername:THE_SUPER_SECRET_PASSWORD
```

And then execute:
```bash
$ bundle
```

## Deploy an app using this private gem:
On heroku, use the `DevMakerApps` user to access, you need to set it as an ENV var:
```bash
heroku config:set BUNDLE_BITBUCKET__ORG=DevMakerApps:THE_SUPER_SECRET_PASSWORD
```
