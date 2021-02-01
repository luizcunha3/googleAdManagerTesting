import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    @IBOutlet weak var bannerView: DFPBannerView!
    
    @IBOutlet weak var deeplinkUrl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Define custom GADAdSize of 250x250 for DFPBannerView.
//        let customAdSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
//        bannerView = DFPBannerView(adSize: customAdSize)
        let adUnit = "/22158792083/teste_ios_simples"
//        let adUnit = "/6499/example/banner"
        bannerView.adUnitID = adUnit
        bannerView.rootViewController = self
        bannerView.load(DFPRequest())
        bannerView.delegate = self
    }
    
    @IBAction func clickButton(_ sender: Any) {
        
    }
    
}

extension ViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("@LUIZ - adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("@LUIZ - adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("@LUIZ - adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("@LUIZ - adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("@LUIZ - adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("@LUIZ - adViewWillLeaveApplication")
    }
}
