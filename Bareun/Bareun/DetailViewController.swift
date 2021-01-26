//
//  DetailViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit
import PencilKit
import PhotosUI


class DetailViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScrollViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var EnglishMeaningLabel: UILabel!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var underlayView : UIImageView!
    @IBOutlet weak var overlayView: UIImageView!
    
    @IBOutlet var tapView: UITapGestureRecognizer!
    // 탭 -> 펜슬킷 내려가기
    @IBAction func tapView(_ sender: UIGestureRecognizer) {
        print("touched")
        toolPicker.setVisible(false, forFirstResponder: canvasView)
    }
    
    //-> swipe하면 다음 페이지
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    @IBAction func swipeAction(_ sender: Any) {
        if canvasView.zoomScale == 1.0 {
            if swipeRecognizer.direction ==  .left {

                goToNextPage(self)

            }
        }
    }
    
    var menu:MenuItem? = nil
  
    var textImage: UIImage = UIImage(named:"c1_01_mj")!
    var backgroundImage: UIImage = UIImage(named:"backgroundkor")!
    
    @IBAction func unwindFromImageSimil(segue:UIStoryboardSegue) {}
    
//    lazy var textImage: UIImage = {
//        return UIImage(named: "c1_01_mj")!
//    }()
//    lazy var backgroundImage: UIImage = {
//        return UIImage(named: "backgroundkorChangedSize")!
//    }() //underlay
    
    @IBOutlet weak var layerHidden: UIBarButtonItem!
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    var imageIndex: Int = 0
    // 선언해둔 이미지 이름의 배열을 선택한 카테고리와 폰트에 따라 받아오는 역할
    var tempArray:[String] = []
    
    var bounds = UIScreen.main.bounds.size
//    let pencilInteraction = UIPencilInteraction()
    
    override func viewDidLoad() {
        assert(self.canvasView != nil)
        assert(self.underlayView != nil)
        assert(self.underlayView.superview == self.canvasView)
        
        super.viewDidLoad()
        //Gesture
        swipeRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        
        let tapGesture = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.responds(to:)))
        self.view.addGestureRecognizer(swipeRecognizer)
        
        self.view.addGestureRecognizer(tapGesture)
        //
        var textImage = self.textImage
        var backgroundImage = self.backgroundImage
        self.canvasView.translatesAutoresizingMaskIntoConstraints = false
        self.canvasView.contentInsetAdjustmentBehavior = .never
//        self.canvasView.layer.borderColor = UIColor.red.cgColor
//        self.canvasView.layer.borderWidth = 2.0
        self.canvasView.delegate = self
        self.canvasView.maximumZoomScale = 2.0
        self.canvasView.minimumZoomScale = 1.0
//        self.canvasView.zoomScale = 0.3
        self.canvasView.isOpaque = false
        self.canvasView.backgroundColor = .clear
        self.canvasView.contentOffset = CGPoint.zero
        self.canvasView.contentSize = textImage.size
        
        self.canvasView.showsHorizontalScrollIndicator = false
        self.canvasView.showsVerticalScrollIndicator = false
        
//        print("First Scene")
//        print(self.underlayView.frame)
//        print(self.overlayView.frame)
//        print(self.canvasView.contentSize)
//        print(self.canvasView.frame)
//        print("============================")
        
        self.underlayView.contentMode = .scaleToFill
        self.underlayView.frame = CGRect(origin: CGPoint.zero, size: canvasView.frame.size)
        
//        self.underlayView.layer.borderColor = UIColor.orange.cgColor
//        self.underlayView.layer.borderWidth = 1.0

        self.overlayView.contentMode = .scaleToFill
        self.overlayView.frame = CGRect(origin: CGPoint.zero, size: canvasView.frame.size)
        
        titleLabel.text = menu?.name
        countLabel.font = UIFont(name: "NanumMyeongjo", size: 17)
        EnglishMeaningLabel.font = UIFont(name: "NanumMyeongjo", size: 18)

        switch titleLabel.text {
        case "나를 위한 바른 명언":
            tempArray = category1_myeongjo
            textImage = UIImage(named: tempArray[imageIndex])!
            EnglishMeaningLabel.isHidden = true
        case "많이 틀리는 맞춤법":
            tempArray = category2_myeongjo
            textImage = UIImage(named: tempArray[imageIndex])!
            EnglishMeaningLabel.isHidden = true
        case "알아두면 좋은 영어 문장":
            backgroundImage = UIImage(named: "backgroundeng2.png")!
            tempArray = category3_pinyon
            textImage = UIImage(named: tempArray[imageIndex])!
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        case "대학 슬로건":
            tempArray = category4_myeongjo
            textImage = UIImage(named: tempArray[imageIndex])!
            EnglishMeaningLabel.isHidden = true
        default:
            print("error!")
        }
        countLabel.text = "\((imageIndex) + 1)/\(tempArray.count)"
        Shared.shared.CurTextImage = self.tempArray[self.imageIndex]
        self.underlayView.image = backgroundImage
        self.overlayView.image = textImage
        if (titleLabel.text != "알아두면 좋은 영어 문장" || canvasView.zoomScale != 1.0 ){
            EnglishMeaningLabel.isHidden = true
        } else{
            EnglishMeaningLabel.isHidden = false
        }
//        canvasView.delegate = self
//        canvasView.drawing = drawing
//
//        canvasView.alwaysBounceVertical = true
//        canvasView.drawingPolicy = .anyInput
//
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
        }
        
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(self)
        canvasView.becomeFirstResponder()
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.canvasView.sendSubviewToBack(self.overlayView)
        self.canvasView.sendSubviewToBack(self.underlayView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.canvasView.becomeFirstResponder()
        self.canvasView.tool = PKInkingTool(.pen)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.underlayView
    }
    
    func viewForZooming2(in scrollView: UIScrollView) -> UIView? {
        return self.overlayView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        switch scrollView {
        case canvasView:

            let paperSize = self.canvasView.frame.size * self.canvasView.zoomScale
            
            self.underlayView.frame.size = paperSize
            self.overlayView.frame.size = paperSize
            self.canvasView.contentSize = paperSize
            
            if (titleLabel.text != "알아두면 좋은 영어 문장" || canvasView.zoomScale != 1.0 ){
                EnglishMeaningLabel.isHidden = true
            } else{
                EnglishMeaningLabel.isHidden = false
            }
            
        default:
            break
        }

    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
//        let offsetX: CGFloat = 0
//        let offsetY: CGFloat = 0

        let paperSize = self.canvasView.frame.size * self.canvasView.zoomScale
        
        
        self.underlayView.frame.size = paperSize
        self.overlayView.frame.size = paperSize
        self.canvasView.contentSize = paperSize
        
        self.EnglishMeaningLabel.frame.origin = CGPoint(30, self.canvasView.frame.size.height * 0.215)
        
        if (titleLabel.text != "알아두면 좋은 영어 문장" || canvasView.zoomScale != 1.0 ){
            EnglishMeaningLabel.isHidden = true
        } else{
            EnglishMeaningLabel.isHidden = false
        }
//        print(self.underlayView.frame)
//        print(self.overlayView.frame)
//        print(self.canvasView.contentSize)
//        print(self.canvasView.frame)
//        print("============================")
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover" {
            if toolPicker.isVisible {
                toolPicker.setVisible(false, forFirstResponder: canvasView)
            }
            
            if let vc = segue.destination as? PopOverViewController {
                vc.onChange = { font in
                    print(font)
                    if self.titleLabel.text == "알아두면 좋은 영어 문장" {
                        switch font {
                        case "Pinyon Script":
                            self.tempArray = category3_pinyon
                        case "Allan":
                            self.tempArray = category3_allan
                        case "Shadows Into Light Two":
                            self.tempArray = category3_shadow
                        case "Kalam":
                            self.tempArray = category3_kalam
                        case "Petit Formal Script":
                            self.tempArray = category3_petit
                        case "Sacramento":
                            self.tempArray = category3_sacra
                        case "나눔바른펜(한/영)":
                            self.tempArray = category3_bp
                        default:
                            print("korean font")
                        }
                    } else {
                        switch font {
                    case "나눔명조체":
                        if self.titleLabel.text == "나를 위한 바른 명언" {
                            self.tempArray = category1_myeongjo
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_myeongjo
                            } else {
                                self.tempArray = category4_myeongjo
                            }
                        case "바른히피체":
                            if self.titleLabel.text == "나를 위한 바른 명언" {
                                self.tempArray = category1_bh
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_bh
                            } else {
                                self.tempArray = category4_bh
                            }
                        case "나눔바른펜(한/영)":
                            if self.titleLabel.text == "나를 위한 바른 명언" {
                                self.tempArray = category1_bp
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_bp
                            } else if self.titleLabel.text == "대학 슬로건" {
                                self.tempArray = category4_bp
                            }
                        case "느릿느릿체":
                            if self.titleLabel.text == "나를 위한 바른 명언" {
                                self.tempArray = category1_nl
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_nl
                            } else {
                                self.tempArray = category4_nl
                            }
                        case "유니 띵땅띵땅":
                            if self.titleLabel.text == "나를 위한 바른 명언" {
                                self.tempArray = category1_dd
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_dd
                            } else {
                                self.tempArray = category4_dd
                            }
                        case "카페24 고운밤":
                            if self.titleLabel.text == "나를 위한 바른 명언" {
                                self.tempArray = category1_gb
                            }
                        default:
                            print("english font")
                        }
                    }
                    
                    self.textImage = UIImage(named: self.tempArray[self.imageIndex])!
                    Shared.shared.CurTextImage = self.tempArray[self.imageIndex]
                    self.overlayView.image = self.textImage
                }
            }
        }
        
        if segue.identifier == "testImage" {
            let dvc = segue.destination as! ImageSimilarityViewController
            canvasView.zoomScale = 1.0
            underlayView.isHidden = true
            overlayView.isHidden = true
            EnglishMeaningLabel.isHidden = true
            
            UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, false, UIScreen.main.scale)
            self.canvasView.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true)
            
            
            var compareImage = UIGraphicsGetImageFromCurrentImageContext()
            
//            compareImage = UIImage.cropToBounds(image: compareImage, width: compareImage?.size.width, height: (compareImage?.size.height)!/2)
            compareImage = compareImage?.cropToRect(rect: CGRect.init(25.0,13.0,(compareImage?.size.width)!-25.0,(compareImage?.size.height)!/1.75))

            dvc.newImage = compareImage
            underlayView.isHidden = false
            overlayView.isHidden = false
            EnglishMeaningLabel.isHidden = false
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        switch scrollView {
//        case canvasView:
//            print(Self.self, #function)
//        default:
//            break
//        }
//    }
    
//    override var prefersHomeIndicatorAutoHidden: Bool {
//        return true
//    }
    
  
    
    @IBAction func toolIsHidden(_ sender: Any) {
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
            } else {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
        }
        
    }

    @IBAction func goToNextPage(_ sender: Any) {
        canvasView.drawing = PKDrawing()
        if imageIndex >= (tempArray.count - 1) {
            imageIndex = 0
            countLabel.text = "\(1)/\(tempArray.count)"
            
        } else {
            imageIndex += 1
            countLabel.text = "\(imageIndex+1)/\(tempArray.count)"
        }
        textImage = UIImage(named: tempArray[imageIndex])!
        Shared.shared.CurTextImage = tempArray[imageIndex]
        if self.titleLabel.text == "알아두면 좋은 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
        }
        overlayView.image = textImage
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        }
        if (titleLabel.text == "알아두면 좋은 영어 문장" || canvasView.zoomScale != 1.0 ){
            EnglishMeaningLabel.isHidden = true
        } else{
            EnglishMeaningLabel.isHidden = false
        }
    }
    
    @IBAction func goToPreviousPage(_ sender: Any) {
        canvasView.drawing = PKDrawing()
        if imageIndex <= 0 {
            countLabel.text = "\(tempArray.count)/\(tempArray.count)"
            imageIndex = tempArray.count - 1
            
        } else {
            imageIndex -= 1
            countLabel.text = "\(imageIndex+1)/\(tempArray.count)"
        }
        textImage = UIImage(named: tempArray[imageIndex])!
        Shared.shared.CurTextImage = tempArray[imageIndex]
        if self.titleLabel.text == "알아두면 좋은 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
        }
        overlayView.image = textImage
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        }
        if (titleLabel.text != "알아두면 좋은 영어 문장" || canvasView.zoomScale != 1.0 ){
            EnglishMeaningLabel.isHidden = true
        } else{
            EnglishMeaningLabel.isHidden = false
        }
    }
    
    
    @IBAction func isLayerHidden(_ sender: Any) {
        if overlayView.isHidden {
            overlayView.isHidden = false
            EnglishMeaningLabel.isHidden = false
            layerHidden.image = UIImage(systemName: "eye")
        } else {
            overlayView.isHidden = true
            EnglishMeaningLabel.isHidden = true
            layerHidden.image = UIImage(systemName: "eye.slash")
        }

    }
    

    @IBAction func canvasClear(_ sender: Any) {
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        }
        canvasView.drawing = PKDrawing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func Simil_Button_Clicked(_ sender: Any) {
        
        canvasView.zoomScale = 1.0
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        }
    }

    
    @IBAction func saveDrawingToCameraRoll(_ sender: Any) {
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        }
        sleep(1/2)
        canvasView.zoomScale = 1.0
        overlayView.isHidden = true
        EnglishMeaningLabel.text = " "
        
        let alert = UIAlertController(title: "현재 손글씨를 카메라 롤에 저장하시겠습니까?", message: "저장을 누를 시 바로 저장됩니다.", preferredStyle: .alert)
        
        self.present(alert, animated: true)
       
        alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { action in
            UIGraphicsBeginImageContextWithOptions(self.underlayView.bounds.size, false, UIScreen.main.scale)
            UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, false, UIScreen.main.scale)
            self.underlayView.drawHierarchy(in: self.underlayView.bounds, afterScreenUpdates: true)
            self.canvasView.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true)
            
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            if image != nil{
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image!)
                }, completionHandler: {success, error in
                    // deal with success or error
                })
            }
            
            sleep(1/2)
            self.overlayView.isHidden = false
            if (self.titleLabel.text=="알아두면 좋은 영어 문장"){
                self.EnglishMeaningLabel.text = EnglishMeaning[self.imageIndex]
                self.EnglishMeaningLabel.isHidden = false
            }

        }))
        
        // subViews 자식 뷰 배열
        // for 문 글자이미지를 만나면( remove from super view 함수 )
        // canvasView를 copy 변수 글자가 있는 이미지면 삭제
        // 일단, hidden으로 숨기고 저장 시도하기~
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { action in
            sleep(1/2)
            self.overlayView.isHidden = false
            
            if (self.titleLabel.text=="알아두면 좋은 영어 문장"){
                self.EnglishMeaningLabel.text = EnglishMeaning[self.imageIndex]
                self.EnglishMeaningLabel.isHidden = false
            }
            
        }))
        
       
    }
    
}

extension UIImage {
    func cropToRect(rect: CGRect!) -> UIImage? {
        // Correct rect size based on the device screen scale
        let scaledRect = CGRect.init(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
        // New CGImage reference based on the input image (self) and the specified rect
        let imageRef = self.cgImage!.cropping(to: scaledRect);
        // Gets an UIImage from the CGImage
        let result = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        // Returns the final image, or NULL on error
        return result;
    }
}
