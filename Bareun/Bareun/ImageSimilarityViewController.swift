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
    

    let textColor: UIColor = UIColor(displayP3Red: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
    
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
        filter?.setValue(CIColor(red: 0.94, green: 0.94, blue: 0.94), forKey: "inputColor")

        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return }

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            newImage = processedImage
//            print(processedImage.size)
        }
        newImage = newImage?.maskWithColors(color: textColor)
//        newImage = newImage?.maskWithColors(color: textColor)
        original.image = modelImage
        compare.image = newImage

        
        scoreLabel.isHidden = true
    }
}

extension UIImage {
    func maskWithColors(color: UIColor) -> UIImage? {
        let maskingColors: [CGFloat] = [0,0,0,0,0,0,0]
        let maskImage = cgImage! //
        let bounds = CGRect(x: 0, y: 0, width: size.width * 3, height: size.height * 3) // * 3, for best resolution.
        let sz = CGSize(width: size.width * 3, height: size.height * 3) // Size.
        var returnImage: UIImage? // Image, to return


        UIGraphicsBeginImageContextWithOptions(sz, true, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -sz.height)
        context.draw(maskImage, in: bounds)
        context.restoreGState()
        let noAlphaImage = UIGraphicsGetImageFromCurrentImageContext()  elements.
        UIGraphicsEndImageContext()

        let noAlphaCGRef = noAlphaImage?.cgImage // get CGImage.

        if let imgRefCopy = noAlphaCGRef?.copy(maskingColorComponents: maskingColors) { // Magic.
            UIGraphicsBeginImageContextWithOptions(sz, false, 0.0)
            let context = UIGraphicsGetCurrentContext()!
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0, y: -sz.height)
            context.clip(to: bounds, mask: maskImage)
            context.setFillColor(color.cgColor)
            context.fill(bounds)
            context.draw(imgRefCopy, in: bounds) // draw new image
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            returnImage = finalImage! // YEAH!
            UIGraphicsEndImageContext()
        }
        return returnImage
    }
}
