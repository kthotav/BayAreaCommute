fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios code_sign_dev
```
fastlane ios code_sign_dev
```
Get certificates and sign provisioning profile for dev
### ios code_sign_appstore
```
fastlane ios code_sign_appstore
```
Get certificates and sign provisioning profile for appstore
### ios tests
```
fastlane ios tests
```
Runs all the tests
### ios beta
```
fastlane ios beta
```
Beta deployment

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
