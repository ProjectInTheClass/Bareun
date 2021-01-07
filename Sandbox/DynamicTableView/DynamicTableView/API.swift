
import Foundation

class API {
    static let shared = API()
    
    private var items:[MenuItem] = [
        MenuItem(name: "카페 아메리카노", price: 3000),
        MenuItem(name: "카페 라떼", price: 3500),
        MenuItem(name: "캬라멜 마키아또", price: 4000),
        MenuItem(name: "오늘의 커피", price: 3000),
        MenuItem(name: "초코 라떼", price: 3500),
        MenuItem(name: "바닐라 라떼", price: 3800)
    ]
    
    func getMenuItems(completion: ([MenuItem]) -> Void) {
        // 서버 사용하는 코드
        // Firebase
        // DB 접근
        completion(self.items)
    }
    
    func hello() {
        print("hello")
    }
}
