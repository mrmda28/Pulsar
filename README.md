# Pulsar

![Platforms](https://img.shields.io/badge/platform-iOS-orange.svg?style=flat)
![SPM Compatible](https://img.shields.io/badge/spm-compatible-4BC51D.svg?style=flat)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

A simple network logger based on the [Pulse](https://github.com/kean/Pulse) library.

## Quick Start

```swift
// In the AppDelegate's didFinishLaunchingWithOptions method
NetworkLogger.shared.prepare()
```

```swift
// If you need to enable or disable the shake motion, you can do it as follows
NetworkLogger.shared.enable()
NetworkLogger.shared.disable()
```

## License

Pulsar is available under the MIT license. See the [LICENSE file](https://github.com/mrmda28/Pulsar/blob/main/LICENSE) for more info.
