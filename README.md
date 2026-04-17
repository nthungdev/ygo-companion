# ygo_companion

A mobile app to accompany Yu-Gi-Oh! players.

## Get Started

### Install dependencies

```sh
flutter pub get
```

### Run the app

```sh
flutter run

# List connected devices
flutter devices
flutter run -d <device_id>
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

### Update App Version

Update the app version in [`pubspec.yaml`](pubspec.yaml) by modifying the `version` field.

### Update Changelog

Update [`CHANGELOG.md`](CHANGELOG.md) before creating the release tag.

- Move items from `Unreleased` into a new version section using the release date.
- Keep entries concise and user-facing.
- Reuse the same version notes for the GitHub Release description.

Example:

```md
## [0.0.1] - 2026-04-09

- Fixed: keyboard interaction issues in chat and document editing.
- Added: feature chatbot can predict user's age.
- Removed: ability to edit messages after sending.
```

### Git Tagging

After committing your changes:

```bash
# Create an annotated git tag with the version number
git tag -a v<VERSION> -m "Release version <VERSION>"

# Push the tag to the repository
git push origin v<VERSION>

# Or push all tags at once
git push --tags
```

Example:

```bash
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3
```

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

Before releasing a new version of the app, follow these steps:

#### Build the Android app bundle

```sh
flutter build appbundle
```
