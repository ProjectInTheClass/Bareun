//
//  API.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/05.
//

import Foundation

final class Shared {
    static let shared = Shared()
    var CurTextImage : String?
    var FontName : String! = "나눔명조체"
    var licenseIndex : Int = 0
}

class MENU {
    static let shared = MENU()
    
    
    var items:[MenuItem] = [
        MenuItem(name: "나를 깨우는 명언", image: "category.png"),
        MenuItem(name: "많이 틀리는 맞춤법", image: "category.png"),
        MenuItem(name: "쓸모있는 영어 문장", image: "category.png"),
        MenuItem(name: "대학 슬로건", image: "category.png"),
    ]
    
    var fontItems:[FontInfo] = [
        FontInfo(fontName: "나눔명조체", fileName: "NanumMyeongjo"),
        FontInfo(fontName: "바른히피체", fileName: "나눔손글씨 바른히피"),
        FontInfo(fontName: "나눔바른펜", fileName: "NanumBarunpenR"),
        FontInfo(fontName: "느릿느릿체", fileName: "나눔손글씨 느릿느릿체"),
        FontInfo(fontName: "유니 띵땅띵땅", fileName: "나눔손글씨 유니 띵땅띵땅"),
        FontInfo(fontName: "Pinyon Script", fileName: "PinyonScript"),
        FontInfo(fontName: "Allan", fileName: "Allan-Regular"),
        FontInfo(fontName: "Shadows Into Light Two", fileName: "ShadowsIntoLightTwo-Regular"),
        FontInfo(fontName: "Kalam", fileName: "Kalam-Light"),
        FontInfo(fontName: "Petit Formal Script", fileName: "PetitFormalScript-Regular"),
        FontInfo(fontName: "Sacramento", fileName: "Sacramento-Regular")
    ]
    
    
    func getMenuItems(completion: ([MenuItem]) -> Void) {
        completion(self.items)
    }
    
    func getFontItems(completion: ([FontInfo]) -> Void) {
        completion(self.fontItems)
    }
}

// category1
var category1_myeongjo:[String] = [
    "c1_01_mj.png", "c1_02_mj.png", "c1_03_mj.png", "c1_04_mj.png", "c1_05_mj.png",
    "c1_06_mj.png", "c1_07_mj.png", "c1_08_mj.png", "c1_09_mj.png", "c1_10_mj.png",
    "c1_11_mj.png", "c1_12_mj.png", "c1_13_mj.png", "c1_14_mj.png", "c1_15_mj.png"
]
var category1_bh:[String] = [
    "c1_01_bh.png", "c1_02_bh.png", "c1_03_bh.png", "c1_04_bh.png", "c1_05_bh.png",
    "c1_06_bh.png", "c1_07_bh.png", "c1_08_bh.png", "c1_09_bh.png", "c1_10_bh.png",
    "c1_11_bh.png", "c1_12_bh.png", "c1_13_bh.png", "c1_14_bh.png", "c1_15_bh.png"
]
var category1_bp:[String] = [
    "c1_01_bp.png", "c1_02_bp.png", "c1_03_bp.png", "c1_04_bp.png", "c1_05_bp.png",
    "c1_06_bp.png", "c1_07_bp.png", "c1_08_bp.png", "c1_09_bp.png", "c1_10_bp.png",
    "c1_11_bp.png", "c1_12_bp.png", "c1_13_bp.png", "c1_14_bp.png", "c1_15_bp.png"
]
var category1_nl:[String] = [
    "c1_01_nl.png", "c1_02_nl.png", "c1_03_nl.png", "c1_04_nl.png", "c1_05_nl.png",
    "c1_06_nl.png", "c1_07_nl.png", "c1_08_nl.png", "c1_09_nl.png", "c1_10_nl.png",
    "c1_11_nl.png", "c1_12_nl.png", "c1_13_nl.png", "c1_14_nl.png", "c1_15_nl.png"
]
var category1_dd:[String] = [
    "c1_01_dd.png", "c1_02_dd.png", "c1_03_dd.png", "c1_04_dd.png", "c1_05_dd.png",
    "c1_06_dd.png", "c1_07_dd.png", "c1_08_dd.png", "c1_09_dd.png", "c1_10_dd.png",
    "c1_11_dd.png", "c1_12_dd.png", "c1_13_dd.png", "c1_14_dd.png", "c1_15_dd.png"
]

// category2
var category2_myeongjo:[String] = [
    "c2_01_mj.png", "c2_02_mj.png", "c2_03_mj.png", "c2_04_mj.png", "c2_05_mj.png",
    "c2_06_mj.png", "c2_07_mj.png", "c2_08_mj.png", "c2_09_mj.png"
]
var category2_bh:[String] = [
    "c2_01_bh.png", "c2_02_bh.png", "c2_03_bh.png", "c2_04_bh.png", "c2_05_bh.png",
    "c2_06_bh.png", "c2_07_bh.png", "c2_08_bh.png", "c2_09_bh.png"
]
var category2_bp:[String] = [
    "c2_01_bp.png", "c2_02_bp.png", "c2_03_bp.png", "c2_04_bp.png", "c2_05_bp.png",
    "c2_06_bp.png", "c2_07_bp.png", "c2_08_bp.png", "c2_09_bp.png"
]
var category2_nl:[String] = [
    "c2_01_nl.png", "c2_02_nl.png", "c2_03_nl.png", "c2_04_nl.png", "c2_05_nl.png",
    "c2_06_nl.png", "c2_07_nl.png", "c2_08_nl.png", "c2_09_nl.png"
]
var category2_dd:[String] = [
    "c2_01_dd.png", "c2_02_dd.png", "c2_03_dd.png", "c2_04_dd.png", "c2_05_dd.png",
    "c2_06_dd.png", "c2_07_dd.png", "c2_08_dd.png", "c2_09_dd.png"
]

// category3
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
var category3_kalam:[String] = [
    "01_kalam.png", "02_kalam.png", "03_kalam.png", "04_kalam.png", "05_kalam.png",
    "06_kalam.png", "07_kalam.png", "08_kalam.png", "09_kalam.png", "10_kalam.png",
    "11_kalam.png", "12_kalam.png", "13_kalam.png"
]
var category3_sacra:[String] = [
    "01_sacra.png", "02_sacra.png", "03_sacra.png", "04_sacra.png", "05_sacra.png",
    "06_sacra.png", "07_sacra.png", "08_sacra.png", "09_sacra.png", "10_sacra.png",
    "11_sacra.png", "12_sacra.png", "13_sacra.png"
]
var category3_petit:[String] = [
    "01_petit.png", "02_petit.png", "03_petit.png", "04_petit.png", "05_petit.png",
    "06_petit.png", "07_petit.png", "08_petit.png", "09_petit.png", "10_petit.png",
    "11_petit.png", "12_petit.png", "13_petit.png"
]

// category4
var category4_myeongjo:[String] = [
    "c4_01_mj.png", "c4_02_mj.png", "c4_03_mj.png", "c4_04_mj.png", "c4_05_mj.png",
    "c4_06_mj.png", "c4_07_mj.png", "c4_08_mj.png", "c4_09_mj.png", "c4_10_mj.png",
    "c4_11_mj.png", "c4_12_mj.png", "c4_13_mj.png", "c4_14_mj.png", "c4_15_mj.png",
    "c4_16_mj.png", "c4_17_mj.png", "c4_18_mj.png", "c4_19_mj.png", "c4_20_mj.png"
]
var category4_bh:[String] = [
    "c4_01_bh.png", "c4_02_bh.png", "c4_03_bh.png", "c4_04_bh.png", "c4_05_bh.png",
    "c4_06_bh.png", "c4_07_bh.png", "c4_08_bh.png", "c4_09_bh.png", "c4_10_bh.png",
    "c4_11_bh.png", "c4_12_bh.png", "c4_13_bh.png", "c4_14_bh.png", "c4_15_bh.png",
    "c4_16_bh.png", "c4_17_bh.png", "c4_18_bh.png", "c4_19_bh.png", "c4_20_bh.png"
]
var category4_bp:[String] = [
    "c4_01_bp.png", "c4_02_bp.png", "c4_03_bp.png", "c4_04_bp.png", "c4_05_bp.png",
    "c4_06_bp.png", "c4_07_bp.png", "c4_08_bp.png", "c4_09_bp.png", "c4_10_bp.png",
    "c4_11_bp.png", "c4_12_bp.png", "c4_13_bp.png", "c4_14_bp.png", "c4_15_bp.png",
    "c4_16_bp.png", "c4_17_bp.png", "c4_18_bp.png", "c4_19_bp.png", "c4_20_bp.png"
]
var category4_nl:[String] = [
    "c4_01_nl.png", "c4_02_nl.png", "c4_03_nl.png", "c4_04_nl.png", "c4_05_nl.png",
    "c4_06_nl.png", "c4_07_nl.png", "c4_08_nl.png", "c4_09_nl.png", "c4_10_nl.png",
    "c4_11_nl.png", "c4_12_nl.png", "c4_13_nl.png", "c4_14_nl.png", "c4_15_nl.png",
    "c4_16_nl.png", "c4_17_nl.png", "c4_18_nl.png", "c4_19_nl.png", "c4_20_nl.png"
]
var category4_dd:[String] = [
    "c4_01_dd.png", "c4_02_dd.png", "c4_03_dd.png", "c4_04_dd.png", "c4_05_dd.png",
    "c4_06_dd.png", "c4_07_dd.png", "c4_08_dd.png", "c4_09_dd.png", "c4_10_dd.png",
    "c4_11_dd.png", "c4_12_dd.png", "c4_13_dd.png", "c4_14_dd.png", "c4_15_dd.png",
    "c4_16_dd.png", "c4_17_dd.png", "c4_18_dd.png", "c4_19_dd.png", "c4_20_dd.png"
]

var EnglishMeaning:[String] = [
    "아무나 안 만나려다 아무도 못 만나는 중입니다.", "날 곤란한 상황에서 벗어나게 해줘서 고마워.", "난 이 순간을 영원히 못 잊을 거야.",
    "우리랑 또 한잔할래?", "조용히 좀 해주시겠어요?", "엘레베이터가 고장 났어요. 계단을 이용하셔야 해요.",
    "넌 사랑받기 위해 태어난 사람이야.", "힘든 상황이 올 땐 날 믿고 의지해도 좋아", "투덜대지 말고 해야 할 일이나 끝내.",
    "너와 함께한 모든 날이 즐거웠어.", "진정한 사랑은 사람들의 최선의 모습을 끌어내 주지", "너무 바빠서 손이 열 개라도 모자라.",
    "강하게 나가자. 물러서지 말자"
]
