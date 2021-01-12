import UIKit

enum IntResult {
    case success(Int)
    case failure(String)
}

func processIntResult(result : IntResult) {
    switch result {
    case .success(let number):
        print(number)
    case .failure(let error):
        print(error)
    }
}

processIntResult(result: .success(100))
processIntResult(result: .failure("데이터 Fetching 실패"))

enum Direction {
    case north(Int)
    case south(Int)
    case east(Int)
    case west(Int)
}

func tellMeDirection(dir: Direction) {
    switch dir {
    case .north(let distance):
        print("북쪽으로 \(distance)만큼 갑니다.")
    case .south(let distance):
        print("남쪽으로 \(distance)만큼 갑니다.")
    case .east(let distance):
        print("동쪽으로 \(distance)만큼 갑니다.")
    case .west(let distance):
        print("서쪽으로 \(distance)만큼 갑니다.")
    }
}

let toTheEast = Direction.north(5)

tellMeDirection(dir: toTheEast)




//enum에 프로토콜 추가
enum Grade: CaseIterable {
    case first
    case second
    case third
    case forth
    case fifth
}


for grade in Grade.allCases {
    print(grade)
}
