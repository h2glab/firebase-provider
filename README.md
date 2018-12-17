# Vapor Firebase Provider

![Swift](http://img.shields.io/badge/swift-4.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.1-brightgreen.svg)

## Getting Started
In your `Package.swift` file, add the following

```swift
.package(url: "https://github.com/h2glab/firebase-provider.git", from: "0.0.1")
```

Register the config and the provider to your Application

```swift
let config = FirebaseConfig(apiKey: "API_KEY")

services.register(config)

try services.register(FirebaseProvider())

app = try Application(services: services)

firebaseClient = try app.make(FirebaseClient.self)
```

Service is configured.

## Whats Implemented

TBD

## License

Vapor Gitlab Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Contributing

To contribute a feature or idea to Gitlab Provider, [create an issue][1] explaining your idea.

If you find a bug, please [create an issue][1].

[1]:  https://github.com/h2glab/firebase-provider/issues/new 