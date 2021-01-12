//
//  DetailViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit
import PencilKit

class DetailViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var textImage: UIImageView!
    var menu:MenuItem? = nil
    
    let canvasWidth: CGFloat = 828
    let canvasOverscrollHeight:CGFloat = 500
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    var imageIndex: Int = 0
    // 선언해둔 이미지 이름의 배열을 선택한 카테고리와 폰트에 따라 받아오는 역할
    var tempArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = menu?.name

        switch titleLabel.text {
        case "쓸모있는 영어 문장":
            backgroundImg.image = UIImage(named: "backgroundeng.png")
            tempArray = category3_pinyon
            textImage.image = UIImage(named: tempArray[imageIndex])
            countLabel.text = "1/\(tempArray.count)"
        default:
            tempArray = category1_myeongjo
            textImage.image = UIImage(named: tempArray[imageIndex])
            countLabel.text = "1/\(tempArray.count)"
        }
        
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
//        updateLayout(for: toolPicker)
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
        if imageIndex >= (tempArray.count - 1) {
            imageIndex = 0
            countLabel.text = "\(1)/\(tempArray.count)"
        } else {
            imageIndex += 1
            countLabel.text = "\(imageIndex+1)/\(tempArray.count)"
        }
        textImage.image = UIImage(named: tempArray[imageIndex])
    }
    
    @IBAction func goToPreviousPage(_ sender: Any) {
        if imageIndex <= 0 {
            countLabel.text = "\(tempArray.count)/\(tempArray.count)"
            imageIndex = tempArray.count - 1
        } else {
            imageIndex -= 1
            countLabel.text = "\(imageIndex+1)/\(tempArray.count)"
        }
        textImage.image = UIImage(named: tempArray[imageIndex])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
