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
    
    func TransperentImageToWhite(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let imageRect: CGRect = CGRect.init(0.0, 0.0, image.size.width, image.size.height)
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        // Draw a white background (for white mask)
        ctx.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ctx.fill(imageRect)
        // Apply the source image's alpha
        image.draw(in: imageRect, blendMode: .normal, alpha: 1.0)
        let mask: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mask
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var modelImage: UIImage = UIImage(named:Shared.shared.CurTextImage ?? "c1_01_mj")!
        modelImage = modelImage.cropToRect(rect: CGRect.init(0.0,0.0,(modelImage.size.width),(modelImage.size.height)/1.5))!
//        newImage = TransperentImageToWhite(image: newImage!)
        guard let currentCGImage = newImage?.cgImage else { return }
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")

        // set a gray value for the tint color
        filter?.setValue(CIColor(red: 0.58, green: 0.58, blue: 0.58), forKey: "inputColor")

        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return }

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            newImage = processedImage
//            print(processedImage.size)
        }
//        newImage = newImage?.maskWithColors(color: textColor)
        original.image = modelImage
        compare.image = newImage
ß
        
        scoreLabel.isHidden = true
    }
}

