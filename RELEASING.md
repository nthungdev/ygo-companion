# Releasing

1. Bump `version` in [`pubspec.yaml`](pubspec.yaml).
2. In [`CHANGELOG.md`](CHANGELOG.md), move the `Unreleased` items into a new dated version section. Keep entries short and user-facing; reuse them as the GitHub Release notes.
3. Commit, then tag and push:

   ```bash
   git tag -a v<VERSION> -m "Release version <VERSION>"
   git push origin v<VERSION>
   ```

## Play Console build

1. Put the upload key in the repo root.
2. Create `android/key.properties`:

   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=<alias>
   storeFile=<path to upload key file>
   ```

3. Build the bundle:

   ```sh
   flutter build appbundle
   ```
