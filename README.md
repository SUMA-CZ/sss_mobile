# SSS Mobile

**Dude dont't be lazy and use TDD!** 

## Environments

Usage of `https://pub.dev/packages/environment_config` package

There are 2 files containing SHELL ENV values 
```
.dev.env
.master.env
```

There are getting sourced on ci via `source .${CI_COMMIT_REF_NAME}.env` where the variable is branch name

To generate those values into `env_config.dart` you have to run `pub run environment_config:generate`

Defaults are set to point to GURU. 

## JSON Serialization
- [Via: `json_serializable`](https://flutter.dev/docs/development/data-and-backend/json)
- Run `flutter pub run build_runner watch` to generate models when sources change

## Localization

Used package: https://pub.dev/packages/intl_utils

To generate run `flutter pub run intl_utils:generate`

## Pub Global - Auto runner for pub run
https://dart.dev/tools/pub/cmd/pub-global

