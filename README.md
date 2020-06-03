# ygo_companion

A mobile app to accompany Yu-Gi-Oh! players.

## Folder structure

```
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

## Publish on Play Console

1. Get the upload key and the certificate, move them to the root folder

2. Create a file `key.properties` in `./android` with the following content. Then, replace the password, alias, and path.

```
storePassword=<password>
keyPassword=<password>
keyAlias=<alias>
storeFile=<path to upload key file>
```
