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
        MenuItem(name: "나를 위한 바른 명언", image: "category.png"),
        MenuItem(name: "많이 틀리는 맞춤법", image: "category.png"),
        MenuItem(name: "알아두면 좋은 영어 문장", image: "category.png"),
        MenuItem(name: "대학 슬로건", image: "category.png"),
    ]
    
    var fontItems:[FontInfo] = [
        FontInfo(fontName: "나눔명조체", fileName: "NanumMyeongjo"),
        FontInfo(fontName: "바른히피체", fileName: "나눔손글씨 바른히피"),
        FontInfo(fontName: "나눔바른펜(한/영)", fileName: "NanumBarunpenR"),
        FontInfo(fontName: "느릿느릿체", fileName: "나눔손글씨 느릿느릿체"),
        FontInfo(fontName: "유니 띵땅띵땅", fileName: "나눔손글씨 유니 띵땅띵땅"),
        FontInfo(fontName: "카페24 고운밤", fileName: "Cafe24Oneprettynight"),
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
    "c1_11_mj.png", "c1_12_mj.png", "c1_13_mj.png", "c1_14_mj.png", "c1_15_mj.png",
    "c1_16_mj.png", "c1_17_mj.png", "c1_18_mj.png", "c1_19_mj.png", "c1_20_mj.png"
]
var category1_bh:[String] = [
    "c1_01_bh.png", "c1_02_bh.png", "c1_03_bh.png", "c1_04_bh.png", "c1_05_bh.png",
    "c1_06_bh.png", "c1_07_bh.png", "c1_08_bh.png", "c1_09_bh.png", "c1_10_bh.png",
    "c1_11_bh.png", "c1_12_bh.png", "c1_13_bh.png", "c1_14_bh.png", "c1_15_bh.png",
    "c1_16_bh.png", "c1_17_bh.png", "c1_18_bh.png", "c1_19_bh.png", "c1_20_bh.png"
]
var category1_bp:[String] = [
    "c1_01_bp.png", "c1_02_bp.png", "c1_03_bp.png", "c1_04_bp.png", "c1_05_bp.png",
    "c1_06_bp.png", "c1_07_bp.png", "c1_08_bp.png", "c1_09_bp.png", "c1_10_bp.png",
    "c1_11_bp.png", "c1_12_bp.png", "c1_13_bp.png", "c1_14_bp.png", "c1_15_bp.png",
    "c1_16_bp.png", "c1_17_bp.png", "c1_18_bp.png", "c1_19_bp.png", "c1_20_bp.png"
]
var category1_nl:[String] = [
    "c1_01_nl.png", "c1_02_nl.png", "c1_03_nl.png", "c1_04_nl.png", "c1_05_nl.png",
    "c1_06_nl.png", "c1_07_nl.png", "c1_08_nl.png", "c1_09_nl.png", "c1_10_nl.png",
    "c1_11_nl.png", "c1_12_nl.png", "c1_13_nl.png", "c1_14_nl.png", "c1_15_nl.png",
    "c1_16_nl.png", "c1_17_nl.png", "c1_18_nl.png", "c1_19_nl.png", "c1_20_nl.png"
]
var category1_dd:[String] = [
    "c1_01_dd.png", "c1_02_dd.png", "c1_03_dd.png", "c1_04_dd.png", "c1_05_dd.png",
    "c1_06_dd.png", "c1_07_dd.png", "c1_08_dd.png", "c1_09_dd.png", "c1_10_dd.png",
    "c1_11_dd.png", "c1_12_dd.png", "c1_13_dd.png", "c1_14_dd.png", "c1_15_dd.png",
    "c1_16_dd.png", "c1_17_dd.png", "c1_18_dd.png", "c1_19_dd.png", "c1_20_dd.png"
]
var category1_gb:[String] = [
    "c1_01_gb.png", "c1_02_gb.png", "c1_03_gb.png", "c1_04_gb.png", "c1_05_gb.png",
    "c1_06_gb.png", "c1_07_gb.png", "c1_08_gb.png", "c1_09_gb.png", "c1_10_gb.png",
    "c1_11_gb.png", "c1_12_gb.png", "c1_13_gb.png", "c1_14_gb.png", "c1_15_gb.png",
    "c1_16_gb.png", "c1_17_gb.png", "c1_18_gb.png", "c1_19_gb.png", "c1_20_gb.png"
]

// category2
var category2_myeongjo:[String] = [
    "c2_01_mj.png", "c2_02_mj.png", "c2_03_mj.png", "c2_04_mj.png", "c2_05_mj.png",
    "c2_06_mj.png", "c2_07_mj.png", "c2_08_mj.png", "c2_09_mj.png", "c2_10_mj.png",
    "c2_11_mj.png", "c2_12_mj.png", "c2_13_mj.png", "c2_14_mj.png", "c2_15_mj.png"
]
var category2_bh:[String] = [
    "c2_01_bh.png", "c2_02_bh.png", "c2_03_bh.png", "c2_04_bh.png", "c2_05_bh.png",
    "c2_06_bh.png", "c2_07_bh.png", "c2_08_bh.png", "c2_09_bh.png", "c2_10_bh.png",
    "c2_11_bh.png", "c2_12_bh.png", "c2_13_bh.png", "c2_14_bh.png", "c2_15_bh.png"
]
var category2_bp:[String] = [
    "c2_01_bp.png", "c2_02_bp.png", "c2_03_bp.png", "c2_04_bp.png", "c2_05_bp.png",
    "c2_06_bp.png", "c2_07_bp.png", "c2_08_bp.png", "c2_09_bp.png", "c2_10_bp.png",
    "c2_11_bp.png", "c2_12_bp.png", "c2_13_bp.png", "c2_14_bp.png", "c2_15_bp.png"
]
var category2_nl:[String] = [
    "c2_01_nl.png", "c2_02_nl.png", "c2_03_nl.png", "c2_04_nl.png", "c2_05_nl.png",
    "c2_06_nl.png", "c2_07_nl.png", "c2_08_nl.png", "c2_09_nl.png", "c2_10_nl.png",
    "c2_11_nl.png", "c2_12_nl.png", "c2_13_nl.png", "c2_14_nl.png", "c2_15_nl.png"
]
var category2_dd:[String] = [
    "c2_01_dd.png", "c2_02_dd.png", "c2_03_dd.png", "c2_04_dd.png", "c2_05_dd.png",
    "c2_06_dd.png", "c2_07_dd.png", "c2_08_dd.png", "c2_09_dd.png", "c2_10_dd.png",
    "c2_11_dd.png", "c2_12_dd.png", "c2_13_dd.png", "c2_14_dd.png", "c2_15_dd.png"
]
var category2_gb:[String] = [
    "c2_01_gb.png", "c2_02_gb.png", "c2_03_gb.png", "c2_04_gb.png", "c2_05_gb.png",
    "c2_06_gb.png", "c2_07_gb.png", "c2_08_gb.png", "c2_09_gb.png", "c2_10_gb.png",
    "c2_11_gb.png", "c2_12_gb.png", "c2_13_gb.png", "c2_14_gb.png", "c2_15_gb.png"
]

// category3
var category3_bp:[String] = [
    "01_bp.png", "02_bp.png", "03_bp.png", "04_bp.png", "05_bp.png",
    "06_bp.png", "07_bp.png", "08_bp.png", "09_bp.png", "10_bp.png",
    "11_bp.png", "12_bp.png", "13_bp.png"
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
var category4_gb:[String] = [
    "c4_01_gb.png", "c4_02_gb.png", "c4_03_gb.png", "c4_04_gb.png", "c4_05_gb.png",
    "c4_06_gb.png", "c4_07_gb.png", "c4_08_gb.png", "c4_09_gb.png", "c4_10_gb.png",
    "c4_11_gb.png", "c4_12_gb.png", "c4_13_gb.png", "c4_14_gb.png", "c4_15_gb.png",
    "c4_16_gb.png", "c4_17_gb.png", "c4_18_gb.png", "c4_19_gb.png", "c4_20_gb.png"
]

// 영어 뜻

var EnglishMeaning:[String] = [
    "아무나 안 만나려다 아무도 못 만나는 중입니다.", "날 곤란한 상황에서 벗어나게 해줘서 고마워.", "난 이 순간을 영원히 못 잊을 거야.",
    "우리랑 2차가서 또 한잔할래?", "조용히 좀 해주시겠어요?", "엘레베이터가 고장 났어요. 계단을 이용하셔야 해요.",
    "넌 사랑받기 위해 태어난 사람이야.", "힘든 상황이 올 땐 날 믿고 의지해도 좋아", "투덜대지 말고 해야 할 일이나 끝내.",
    "너와 함께한 모든 날이 즐거웠어.", "진정한 사랑은 사람들의 최선의 모습을 끌어내 주지", "너무 바빠서 손이 열 개라도 모자라.",
    "강하게 나가자. 물러서지 말자."
]


// 평가 문구
var score1:[String] = [
    "…쓰신거죠?", "다 쓰신거 맞나요?", "다음 문장과 착각하신건 아니죠?", "차근차근 써보세요!",
    "자, 다시 시작해봅시다!", "끝까지 써보세요!"
]
var score2:[String] = [
    "잘 그리셨어요!", "반 고흐를 꿈꾸시는 분이군요!", "좀 더 천천히 써주세요~!", "마음을 가라앉히고 차분히 써보세요.", "노력하세요", "쓰셨네요!", "할 수 있어요!", "천천히 따라 써볼까요?", "독창적인 폰트인걸요?"
]
var score3:[String] = [
    "조금만 더 하면 되겠어요!", "조금만 더 신경써볼까요?", "반이 시작이라는 말 들어보셨죠?", "나쁘지 않아요",
    "바른과 함께 더 연습해보아요!"
]
var score4:[String] = [
    "당신도 5점 받을 수 있어요!", "정상에 서는 그날까지..", "꽤 하시네요", "잘 쓰셨어요!", "5점이 코앞이에요!"
]
var score5:[String] = [
    "평소에 글씨 잘 쓴다고 칭찬 많이 들으시죠?", "와! 한석봉의 환생인가요?", "대박, 세상에", "폰트 내셔도 되겠어요!", "혹시 프린터기 아니세요?", "바른 지우셔도 될거같은데..", "와! 한석봉 선배님! 바른을 뒤집어놓으셨다!"
]

// 공유문구
var sharedText:[String] = [
    "이 시대 최고의 글씨 어플,\n바른으로 여러분을 초대합니다 :)", "바른 글씨, 바른 마음 가짐으로 글씨를 쓰면 기분이 조크든요", "[Web발신]\n바른 글씨 ok,\n악필은 not ok", "이래도 너가 나보다 글씨를 잘쓴다고?"
]
