# VoodooAdnSDK

Facilitate loading/showing fullscreen and native ads.

Available with two apis:
- Completion handlers/closures
- Await/async

## Initialization of SDK

### Initialize

The SDK must be initialized prior to loading any ad. Ads can only be loaded after a successful call to the `initialize` method.

#### Example

* With completion handler
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

* With await/async api
```swift
try await VoodooAdn.AdnSdk.initialize()
```

### Sound setting

Ad sound is enabled by default. If you wish to initially mute the ads, you must configure the mute setting within the `initialize` method.

#### Example

* With completion handler
```swift
VoodooAdn.AdnSdk.initialize(options: .isMutedInitially) { result in
    switch result {
    case .success:
        // you can load an ad

    case .failure:
        // an error occured
    }
}
```

* With await/async api
```swift
try await AdnSdk.initialize(options: .isMutedInitially)
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

### Observe Delegated Actions

You can attach an observer to receive delegated actions for the native ad, such as when a URL should be opened. This is useful if you want to handle ad interactions in a custom way (for example, opening links in an in-app browser, tracking user actions, or blocking navigation).

#### Usage Example

```swift
ad.observeDelegatedActions { action in
    switch action {
    case .openInAppBrowser(let configuration):
        // Open the URL in an in-app browser or perform a custom action
        UIApplication.shared.open(configuration.launchUrl)
    }
}
```

#### About `observeDelegatedActions`
- This method allows you to listen for actions delegated to your app, such as opening URLs.
- The closure receives an `AdNativeDelegatedAction` value. Currently, the main action is `.openInAppBrowser(InAppBrowserConfiguration)`, but more actions may be added in the future.
- You can use this to:
  - Open URLs in an in-app browser (SFSafariViewController, custom webview, etc.)
  - Track user interactions for analytics
  - Block or filter navigation based on the URL

#### Example: Open in SFSafariViewController

```swift
import SafariServices

ad.observeDelegatedActions { action in
    switch action {
    case .openInAppBrowser(let configuration):
        let safariVC = SFSafariViewController(url: configuration.launchUrl)
        // Present safariVC from your view controller
    }
}
```

> **Note:** The SDK can handle ad interactions in two ways depending on the ad configuration:
> - **SDK-managed**: The SDK handles clicks internally using the default iOS browser
> - **Delegated**: The SDK delegates the action to your app via `observeDelegatedActions` for custom handling (e.g., in-app browser, analytics tracking)

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

### OMID Friendly Obstruction Views

This section details how to manage **Friendly Obstruction Views** according to the Open Measurement Interface Definition (OMID) standard. Friendly obstructions are UI elements deliberately placed over an ad that are considered non-intrusive (e.g., a "Close" button, a progress bar, or branding) and should **not** count as viewability obstruction.

The following methods must be called on the **main thread** using the `@MainActor` context to ensure thread-safe UI manipulation and OMID reporting.

#### Methods for Managing Obstructions

```swift
// Registers a specific `UIView` as a friendly obstruction for OMID measurement, categorized by its type.
@MainActor
func add(friendlyObstructionView: UIView, of type: AdFriendlyObstructionType) throws

// Unregisters a previously declared friendly obstruction view.
@MainActor
func remove(friendlyObstructionView: UIView) throws

// Unregisters all views currently declared as friendly obstructions for the active OMID session.
@MainActor
func removeAllFriendlyObstructions() throws
```

#### Example

The following example shows how to register and unregister views on a native ad unit (`VoodooAdn.AdnSdk.NativeAdUnit`):

```swift
let friendlyView: UIView = // ... your UI element (e.g., a custom logo view)
let ad: VoodooAdn.AdnSdk.NativeAdUnit // The ad unit instance

// To declare a friendly obstruction view, categorizing it as 'other':
do {
    try ad.add(friendlyObstructionView: friendlyView, of: .other)
} catch {
    print("Failed to add friendly obstruction: \(error)")
}

// To remove a previously declared friendly obstruction view:
do {
    try ad.remove(friendlyObstructionView: friendlyView)
} catch {
    print("Failed to remove friendly obstruction: \(error)")
}

// Or to remove all declared friendly obstruction views at once:
do {
    try ad.removeAllFriendlyObstructions()
} catch {
    print("Failed to remove all friendly obstructions: \(error)")
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

The `InAppBrowserConfiguration` is provided by the SDK through the `observeDelegatedActions` callback. You cannot create your own `InAppBrowserConfiguration` - you must use the one provided by the SDK.

#### Usage in Delegated Actions

```swift
ad.observeDelegatedActions { action in
    switch action {
    case .openInAppBrowser(let configuration):
        // Create browser with the provided configuration
        let browser = VoodooAdn.AdnSdk.createInAppBrowser(configuration: configuration)
        // Use the browser...
    }
}
```

### Creating an InAppBrowser

You can create an `InAppBrowser` in two ways:

- From a configuration provided by delegated actions (recommended):
```swift
let browser = VoodooAdn.AdnSdk.createInAppBrowser(configuration: configuration)
```

- Directly from a plain URL (the SDK will build an internal configuration):
```swift
let browserFromUrl = VoodooAdn.AdnSdk.createInAppBrowser(url: URL(string: "https://example.com")!)
```

**Parameters for `createInAppBrowser(configuration:)`:**
- `configuration`: An `InAppBrowserConfiguration` provided by the SDK through delegated actions.

**Parameters for `createInAppBrowser(url:)`:**
- `url`: A plain `URL` to load. The SDK will create an internal configuration.

Example:
```swift
let browser = VoodooAdn.AdnSdk.createInAppBrowser(url: URL(string: "https://example.com")!)
browser.load()

browser.observeNavigationState { state in
    print("canGoBack: \(state.canGoBack), canGoForward: \(state.canGoForward)")
}

browser.observeLoadingState { state in
    print("Loading state: \(state)")
}
```

### API Overview

The `InAppBrowser` protocol defines the following interface:

- **view**: A SwiftUI view (`AnyView`) that renders the browser content.
- **load()**: Starts loading the configured URL.
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
struct MyAdView: View {
    let ad: VoodooAdn.AdnSdk.NativeAdUnit
    
    var body: some View {
        // Your ad view content
        VStack {
            ad.getView(of: .title)
            ad.getView(of: .mainImage)
            ad.getView(of: .cta)
        }
        .onAppear {
            ad.observeDelegatedActions { action in
                switch action {
                case .openInAppBrowser(let configuration):
                    let browser = VoodooAdn.AdnSdk.createInAppBrowser(configuration: configuration)
                    
                    browser.load()
                    
                    browser.observeNavigationState { state in
                        print("canGoBack: \(state.canGoBack), canGoForward: \(state.canGoForward)")
                    }
                    
                    browser.observeLoadingState { state in
                        print("Loading state: \(state)")
                    }
                }
            }
        }
    }
}
```

## Deprecated methods

The following methods are deprecated and will be removed in the future.

```swift
AdnSdk.setUserGDPRConsent(true/false)
```

```swift
AdnSdk.setDoNotSell(true/false)
```

```swift
AdnSdk.setUserInfo(infos)
```

```swift
AdnSdk.initializeSDK(options)
```
