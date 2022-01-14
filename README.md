# Easy Loading Animations [![Pub](https://img.shields.io/pub/v/easy_loading_animations)](https://pub.dev/packages/easy_loading_animations)

A collection of smart loading animations for your flutter projects which you can customize, these animations are written in pure dart and don't need any extra dependency.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
...
dependencies:
  ...
  easy_loading_animations: "^1.0.0"
...
```

Then import the file to your project:
```dart
import 'package:easy_loading_animations/easy_loading_animations.dart';
```

## Demo


## How to use

Choose a loading animation from the list:
### Barcode Loader
- `BarcodeLoader()`
### Circular Pulse
- `CircularPulse()`
### Circular Spiral
- `CircularSpiral({type: CircularSpiralType.simple})`
- `CircularSpiral({type: CircularSpiralType.heavy})`
### Fancy Plus
- `FancyPlus()`
### Future Dots
- `FutureDots()`
### Spinning Square
- `SpinningSquare()`
### Bouncing Dots
- `BouncingDots()`

Then add the following code:
```dart
CircularSpiral(
  color: Colors.blueGrey,
);
```
Or you can customize it a bit:
```dart
CircularSpiral(
  borderColor: Colors.cyan,
  size: 40,
);
```
Or customize it even more!
```dart
CircularSpiral(
  color: Colors.blueGrey,
  size: 40,
  type: CircularSpiralType.heavy,
  duration: Duration(milliseconds: 500),
);
```

For more customization, please look inside the easy loading animation files.

Note: all the animations come ready to go just by calling, for example: `CircularSpiral()`

Animations can have multiple types like `CircularSpiral()` have `simple` and `heavy`  variants, from which `simple` is default.

## Contribution

Please feel free to:
> - ask questions
> - report issues and bugs
> - suggest code improvements
> - request new features

Want to contribute? Great just three steps to follow!

> - Fork this repository
> - Create a branch, do changes
> - Create an issue or a pull request


I will be more than happy to review it and add to the project.


## Thanks

If you like this package, dont forget to hit the ⭐️ Star button and follow me for more packages!

## License

> - [Apache 2.0](https://github.com/ZainUrRehmanKhan/easy_loading_animations/blob/main/LICENSE)
> - 2022 copyright [SparkoSol]

**Free Software, Hell Yeah!**
