import UIKit
import GoogleMobileAds

protocol ViewControllerDelegate {
    func addBanner(_ banner: GADNativeCustomTemplateAd)
}

class AdUnitDelegate: UIViewController, GADNativeCustomTemplateAdLoaderDelegate {
//    var delegate: ViewControllerDelegate!
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("@LUIZ - \(error.localizedDescription)")
    }
    
    func nativeCustomTemplateIDs(for adLoader: GADAdLoader) -> [String] {
        return ["11965647"]
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeCustomTemplateAd: GADNativeCustomTemplateAd) {
        print("@LUIZ - CHEGOU UM BANNER")
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deeplinkUrl: UILabel!
    
    var adLoader: GADAdLoader!
    var ads: [GADNativeCustomTemplateAd] = []
    let group = DispatchGroup()
    var anuncios: [GADNativeCustomTemplateAd] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let option = GADNativeAdImageAdLoaderOptions()
        option.shouldRequestMultipleImages = true
        let adUnits = ["/22158792083/app_nativo/home/carrossel_1/banner_1","/22158792083/app_nativo/servicos_financeiros/carrossel_1/banner_1",]
        let adLoader0 = GADAdLoader(adUnitID: adUnits[0], rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [option])
        let delegate0 = AdUnitDelegate()
        adLoader0.delegate = delegate0
        adLoader0.load(DFPRequest())
        let adLoader1 = GADAdLoader(adUnitID: adUnits[1], rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [option])
        let delegate1 = AdUnitDelegate()
        adLoader1.delegate = delegate1
        adLoader1.load(DFPRequest())
    }
    
    @IBAction func clickButton(_ sender: Any) {
        self.adLoader.load(DFPRequest())
    }
    
}

extension ViewController: GADNativeCustomTemplateAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("@LUIZ - \(error.localizedDescription)")
    }
    
    func nativeCustomTemplateIDs(for adLoader: GADAdLoader) -> [String] {
        return ["11965647"]
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeCustomTemplateAd: GADNativeCustomTemplateAd) {
        ads.append(nativeCustomTemplateAd)
        self.ads.append(nativeCustomTemplateAd)
        self.deeplinkUrl.text = nativeCustomTemplateAd.string(forKey: "deepLink1")!
        self.imageView.image = nativeCustomTemplateAd.image(forKey: "imagem1")!.image
        nativeCustomTemplateAd.delegate = self
        nativeCustomTemplateAd.recordImpression()
    }
}

extension ViewController: GADNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
        print("\(#function) called")
    }
    
}
