# ygo_companion

A mobile app to accompany Yu-Gi-Oh! players.

## Get Started

```sh
flutter pub get
flutter run
```

## Folder structure

```text
lib/
  app.dart
  main.dart
  theme.dart
  states/
  screens/
    screen_a/
    screen_b/
      widgets/
  widgets/
  models/
```

`lib/widgets/`
Common widget shared across the app

`lib/screens/<screen_name>/widgets/`
Widgets specific for <screen_name>

## Release

### Publish on Play Console

#### Prepare the upload key and the certificate

1. Get the upload key and the certificate, move them to the root folder

2. Create a file `key.properties` in `./android` with the following content. Then, replace the password, alias, and path.

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=<alias>
storeFile=<path to upload key file>
```

#### Build the Android app bundle

```sh
flutter build appbundle
```
