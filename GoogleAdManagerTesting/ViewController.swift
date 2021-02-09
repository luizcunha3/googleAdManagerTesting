import UIKit
import GoogleMobileAds

protocol ViewControllerDelegate {
    func addBanner(_ banner: GADNativeCustomTemplateAd)
}

class AdUnitDelegate: UIViewController, GADNativeCustomTemplateAdLoaderDelegate {
    var delegate: ViewControllerDelegate!
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("@LUIZ - \(error.localizedDescription)")
    }
    
    func nativeCustomTemplateIDs(for adLoader: GADAdLoader) -> [String] {
        return ["11965647"]
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeCustomTemplateAd: GADNativeCustomTemplateAd) {
        //DAR JEITO DE PASSAR IMAGEM
        print("@LUIZ - CHEGOU UM BANNER")
        delegate.addBanner(nativeCustomTemplateAd)
    }
}

class ViewController: UIViewController, ViewControllerDelegate{
    func addBanner(_ banner: GADNativeCustomTemplateAd) {
        self.ads.append(banner)
        print("@LUIZ - \(self.ads.count)")
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deeplinkUrl: UILabel!
    
    var adLoader: GADAdLoader!
    var ads: [GADNativeCustomTemplateAd] = []
    let group = DispatchGroup()
    var anuncios: [GADNativeCustomTemplateAd] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let adUnits = ["/22158792083/app_nativo/home/carrossel_1/banner_1","/22158792083/teste_ios_simples","/22158792083/teste_ios_simples"]
        let adLoader0 = GADAdLoader(adUnitID: adUnits[0], rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [])
        let adLoader1 = GADAdLoader(adUnitID: adUnits[1], rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [])
        let adLoader2 = GADAdLoader(adUnitID: adUnits[2], rootViewController: nil, adTypes: [GADAdLoaderAdType.nativeCustomTemplate], options: [])
        
        let delegate0 = AdUnitDelegate()
        delegate0.delegate = self
        let delegate1 = AdUnitDelegate()
        delegate0.delegate = self
        let delegate2 = AdUnitDelegate()
        delegate0.delegate = self
        
        adLoader0.delegate = delegate0
        adLoader1.delegate = delegate1
        adLoader2.delegate = delegate2
        
        adLoader0.load(DFPRequest())
        adLoader1.load(DFPRequest())
        adLoader2.load(DFPRequest())
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
