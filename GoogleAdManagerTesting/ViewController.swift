import UIKit
import GoogleMobileAds

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
        let adUnit = "/22158792083/teste_ios_simples"
        self.adLoader = GADAdLoader(adUnitID: adUnit, rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [option])
        self.adLoader.delegate = self
        self.adLoader.load(DFPRequest())
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
