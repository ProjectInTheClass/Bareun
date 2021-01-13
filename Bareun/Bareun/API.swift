//
//  API.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/05.
//

import Foundation


//final class Shared {
//    static let shared = Shared()
//
//    var FontName : String! = "나눔명조"
//    var TextImageName : String = "c1_01_mj"
//}

final class Shared {
    static let shared = Shared()
    
    var FontName : String! = "나눔명조"
}

class MENU {
    static let shared = MENU()
    
    var items:[MenuItem] = [
        MenuItem(name: "나를 깨우는 명언", image: "category1.png"),
        MenuItem(name: "많이 틀리는 맞춤법", image: "category1.png"),
        MenuItem(name: "쓸모있는 영어 문장", image: "category1.png"),
        MenuItem(name: "대학 슬로건", image: "category1.png"),
    ]
    
    var fontItems:[FontInfo] = [
        FontInfo(fontName: "나눔명조체", infoHidden: true),
        FontInfo(fontName: "바른히피체", infoHidden: true),
        FontInfo(fontName: "나눔바른펜", infoHidden: true),
        FontInfo(fontName: "Pinyon Script", infoHidden: false),
        FontInfo(fontName: "Allan", infoHidden: false),
        FontInfo(fontName: "Shadows Into Light Two", infoHidden: false)
    ]
    
    func getMenuItems(completion: ([MenuItem]) -> Void) {
        completion(self.items)
    }
    
    func getFontItems(completion: ([FontInfo]) -> Void) {
        completion(self.fontItems)
    }
}

var category1_myeongjo:[String] = [
    "c1_01_mj.png", "c1_02_mj.png", "c1_03_mj.png", "c1_04_mj.png", "c1_05_mj.png",
    "c1_06_mj.png", "c1_07_mj.png", "c1_08_mj.png", "c1_09_mj.png", "c1_10_mj.png",
    "c1_11_mj.png", "c1_12_mj.png", "c1_13_mj.png", "c1_14_mj.png", "c1_15_mj.png"
]

var category2_myeongjo:[String] = [
    "c2_01_mj.png", "c2_02_mj.png", "c2_03_mj.png", "c2_04_mj.png", "c2_05_mj.png",
    "c2_06_mj.png", "c2_07_mj.png", "c2_08_mj.png", "c2_09_mj.png"
]

var category3_pinyon:[String] = [
    "01_pinyon.png", "02_pinyon.png", "03_pinyon.png", "04_pinyon.png", "05_pinyon.png",
    "06_pinyon.png", "07_pinyon.png", "08_pinyon.png", "09_pinyon.png", "10_pinyon.png",
    "11_pinyon.png", "12_pinyon.png", "13_pinyon.png"
]

var category3_allan:[String] = [
    "01_allan.png", "02_allan.png", "03_allan.png", "04_allan.png", "05_allan.png",
    "06_allan.png", "07_allan.png", "08_allan.png", "09_allan.png", "10_allan.png",
    "11_allan.png", "12_allan.png", "13_allan.png"
]

var category3_shadow:[String] = [
    "01_shadow.png", "02_shadow.png", "03_shadow.png", "04_shadow.png", "05_shadow.png",
    "06_shadow.png", "07_shadow.png", "08_shadow.png", "09_shadow.png", "10_shadow.png",
    "11_shadow.png", "12_shadow.png", "13_shadow.png"
]

var category4_myeongjo:[String] = [
    "c4_01_mj.png", "c4_02_mj.png", "c4_03_mj.png", "c4_04_mj.png", "c4_05_mj.png",
    "c4_06_mj.png", "c4_07_mj.png", "c4_08_mj.png", "c4_09_mj.png", "c4_10_mj.png",
    "c4_11_mj.png", "c4_12_mj.png", "c4_13_mj.png", "c4_14_mj.png", "c4_15_mj.png",
    "c4_16_mj.png", "c4_17_mj.png", "c4_18_mj.png", "c4_19_mj.png", "c4_20_mj.png"
]
