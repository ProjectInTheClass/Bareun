import AVFoundation
import UIKit
import Vision

/**
 AVFoundation을 사용해서 영상의 입출력을 제어합니다.
 */

class CameraController: NSObject {
    fileprivate var captureSession: AVCaptureSession?
    fileprivate var frontCamera: AVCaptureDevice?
    fileprivate var rearCamera: AVCaptureDevice?
    
    fileprivate var currentPosition: CameraPosition?
    fileprivate var frontCameraInput: AVCaptureDeviceInput?
    fileprivate var rearCameraInput: AVCaptureDeviceInput?
    
    fileprivate var photoOutput: AVCapturePhotoOutput?
    fileprivate var videoOutput: AVCaptureVideoDataOutput?
    
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer?
    
    fileprivate var flashMode = AVCaptureDevice.FlashMode.off
    fileprivate var deviceOrientationOnCapture: UIDeviceOrientation?
    
    var sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate? = nil
    
    fileprivate let dataOutputQueue = DispatchQueue(
        label: "video data queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
    
    /**
     현재 선택된 카메라가 전면카메라인지, 후면카메라인지 알려줍니다.
     */
    var position: CameraPosition? {
        get {
            return self.currentPosition
        }
    }
    var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
}

extension CameraController {
    enum OutputType {
        case video
        case photo
    }
    /**
     AVCaptureSession을 준비합니다. 다른 메소드 사용에 앞서 먼저 호출되어야 합니다.
     - parameters:
        - completion: 세션 준비가 끝나면 호출됩니다. 과정 중 에러가 발생하면 Error 가 들어옵니다.
     */
    func prepare(output: OutputType, completion: @escaping (Error?) -> Void) {
        // 1. Capture Session 생성
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
        }
        // 2. CaptureDevice 획득 및 설정
        func configureCaptureDevices() throws {
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
            let cameras = session.devices.compactMap { $0 }
            if cameras.isEmpty { throw CameraControllerError.noCameraAvailable }
            
            for camera in cameras {
                if camera.position == .front {
                    self.frontCamera = camera
                }
                if camera.position == .back {
                    self.rearCamera = camera
                    
                    // 후면 카메라 오토 포커싱 설정
                    try camera.lockForConfiguration()
                    camera.focusMode = .continuousAutoFocus
                    camera.unlockForConfiguration()
                }
            }
        }
        // 3. 2번에서 획득한 Device로 Input 생성
        func configureDeivceInputs() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.sessionIsMissing }
            
            if let rearCamera = self.rearCamera {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
                
                self.currentPosition = .rear
                
            } else if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
                
                self.currentPosition = .front
            } else {
                throw CameraControllerError.noCameraAvailable
            }
        }
        // 4. 사진을 출력하기 위한 Output 설정
        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.sessionIsMissing }
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
        }
        // 5. 영상을 출력하기 위한 Output 설정
        func configureVideoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.sessionIsMissing }
            self.videoOutput = AVCaptureVideoDataOutput()
            if let delegate = self.sampleBufferDelegate {
                videoOutput?.setSampleBufferDelegate(delegate, queue: self.dataOutputQueue)
                videoOutput?.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

                if let videoConnection = videoOutput?.connection(with: .video) {
                    videoConnection.videoOrientation = .portrait
                }
            }
            if captureSession.canAddOutput(self.videoOutput!) {
                captureSession.addOutput(self.videoOutput!)
            }
        }
        
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeivceInputs()
                
                switch output {
                case .photo:
                    try configurePhotoOutput()
                case .video:
                    try configureVideoOutput()
                }
                
                // CaptureSession 실행
                self.captureSession?.startRunning()
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    /**
     플레시 모드를 토글합니다. 결과값으로 현재 플래시 모드가 켜져 있다면 true, 아니면 false를 리턴합니다.
     */
    func toggleFlashMode() -> Bool{
        if flashMode == .on {
            flashMode = .off
        } else {
            flashMode = .on
        }
        
        return flashMode == .on
    }
    /**
     Front / Rear 카메라를 토글합니다.
    */
    func switchCameras() throws {
        guard let currentPosition = self.currentPosition, let captureSession = self.captureSession, captureSession.isRunning else {
            throw CameraControllerError.sessionIsMissing
        }
        
        captureSession.beginConfiguration()
        
        func switchToFrontCamera() throws {
            let inputs = captureSession.inputs
            guard let rearCameraInput = self.rearCameraInput, inputs.contains(rearCameraInput), let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }
            
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            captureSession.removeInput(rearCameraInput)
        
            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)
                self.currentPosition = .front
            } else {
                throw CameraControllerError.invalidOperation
            }
        }
        func switchToRearCamera() throws {
            let inputs = captureSession.inputs
            guard let frontCameraInput = self.frontCameraInput, inputs.contains(frontCameraInput), let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }
               
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
        
            captureSession.removeInput(frontCameraInput)
            
            if captureSession.canAddInput(self.rearCameraInput!) {
                captureSession.addInput(self.rearCameraInput!)
                self.currentPosition = .rear
            } else {
                throw CameraControllerError.invalidOperation
            }
        }
        
        switch currentPosition {
        case .front:
            try switchToRearCamera()
        case .rear:
            try switchToFrontCamera()
        }
        
        captureSession.commitConfiguration()
    }
    
    func stop() {
        self.captureSession?.stopRunning()
    }
    
    func resume() {
        if !(self.captureSession?.isRunning ?? true) {
            self.captureSession?.startRunning()
        }
    }
    /**
     원하는 UIView 안에 PreviewLayer를 추가하여 카메라로 들어온 영상을 출력합니다.
     - parameters:
        - _view: 해당 뷰 안에 Preview Layer를 추가합니다.
     */
    func displayPreview(on _view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.sessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        _view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = _view.bounds
    }
    
    /**
    설정된 AVCaptureSession으로 사진을 촬영합니다.
    - parameters:
       - completion: 촬영이 완료되면 호출합니다. 결과값이 UIImage로, 만약 에러가 발생했다면 Error가 들어옵니다.
    */
    func captureImage(completion: @escaping (UIImage?, Error?)->Void) {
        guard let captureSession = captureSession, captureSession.isRunning else { completion(nil, CameraControllerError.sessionIsMissing); return }
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        
        self.photoCaptureCompletionBlock = completion
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    
    fileprivate func cropCameraImage(original: UIImage, previewLayer: AVCaptureVideoPreviewLayer) -> UIImage? {
         
        var image = UIImage()
           
        let previewImageLayerBounds = previewLayer.bounds
           
        let originalWidth = original.size.width
        let originalHeight = original.size.height
           
        let A = previewImageLayerBounds.origin
        let B = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.origin.y)
        let D = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.size.height)
           
        let a = previewLayer.captureDevicePointConverted(fromLayerPoint: A)
        let b = previewLayer.captureDevicePointConverted(fromLayerPoint: B)
        let d = previewLayer.captureDevicePointConverted(fromLayerPoint: D)
           
        let posX = floor(b.x * originalHeight)
        let posY = floor(b.y * originalWidth)
        
        let width: CGFloat = d.x * originalHeight - b.x * originalHeight
        let height: CGFloat = a.y * originalWidth - b.y * originalWidth
           
        let cropRect = CGRect(x: posX, y: posY, width: width, height: height)
           
        if let imageRef = original.cgImage?.cropping(to: cropRect) {
            image = UIImage(cgImage: imageRef, scale: 2.5, orientation: .right)
        }
           
        return image
    }
    
    func convert(rect: CGRect) -> CGRect? {
        print(rect)
        guard let previewLayer = self.previewLayer else { return  nil }
        let origin = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)
        let size = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.size.cgPoint)
      
        return CGRect(origin: origin, size: size.cgSize)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            self.photoCaptureCompletionBlock?(nil, error)
        } else {
            guard let imageData = photo.fileDataRepresentation() else { return }
            guard let uiImage = UIImage(data: imageData) else { return }
            guard let previewLayer = self.previewLayer else { return }

            let resultImage = self.cropCameraImage(original: uiImage, previewLayer: previewLayer)
            self.photoCaptureCompletionBlock?(resultImage, nil)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.deviceOrientationOnCapture = UIDevice.current.orientation
    }
}

extension CameraController {
    enum CameraControllerError: Swift.Error {
        case sessionAlreadyRunning
        case sessionIsMissing
        case invalidInput
        case invalidOperation
        case noCameraAvailable
        case unknown
    }
    
    enum CameraPosition {
        case front
        case rear
    }
}

extension CameraController {
    func imageFromSampleBuffer(sampleBuffer : CMSampleBuffer) -> UIImage
      {
        // Get a CMSampleBuffer's Core Video image buffer for the media data
        let  imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);


        // Get the number of bytes per row for the pixel buffer
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer!);

        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!);
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer!);
        let height = CVPixelBufferGetHeight(imageBuffer!);

        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB();

        // Create a bitmap graphics context with the sample buffer data
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
        let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        let quartzImage = context?.makeImage();
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);

        // Create an image object from the Quartz image
        let image = UIImage.init(cgImage: quartzImage!);

        return (image);
      }
}
