# YGO Companion

A companion app for Yu-Gi-Oh! players. Track life points, time your duels, and roll dice or flip coins, all from one screen.

**Try it on the web:** [nthungdev.github.io/ygo-companion](https://nthungdev.github.io/ygo-companion/)
<!-- TODO: add a Google Play badge if the app is published -->

<p align="center">
  <img src="docs/screenshot-calculator.png" width="280" alt="Life point calculator" />
  <img src="docs/screenshot-settings.png" width="280" alt="Settings" />
</p>
<!-- TODO: add screenshots -->

## Features

- **Life point calculator** for two players, with expression input (for example `-(1000+500)`)
- **Duel log** recording every life-point change
- **Duel clock** with a match timer and per-player timers
- **Dice and coin toss**
- **Light and dark themes**, plus a system-theme option
- Settings are saved between sessions

## Tech stack

Flutter 3.32 · Dart · Provider (state management) · shared_preferences · Google Mobile Ads

Builds for Android, iOS, and web.

## Getting started

```sh
flutter pub get
flutter run                 # or: flutter run -d <device_id>
```

## Project structure

```text
lib/
  screens/        # home, calculator (layouts and widgets), settings
  states/         # Provider state: calculator, clock, dice, coin, theme
  widgets/        # shared widgets
  models/
  utils/
```

## Releases

See [CHANGELOG.md](CHANGELOG.md). Maintainers: the release process (versioning, tagging, Play Console build) is in [RELEASING.md](RELEASING.md).
