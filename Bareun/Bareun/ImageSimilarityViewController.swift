//
//  ImageSimilarityViewController.swift
//  Bareun
//
//  Created by YangYujin on 2021/01/16.
//

import UIKit
import Vision
import SwiftConfettiView



class ImageSimilarityViewController: UIViewController {

    
    @IBOutlet weak var original: UIImageView!
    @IBOutlet weak var compare: UIImageView!
    var newImage: UIImage?
//    var sharedImage: UIImage?
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    let ad = URL(string: "https://naver.com")
    var confettiView = SwiftConfettiView()
    var confettiView2 = SwiftConfettiView()
    
    @IBOutlet var SimilarityView: UIView!
    
    let customColor : UIColor = UIColor(displayP3Red: 252/255, green: 251/255, blue: 244/255, alpha: 1.0)
    
    var SendImage: UIImage?
    
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
    
    @IBAction func share(_ sender: Any) {
        guard let image = SimilarityView.transfromToImage() else { return }

        
        var sharedObject = [Any]()
        sharedObject.append(image)
        sharedObject.append("hello \nhttps://www.naver.com")

        let vc = UIActivityViewController(activityItems: sharedObject, applicationActivities: nil)
        vc.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        vc.popoverPresentationController?.permittedArrowDirections = []

        vc.popoverPresentationController?.sourceView = self.view
        vc.excludedActivityTypes = [.saveToCameraRoll] //
        self.present(vc, animated: true)
    }
    
    @IBAction func compare(_ sender: Any) {
        testButton.isEnabled = false
//        confettiView.stopConfetti()

//        guard let originalFPO = getFPO(from: original.image!) else { return }
//        guard let compareFPO = getFPO(from: compare.image!) else { return }
//
//        var distance = Float(0)
//        try? compareFPO.computeDistance(&distance, to: originalFPO)
        let comparedScore:Float = getSmallestScore(original: original.image!, compare: compare.image!)
        print("실제 정확도 \(comparedScore)")
        let blankScore:Float = getSmallestScore(original: original.image!, compare: UIImage(named:"blank")!)
//        scoreLabel.text = "\(round( comparedScore * 100) / 100) 점 입니다."
        print("최소 점수 \(blankScore)")
        
        // 유사도 new 공식
        let value: Float = (94.5 - blankScore) / 5
        print(value)
        switch comparedScore {
        case 0 ... (blankScore + value):
            let random = Int.random(in: 0...(score1.count - 1))
            scoreLabel.text = "⭐️"
            scoreTextLabel.text = score1[random]
            confettiView.startConfetti()
            confettiView2.startConfetti()

        case (blankScore + value) ... (blankScore + 2 * value):
            let random = Int.random(in: 0...(score2.count - 1))
            scoreLabel.text = "⭐️⭐️"
            scoreTextLabel.text = score2[random]

        case (blankScore + 2 * value) ... (blankScore + 3.4 * value):
            let random = Int.random(in: 0...(score3.count - 1))
            scoreLabel.text = "⭐️⭐️⭐️"
            scoreTextLabel.text = score3[random]

        case (blankScore + 3.4 * value) ... (blankScore + 4 * value):
            let random = Int.random(in: 0...(score4.count - 1))
            scoreLabel.text = "⭐️⭐️⭐️⭐️"
            scoreTextLabel.text = score4[random]
            
        case (blankScore + 4 * value) ... 100:
            let random = Int.random(in: 0...(score5.count - 1))
            scoreLabel.text = "⭐️⭐️⭐️⭐️⭐️"
            scoreTextLabel.text = score5[random]

        default:
            scoreLabel.text = "default"
        }
        
        shareButton.isEnabled = true
        scoreLabel.isHidden = false
        scoreTextLabel.isHidden = false
    }
    
    func getSmallestScore(original: UIImage, compare: UIImage) -> Float{
        guard let originalFPO = getFPO(from: original) else { return 0 }
        guard let compareFPO = getFPO(from: compare) else { return 0 }
        
        var distance = Float(0)
        try? compareFPO.computeDistance(&distance, to: originalFPO)
        
        return 100-distance
    }
    

    let textColor: UIColor = UIColor(displayP3Red: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SimilarityView.backgroundColor = customColor
        
        confettiView = SwiftConfettiView(frame:self.compare.bounds)
        confettiView2 = SwiftConfettiView(frame:self.compare.bounds)
        
        // Set colors (default colors are red, green and blue)
        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        
        confettiView2.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        // Set intensity (from 0 - 1, default intensity is 0.5)
        confettiView.intensity = 0.4
        confettiView2.intensity = 0.4
        
        // Set type
        confettiView.type = .confetti
        confettiView2.type = .diamond
        
        self.view.addSubview(confettiView)
        self.view.addSubview(confettiView2)
        
        

        
        
        scoreTextLabel.font = UIFont(name: "NanumMyeongjo", size: 18)
        
        var modelImage: UIImage = UIImage(named:Shared.shared.CurTextImage ?? "c1_01_mj")!
        modelImage = modelImage.cropToRect(rect: CGRect.init(25.0, 13.0,(modelImage.size.width)-25.0,(modelImage.size.height)/1.75))!
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
        
        shareButton.isEnabled = false
        scoreLabel.isHidden = true
        scoreTextLabel.isHidden = true
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
        let noAlphaImage = UIGraphicsGetImageFromCurrentImageContext()
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

extension UIView {
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
