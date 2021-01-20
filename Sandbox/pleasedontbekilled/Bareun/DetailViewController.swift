//
//  DetailViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit
import PencilKit
import PhotosUI


class DetailViewController: UIViewController,PKToolPickerObserver {

    @IBOutlet weak var EnglishMeaningLabel: UILabel!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var underlayView: UIImageView!

    var menu:MenuItem? = nil
    
    lazy var textImage: UIImage = {
        return UIImage(named: "c1_01_bh")!
    }()
    
    lazy var backgroundImg: UIImage = {
        return UIImage(named: "backgroundkorChangedSize")!
    }()
    
    @IBOutlet weak var layerHidden: UIBarButtonItem!
    let canvasWidth: CGFloat = 828
    let canvasOverscrollHeight:CGFloat = 500
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    var imageIndex: Int = 0
    // 선언해둔 이미지 이름의 배열을 선택한 카테고리와 폰트에 따라 받아오는 역할
    var tempArray:[String] = []
    
//    let pencilInteraction = UIPencilInteraction()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        assert(self.canvasView != nil)
        assert(self.underlayView != nil)
        assert(self.underlayView.superview == self.canvasView)
        super.viewDidLoad()

        let image = self.textImage

        let bottomImage = backgroundImg
        let topImage = textImage

        let size = CGSize(width: 2732, height: 1547)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: areaSize, blendMode: .normal, alpha: 0.8)

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.canvasView.translatesAutoresizingMaskIntoConstraints = false
        self.canvasView.contentInsetAdjustmentBehavior = .never
        self.canvasView.layer.borderColor = UIColor.red.cgColor
        self.canvasView.layer.borderWidth = 2.0
        self.canvasView.delegate = self
        self.canvasView.maximumZoomScale = 2.0
        self.canvasView.isOpaque = false
        self.canvasView.backgroundColor = .clear
        self.canvasView.contentOffset = CGPoint.zero
        self.canvasView.contentSize = newImage.size

        self.underlayView.contentMode = .scaleToFill
        self.underlayView.frame = CGRect(origin: CGPoint.zero, size: newImage.size)
        self.underlayView.image = newImage
        self.underlayView.layer.borderColor = UIColor.orange.cgColor
        self.underlayView.layer.borderWidth = 1.0
        
        titleLabel.text = menu?.name

        switch titleLabel.text {
        case "나를 깨우는 명언":
            tempArray = category1_myeongjo
            textImage = UIImage(named: tempArray[imageIndex]) ?? UIImage(named:"c1_01_mj")!
//            textImage.image = UIImage(named: Shared.shared.TextImageName)
            EnglishMeaningLabel.isHidden = true
        case "많이 틀리는 맞춤법":
            tempArray = category2_myeongjo
            textImage = UIImage(named: tempArray[imageIndex])!
            EnglishMeaningLabel.isHidden = true
        case "쓸모있는 영어 문장":
            backgroundImg = UIImage(named: "backgroundeng.png")!
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
        
//        canvasView.delegate = self
//        canvasView.drawing = drawing
//
//        canvasView.alwaysBounceVertical = true
//        canvasView.drawingPolicy = .anyInput
        
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
        self.canvasView.sendSubviewToBack(self.underlayView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.canvasView.becomeFirstResponder()
        self.canvasView.tool = PKInkingTool(.pen)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let contentSize = self.textImage.size
        self.canvasView.contentSize = contentSize
        self.underlayView.frame = CGRect(origin: CGPoint.zero, size: contentSize)
        let margin = (self.canvasView.bounds.size - contentSize) * 0.5
        let insets = [margin.width, margin.height].map { $0 > 0 ? $0 : 0 }
        self.canvasView.contentInset = UIEdgeInsets(top: insets[1], left: insets[0], bottom: insets[1], right: insets[0])
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover" {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
            
            if let vc = segue.destination as? PopOverViewController {
                vc.onChange = { font in
                    print(font)
                    if self.titleLabel.text == "쓸모있는 영어 문장" {
                        switch font {
                        case "Pinyon Script":
                            self.tempArray = category3_pinyon
                        case "Allan":
                            self.tempArray = category3_allan
                        case "Shadows Into Light Two":
                            self.tempArray = category3_shadow
                        default:
                            print("korean font")
                        }
                    } else {
                        switch font {
                    case "나눔명조체":
                        if self.titleLabel.text == "나를 깨우는 명언" {
                            self.tempArray = category1_myeongjo
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_myeongjo
                            } else {
                                self.tempArray = category4_myeongjo
                            }
                        case "바른히피체":
                            if self.titleLabel.text == "나를 깨우는 명언" {
                                self.tempArray = category1_bh
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_bh
                            } else {
                                self.tempArray = category4_bh
                            }
                        case "나눔바른펜":
                            if self.titleLabel.text == "나를 깨우는 명언" {
                                self.tempArray = category1_bp
                            } else if self.titleLabel.text == "많이 틀리는 맞춤법" {
                                self.tempArray = category2_bp
                            } else {
                                self.tempArray = category4_bp
                            }
                        default:
                            print("english font")
                        }
                    }
                    
                    self.textImage = UIImage(named: self.tempArray[self.imageIndex])!

                }
            }
        }
        Shared.shared.CurTextImage = self.tempArray[self.imageIndex]
        
        if segue.identifier == "testImage" {
            let dvc = segue.destination as! ImageSimilarityViewController
            UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, false, UIScreen.main.scale)
            self.canvasView.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true)
            
            let compareImage = UIGraphicsGetImageFromCurrentImageContext()
            dvc.newImage = compareImage
        }
    }
    
 
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
 
    
//    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
//        //더블클릭 인지 코드
//        if UIPencilInteraction.preferredTapAction == .switchPrevious {
//            if toolPicker.isVisible {
//                toolPicker.setVisible(false, forFirstResponder: canvasView)
//            } else {
//                toolPicker.setVisible(true, forFirstResponder: canvasView)
//            }
//        }
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
        if self.titleLabel.text == "쓸모있는 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
        }
       
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        

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
        if self.titleLabel.text == "쓸모있는 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
        }
       
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        
    }
    
    
    @IBAction func isLayerHidden(_ sender: Any) {
        if underlayView.isHidden {
            underlayView.isHidden = false
            layerHidden.image = UIImage(systemName: "eye")
        } else {
            underlayView.isHidden = true
            layerHidden.image = UIImage(systemName: "eye.slash")
        }

    }
    

    @IBAction func canvasClear(_ sender: Any) {
        
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        
        
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
        
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        
    }
    
    
    
    
    @IBAction func saveDrawingToCameraRoll(_ sender: Any) {
        
      
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        
        
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

        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { action in
            
        }))

        
    
    }
    
    
}

extension DetailViewController: PKCanvasViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.underlayView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        switch scrollView {
        case canvasView:
            print(Self.self, #function)
            // https://stackoom.com/question/3pNGe/%E5%A6%82%E4%BD%95%E5%B0%86UIImage%E8%BD%AC%E6%8D%A2%E6%88%96%E5%8A%A0%E8%BD%BD%E5%88%B0PKDrawing%E4%B8%AD
            let offsetX: CGFloat = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
            let offsetY: CGFloat = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
//            self.underlayView.frame.size = CGSize(width: self.view.bounds.width * scrollView.zoomScale, height: self.view.bounds.height * scrollView.zoomScale)
            self.underlayView.frame.size = self.textImage.size * self.canvasView.zoomScale
            
            self.underlayView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case canvasView:
            print(Self.self, #function)
        default:
            break
        }
    }

}



