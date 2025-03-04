# VoodooAdnSDK.
Facilitate loading/showing fullscreen and native ads.
Available with two apis:
- Completion handlers/closures
- Await/async

## Initialization of SDK
```swift
  VoodooAdn.AdnSdk.initialize(.init(mediationName: "")) { result in
          switch result {
          case .success: // you can load an ad
          case .failure: 
          }
      }
 ```
## NativeAds
### Load
1. Load a native ad
2. Save the object for later usage (retrieve ui components)
```swift
   VoodooAdn.AdnSdk.loadNativeAd(.native(markup: "")) { result in
          switch result {
          case let .success(ad):
              nativeAd = ad
          case .failure
          }
      }
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

## Fullscreen Ads
### Load
```swift
    VoodooAdn.AdnSdk.loadFullScreenAd(.init(placement: "rewarded")) { result in
          switch result { result
          case .success(let ad): // you can load an ad
              adUnit = ad
          case .failure: 
              //process error
          }
      }
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
- ### GDPR consent:
```swift
    AdnSdk.setUserGDPRConsent(true/false)
```
- ### CCPA/DoNotSell consent:
```swift
    AdnSdk.setDoNotSell(true/false)
```

## Extra Information

```swift
AdnSdk.setUserInfo([
         AdnSdk.UserAgeKey: 20,
         AdnSdk.GenderKey: "Gender",
         AdnSdk.UserCustomIdKey: "CustomId",
         AdnSdk.LastAdIndex: 10
      ])
```
