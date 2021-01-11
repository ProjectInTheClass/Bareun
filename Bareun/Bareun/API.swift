//
//  API.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/05.
//

import Foundation

class MENU {
    static let shared = MENU()
    
    var items:[MenuItem] = [
        MenuItem(name: "나를 깨우는 명언", image: "category1.png"),
        MenuItem(name: "많이 틀리는 맞춤법", image: "category1.png"),
        MenuItem(name: "쓸모있는 영어 문장", image: "category1.png"),
        MenuItem(name: "대학 슬로건", image: "category1.png"),
    ]
    
    func getMenuItems(completion: ([MenuItem]) -> Void) {
        completion(self.items)
    }
}

var category1_myeongjo:[String] = [
    "01_나눔명조.png", "02_나눔명조.png", "03_나눔명조.png", "04_나눔명조.png", "05_나눔명조.png",
    "06_나눔명조.png", "07_나눔명조.png", "08_나눔명조.png", "09_나눔명조.png", "10_나눔명조.png",
    "11_나눔명조.png", "12_나눔명조.png", "13_나눔명조.png", "14_나눔명조.png", "15_나눔명조.png"
]
