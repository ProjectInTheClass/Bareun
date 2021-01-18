//
//  DetailViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit
import PencilKit
import PhotosUI


class DetailViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScrollViewDelegate {

    @IBOutlet weak var EnglishMeaningLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var textImage: UIImageView!
    var menu:MenuItem? = nil
    
    var backgroundImgCenter : CGPoint = CGPoint(x: 0, y: 0)
    var textImageCenter : CGPoint = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var layerHidden: UIBarButtonItem!
    let canvasWidth: CGFloat = 828
    let canvasOverscrollHeight:CGFloat = 500
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    var imageIndex: Int = 0
    // 선언해둔 이미지 이름의 배열을 선택한 카테고리와 폰트에 따라 받아오는 역할
    var tempArray:[String] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // 스크롤뷰
        scrollView.delegate = self
        self.scrollView.isScrollEnabled = true
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0

//        backgroundImgCenter = backgroundImg.center
//        textImageCenter = textImage.center

        self.scrollView.contentSize = self.canvasView.frame.size
        // 여기까지 for Zoom
        
        titleLabel.text = menu?.name

        switch titleLabel.text {
        case "나를 깨우는 명언":
            tempArray = category1_myeongjo
            textImage.image = UIImage(named: tempArray[imageIndex])
//            textImage.image = UIImage(named: Shared.shared.TextImageName)
            EnglishMeaningLabel.isHidden = true
        case "많이 틀리는 맞춤법":
            tempArray = category2_myeongjo
            textImage.image = UIImage(named: tempArray[imageIndex])
            EnglishMeaningLabel.isHidden = true
        case "쓸모있는 영어 문장":
            backgroundImg.image = UIImage(named: "backgroundeng.png")
            tempArray = category3_pinyon
            textImage.image = UIImage(named: tempArray[imageIndex])
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        case "대학 슬로건":
            tempArray = category4_myeongjo
            textImage.image = UIImage(named: tempArray[imageIndex])
            EnglishMeaningLabel.isHidden = true
        default:
            print("error!")
        }
        countLabel.text = "\((imageIndex) + 1)/\(tempArray.count)"
        
        canvasView.delegate = self
        canvasView.drawing = drawing
        
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
        
        updateContentSizeForDrawing()
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover" {
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
                    
                    self.textImage.image = UIImage(named: self.tempArray[self.imageIndex])

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
    
    // zoom for canvasView
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.canvasView
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 이게 canvasview랑 backgroundImg & textImage 같이 스케일되라고 작성한 코드
    func scrollViewDidZoom(_ scrollView: UIScrollView) {

//        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
        print(self.scrollView.contentSize)
        print(self.canvasView.contentSize)
        print(self.canvasView.frame)
        
        
// canvas view content size (그려지는 영역 늘리기)
        canvasView.contentSize.transform = CGAffineTransform(scaleX: scrollView.zoomScale, y: scrollView.zoomScale)
//        backgroundImg.transform = CGAffineTransform(scaleX: scrollView.zoomScale, y: scrollView.zoomScale)
//        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
//        var translatedPoint = backgroundImgCenter.applying(scaleAffineTransform)
//        backgroundImg.transform = CGAffineTransform.identity.translatedBy(x: translatedPoint.x - backgroundImgCenter.x , y: translatedPoint.y - backgroundImgCenter.y)
//        translatedPoint = textImageCenter.applying(scaleAffineTransform)
//        textImage.transform = CGAffineTransform.identity.translatedBy(x: translatedPoint.x - textImageCenter.x, y: translatedPoint.y - textImageCenter.y)

//        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
//        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
//        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }

    
    // 여기까지..
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        scrollView.contentSize = self.canvasView.bounds.size.applying(scaleAffineTransform)
    }

    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSizeForDrawing()
    }
    
    func updateContentSizeForDrawing() {
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
        
        if !drawing.bounds.isNull {
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasOverscrollHeight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }
        
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
    }
    
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
        textImage.image = UIImage(named: tempArray[imageIndex])
        Shared.shared.CurTextImage = tempArray[imageIndex]
        if self.titleLabel.text == "쓸모있는 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
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
        textImage.image = UIImage(named: tempArray[imageIndex])
        Shared.shared.CurTextImage = tempArray[imageIndex]
        if self.titleLabel.text == "쓸모있는 영어 문장"{
            EnglishMeaningLabel.text = EnglishMeaning[imageIndex]
        }
        else{
            EnglishMeaningLabel.text = ""
        }
    }
    
    
    @IBAction func isLayerHidden(_ sender: Any) {
        if textImage.isHidden {
            textImage.isHidden = false
            layerHidden.image = UIImage(systemName: "eye")
        } else {
            textImage.isHidden = true
            layerHidden.image = UIImage(systemName: "eye.slash")
        }

    }
    

    @IBAction func canvasClear(_ sender: Any) {
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

    @IBAction func saveDrawingToCameraRoll(_ sender: Any) {
        
        let alert = UIAlertController(title: "현재 손글씨를 카메라 롤에 저장하시겠습니까?", message: "저장을 누를 시 바로 저장됩니다.", preferredStyle: .alert)

        self.present(alert, animated: true)
            
        alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { action in
            UIGraphicsBeginImageContextWithOptions(self.backgroundImg.bounds.size, false, UIScreen.main.scale)
            UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, false, UIScreen.main.scale)
            self.backgroundImg.drawHierarchy(in: self.backgroundImg.bounds, afterScreenUpdates: true)
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



