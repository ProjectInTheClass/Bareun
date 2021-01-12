//
//  ViewController.swift
//  CameraVison
//
//  Created by 이승민 on 2021/01/12.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    
    // 1. 카메라 컨트롤러 초기화
    let controller = CameraController()
    let model = MobileNetV2_SSDLite()
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?

    func setupModel() {
        
    }
    
    @IBOutlet weak var preview: UIImageView!
    @IBAction func capture(_ sender: Any) {
        controller.captureImage(completion: { (image, error) in
            if let img = image {
                self.preview.image = img
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let visionModel = try? VNCoreMLModel(for: self.model.model) {
            self.visionModel = visionModel
            self.request = VNCoreMLRequest(model: visionModel, completionHandler: { request, error in
                if error != nil {
                    print(error)
                } else {
                    print(request.results)  // 해당 요청에 대한 결과물
                }
            })
        }
        // Do any additional setup after loading the view.
//        controller.prepare(output: .photo, completion: { error in
//            if error != nil {
//                print(error)
//            } else {
//                try? self.controller.displayPreview(on: self.view)
//            }
//
//        })
        controller.sampleBufferDelegate = self
        controller.prepare(output: .video, completion: { error in
            try? self.controller.displayPreview(on: self.view)
        })
    }
    

}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let image = controller.imageFromSampleBuffer(sampleBuffer: sampleBuffer)
//        self.preview.image = image
        print(image)
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        try? handler.perform([self.request!])
    }
}
