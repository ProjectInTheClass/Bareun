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
        scoreLabel.text = "점 입니다."
        scoreLabel.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.isHidden = true
    }
}
