//
//  ImageSimilarityViewController.swift
//  Bareun
//
//  Created by YangYujin on 2021/01/16.
//

import UIKit
import Vision

class ImageSimilarityViewController: UIViewController {

    @IBOutlet weak var original: UIImageView!
    @IBOutlet weak var compare: UIImageView!
    var newImage: UIImage?
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    func getFPO(from image: UIImage) -> VNFeaturePrintObservation? {
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            
            return nil
        }
    }
    
    @IBAction func compare(_ sender: Any) {
        
        guard let originalFPO = getFPO(from: original.image!) else { return }
        guard let compareFPO = getFPO(from: compare.image!) else { return }
        
        var distance = Float(0)
        try? compareFPO.computeDistance(&distance, to: originalFPO)
        print(100-distance)
        scoreLabel.text = "\(round((100-distance) * 100) / 100) 점 입니다."
        scoreLabel.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        original.image = UIImage(named: Shared.shared.CurTextImage ?? "c1_01_mj")
        compare.image = newImage
        
        
//        scoreLabel.isHidden = true
    }
}
