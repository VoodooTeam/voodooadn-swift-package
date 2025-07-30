# VoodooAdnSDK

Facilitate loading/showing fullscreen and native ads.
Available with two apis:
- Completion handlers/closures
- Await/async

## Initialization of SDK

```swift
VoodooAdn.AdnSdk.initialize() { result in
    switch result {
    case .success:
        // you can load an ad

    case .failure:
        // an error occured
    }
}
```

With await/async api
```swift
try await VoodooAdn.AdnSdk.initialize()
```

## NativeAds

### Load

#### Trivial Case

Load a native ad and save the object for later usage (retrieve ui components)
```swift
VoodooAdn.AdnSdk.loadNativeAd() { result in
    switch result {
    case let .success(ad):
        nativeAd = ad

    case .failure:
        break
    }
}
```

Using await/async api
```swift
self.nativeAd = try await VoodooAdn.AdnSdk.loadNativeAd()
```

#### With Custom Views

You can add your own subviews to the AdView by defining them in the load options.
```swift
let options = AdnSdk.LoadAdOptions.native(extraViews: [
    .init(id: "myCustomView",
          frame: .init(x: 0, y: 0, width: 100, height: 100)) {
            Rectangle()
                .foregroundStyle(.green)
    }
])
VoodooAdn.AdnSdk.loadNativeAd(options) { result in
    switch result {
    case let .success(ad):
        nativeAd = ad

    case .failure:
        break
    }
}
```

#### Get Metadata before full loading

You can get the ad metadata before it's fully loaded.
```swift
VoodooAdn.AdnSdk.loadNativeAd(metadataCompletion: { result in
    switch result {
    case let .success(metadata):
        nativeAdMetadata = metadata

    case .failure:
        break
    }
}) { result in
    switch result {
    case let .success(ad):
        nativeAd = ad

    case .failure:
        break
    }
}
```

Using await/async api
```swift
self.nativeAd = try await VoodooAdn.AdnSdk.loadNativeAd() { result in
    switch result {
    case let .success(metadata):
        nativeAdMetadata = metadata

    case .failure:
        break
    }
}
```

### Show

Construct your ad view by fetching elements from NativeAdUnit using API:

```swift
struct AdView: View {
    let ad: VoodooAdn.AdnSdk.NativeAdUnit
    
    init(adUnit: VoodooAdn.AdnSdk.NativeAdUnit) {
        self.ad = adUnit
        ad.observeShowEvents() { event in 
             switch event {
                case .click:
                    // respond to click
        
                case .dismissed:
                    // respond to dismiss

                case .failure(let error):
                    // respond to error
        
                case .rewarded:
                    // respond to reward
        
                case .started:
                    // respond to start
             }
        }
    }
    
    var body: some View {
        VStack {
            ad.getView(of: .title)?
                .foregroundColor(.red)
                .font(.headline)

            ad.getView(of: .mainVideo) ?? ad.getView(of: .mainImage)

            ad.getView(of: .cta)?
                .foregroundColor(.red)
                .font(.headline)
        }
    }
}
```

### Observe User Interaction Events

You can attach an observer to receive user interaction events on the native ad, such as when a URL should be opened. This is useful if you want to handle ad interactions in a custom way (for example, opening links in an in-app browser, tracking user actions, or blocking navigation).

#### Usage Example

```swift
ad.observeInteractionEvents { event in
    switch event {
    case .openUrl(let url):
        // Open the URL or perform a custom action
        UIApplication.shared.open(url)
    }
}
```

#### About `observeInteractionEvents`
- This method allows you to listen for user actions triggered by the ad, such as clicks that require opening a URL.
- The closure receives an `AdNativeInteractionEvent` value. Currently, the main event is `.openUrl(URL)`, but more events may be added in the future.
- You can use this to:
  - Open URLs in your own way (e.g., SFSafariViewController, custom webview, or external browser)
  - Track user interactions for analytics
  - Block or filter navigation based on the URL

#### Example: Open in SFSafariViewController

```swift
import SafariServices

ad.observeInteractionEvents { event in
    switch event {
    case .openUrl(let url):
        let safariVC = SFSafariViewController(url: url)
        // Present safariVC from your view controller
    }
}
```

> **Note:** If you do not attach an observer, calling the `click()` method will have no effect, as the SDK no longer handles click actions internally. You must handle user interactions yourself via the `observeInteractionEvents` method.

- #### Elements Ids

```swift
 public enum NativeAdsElement {
    /// Represents Title View
    case title

    /// Represents Icon View
    case icon

    /// Represents Body View
    case body

    /// Represents Main Image View
    case mainImage

    /// Represents Main Video View
    case mainVideo

    /// Represents CTA View
    case cta

    /// Represents Advertiser View
    case advertiser

    /// Represents Rating View
    case starRating

    /// Represents Custom ID View
    case custom(String)

    /// Represents Privacy button
    case privacy
}
```

- #### Access ad info

  - aspect ratio (ad.aspectRatio)
  - price (ad.price)

```swift
struct AdView: View {
    let ad: VoodooAdn.AdnSdk.NativeAdUnit
    
    init(adUnit: VoodooAdn.AdnSdk.NativeAdUnit) {
        self.ad = adUnit
        ad.observeShowEvents() { event in 
             switch event {
             case .click:
                // respond to click
        
            case .dismissed:
                // respond to dismiss

            case .failure(let error):
                // respond to error
        
            case .rewarded:
                // respond to reward
        
            case .started:
                // respond to start
            }
        }
    }

    var body: some View {
        VStack {
            ad.getView(of: .title)?
                .foregroundColor(.red)
                .font(.headline)

            ad.getView(of: .mainVideo) ?? ad.getView(of: .mainImage).aspectRatio(ad.aspectRatio, contentMode: .fit) // use provided ratio

            ad.getView(of: .cta)?
                .foregroundColor(.red)
                .font(.headline)

            Text("Price: \(ad.price ?? 0)")
        }
    }
}
```

## Fullscreen Ads

### Load

```swift
VoodooAdn.AdnSdk.loadFullScreenAd(.interstitial) { result in
    switch result { result
    case .success(let ad):
        adUnit = ad
              
    case .failure:
    }
}
```

With await/async

```swift
let ad = try await VoodooAdn.AdnSdk.loadFullScreenAd(.rewarded)
```

### Show

```swift
adUnit?.show(with: .init(viewController: viewControllerOrTopViewController)) {[weak self] event 
    switch event {
    case .click:
        // respond to click

    case .dismissed:
        // respond to click
        self.adUnit? = nil

    case .failure(let error):
        // respond to error
        self.adUnit = nil

    case .rewarded:
        // respond to reward

    case .started:
        // respond to start
    }
}
```

## Privacy

Note that all consent settings should be done 
- before load of an ad if SDK is used as standalone 
- before init if SDK is used as a part of mediation

- ### GDPR consent

```swift
AdnSdk.setUserGDPRConsent(true/false)
```
- ### CCPA/DoNotSell consent

To make this flag work GDPR consent needs to be set to true 

```swift
AdnSdk.setUserGDPRConsent(true)
AdnSdk.setDoNotSell(true/false)
```

## Extra Information

Note that adding extra inforamtions should be done
- before load of an ad if SDK is used as standalone
- before init if SDK is used as a part of mediation

```swift
AdnSdk.setPublisherSignals([
    AdnSdk.UserAgeKey: 20,
    AdnSdk.GenderKey: "Gender",
    AdnSdk.UserCustomIdKey: "CustomId",
    AdnSdk.LastAdIndex: 10
])
```

## InAppBrowser

The SDK provides an embedded browser component you can use to open URLs inside your app instead of redirecting users externally.

### Creating an Instance

To create an `InAppBrowser`, use the following method:

```swift
let browser = VoodooAdn.AdnSdk.createInAppBrowser()
```

This returns an instance conforming to the `InAppBrowser` protocol.

### API Overview

The `InAppBrowser` protocol defines the following interface:

- **view**: A SwiftUI view (`AnyView`) that renders the browser content.
- **load(url:)**: Starts loading the specified URL.
- **stopLoading()**: Cancels any current page load.
- **reload()**: Reloads the current page.
- **goBack()**: Navigates to the previous page.
- **goForward()**: Navigates to the next page.
- **observeNavigationState(_:)**: Registers a closure that observes the browser's navigation state.  
  The callback provides an `InAppBrowserNavigationState` struct containing:
  - `canGoBack`: `true` if the browser can navigate backward, `false` otherwise.
  - `canGoForward`: `true` if the browser can navigate forward, `false` otherwise.
- **observeLoadingState(_:)**: Registers a closure that observes the in-app browser's loading lifecycle.  
  The callback provides an `InAppBrowserLoadingState` which can be:
  - `.idle`: No current loading activity.
  - `.loading(URL)`: Indicates the browser has started loading the specified URL.
  - `.success(URL)`: Indicates the browser successfully finished loading the URL.
  - `.failure(URL, Error)`: Indicates loading failed, providing the failed URL and error details.

### Example

```swift
struct MyBrowserView: View {
    @State private var browser = VoodooAdn.AdnSdk.createInAppBrowser()
    let url: URL

    var body: some View {
        browser.view
            .onAppear {
                browser.load(url: url)

                browser.observeNavigationState { state in
                    print("canGoBack: \(state.canGoBack), canGoForward: \(state.canGoForward)")
                }

                browser.observeLoadingState { state in
                    print("Loading state: \(state)")
                }
            }
    }
}
```

