# VoodooAdnSDK.
Facilitate loading/showing fullscreen and native ads.
Available with two apis:
- Completion handlers/closures
- Await/async

## Initialization of SDK
```swift
  VoodooAdn.AdnSdk.initialize() { result in
          switch result {
          case .success: // you can load an ad
          case .failure: 
          }
      }
 ```
With await/async api
```swift
  try await VoodooAdn.AdnSdk.initialize()
 ```

## NativeAds
### Load
1. Load a native ad
2. Save the object for later usage (retrieve ui components)
```swift
   VoodooAdn.AdnSdk.loadNativeAd() { result in
          switch result {
          case let .success(ad):
              nativeAd = ad
          case .failure
          }
      }
 ```

Using await/async api
```swift
  self.nativeAd = try await VoodooAdn.AdnSdk.loadNativeAd()
 ```
### Show
Construct your ad view by fetching elements from NativeAdUnit using api:

```swift
struct AdView: View {
    let ad: VoodooAdn.AdnSdk.NativeAdUnit
    
    init(adUnit: VoodooAdn.AdnSdk.NativeAdUnit) {
        self.ad = adUnit
        ad.observeShowEvents() { event in 
             switch event {
                case .click:
                    //respond to click
        
                case .dismissed:
                    //respond to dismiss
                case .failure(let error):
                    //respond to error
        
                case .rewarded:
                    //respond to reward
        
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
            ad.getView(of: .mainVideo) ??  ad.getView(of: .mainVideo)
            ad.getView(of: .cta)?
                .foregroundColor(.red)
                .font(.headline)
             
        }
    }
}
```
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
                    //respond to click
        
                case .dismissed:
                    //respond to dismiss
                case .failure(let error):
                    //respond to error
        
                case .rewarded:
                    //respond to reward
        
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
            ad.getView(of: .mainVideo) ??  ad.getView(of: .mainVideo).aspectRatio(ad.aspectRatio, contentMode: .fit) // use provided ratio
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
          case .success(let ad): // you can load an ad
              adUnit = ad
          case .failure: 
              //process error
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
                //respond to click
    
            case .dismissed:
                //respond to click
                self.adUnit? = nil
    
            case .failure(let error):
                //respond to error
                self.adUnit = nil
    
            case .rewarded:
                //respond to reward
    
            case .started:
                // respond to start
        }
    }

```

## Privacy
Note that all consent settings should be done 
- before load of an ad if SDK is used as standalone 
- before init if SDK is used as a part of mediation

- ### GDPR consent:
```swift
    AdnSdk.setUserGDPRConsent(true/false)
```
- ### CCPA/DoNotSell consent:
To make this flag work GDPR consent needs to be set to true 

```swift
    AdnSdk.setUserGDPRConsent(true)
    AdnSdk.setDoNotSell(true/false)
```

## Extra Information
Note that setting user info should be done
- before load of an ad if SDK is used as standalone
- before init if SDK is used as a part of mediation

```swift
AdnSdk.setUserInfo([
         AdnSdk.UserAgeKey: 20,
         AdnSdk.GenderKey: "Gender",
         AdnSdk.UserCustomIdKey: "CustomId",
         AdnSdk.LastAdIndex: 10
      ])
```

## Mediated and Self-mediated integration

# Expected ad markup
```json
{
    "price": 0.099, // mandatory
    "id": "23561EBE19900020A02D4BE", 
    "bi": "9f612e6ce6fca6c9d6996cb7396b470b56d0c482",
    "crid": "5ed5b014-cba6-49f2-840d-351c281f613f",
    "adm": "{\"native\":{\"ver\":\"1.2\",\"...}" // mandatory
}
```

Load and savet the object for later usage (retrieve ui components) using markup

```swift
   let myAdMarkup = // admarkup of the expected format
   VoodooAdn.AdnSdk.loadNativeAd(.native(markup: myAdMarkup)) { result in
          switch result {
          case let .success(ad):
              nativeAd = ad
          case .failure
          }
      }
 ```
