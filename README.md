<img src= "https://github.com/Little-tale/ShopY/assets/116441522/e4d92cdd-f0be-4bad-bbc0-b23c366827dc" width = "100" height = "100" />

# 📷 ShopY 프로젝트 소개

<picture>
    <img src = "https://github.com/Little-tale/ShopY/assets/116441522/d1df7884-df39-488a-b73f-2c6b5c47c87b">
</picture>

## ShopY app은 Swift UI 기반 mini Shopping APP 입니다.

- ShopY App은 Naver Shopping Rest - ful Api 를 통해 쇼핑을 제공합니다.
- 현재 인기 있는 상품 순위를 볼수 있습니다.
- 상품을 직접 검색하여 찾을수 있습니다. (페이지 네이션 기능)
- 각 상품에 좋아요를 남길수 있습니다.
- 좋아요를 모아서 한번에 볼수 있습니다.
- 네트워크 상태를 실시간으로 감지하여, 사용자에게 네트워크 상태를 알려줍니다.
- 최소 버전 - iOS 15

## 📸 개발기간

> 5/10 ~ 5/30 ( 대략 3주 )

# 📷 사용한 기술들

- SwiftUI / Combine
- MVI / Router / SingleTone /
- Realm ( Swift )
- URLSession / Kingfisher / Codable / SwiftConcurrency
- 다크모드 대응 Asset

# UI

|                                                             메인 화면                                                             |                                                               검색                                                                |                                                             세부 화면                                                             |
| :-------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: |
| <img src= "https://github.com/Little-tale/ShopY/assets/116441522/c19e908b-de4e-4290-9b82-cc6640619a5e" width="190" height="400"/> | <img src= "https://github.com/Little-tale/ShopY/assets/116441522/bd7a9bf3-0320-44a3-9cee-663b6b283c71" width="190" height="400"/> | <img src= "https://github.com/Little-tale/ShopY/assets/116441522/58f69f21-d582-4945-9aa9-5eea290b9300" width="190" height="400"/> |

|                                                             검색 정렬                                                              |                                                              좋아요                                                               |                                                          좋아요 모아보기                                                          |
| :--------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: |
| <img src = "https://github.com/Little-tale/ShopY/assets/116441522/4aa319fb-ebac-40da-b44f-9f06a3b3211c" width="190" height="400"/> | <img src= "https://github.com/Little-tale/ShopY/assets/116441522/49b1769b-a47e-4cd8-a9b9-62d5f7a90f6f" width="190" height="400"/> | <img src= "https://github.com/Little-tale/ShopY/assets/116441522/ab2750dc-8f2a-45c8-a5ec-2d9d65b34f09" width="190" height="400"/> |

|                                                                등록                                                                |                                                         메인 페이지 전환                                                          |
| :--------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: |
| <img src = "https://github.com/Little-tale/ShopY/assets/116441522/88d07bf7-5101-4943-b72e-3f3ac32db7aa" width="190" height="400"/> | <img src= "https://github.com/Little-tale/ShopY/assets/116441522/e15fa76f-5bc4-4471-8ffd-d92fac78304e" width="190" height="400"/> |

# 📷 기술설명

## MVI + Combine

> Swift UI 는 UIKit 과는 다르게 자체적으로 반응형을 지원하고 있으며,
> 양방향의 흐름이 될수 있는 MVVM 보단 사용자의 입력을 시작으로 비즈니스 로직을 거친후,
> View의 상태 반영 하는 단방향 흐름인 MVI 를 통해 프로젝트를 구성하였습니다.

```swift
import Combine

protocol MVIPatternType: ObservableObject {

    associatedtype Intent

    associatedtype StateModel

    var stateModel: StateModel { get }

    func send(_ action: Intent)
}
```
### 회고정리 : Swift UI + MVVM 과연 맞을까? https://velog.io/@little_tail/9ps8g62w
---

## DTO - Entity

> API를 통해 받아오는 데이터와 뷰가 사용할 모델을 분리 하여
> 후에 API 응답값이 바뀌거나, 또는 뷰가 사용할 내용이 바뀔 것을 빠르게 대처하기 위해
> 구성 하였습니다.

```swift
final class ShopItemsRepository {

    private
    let shopMapper = ShopEntityMapper()

    private
    let repository = RealmRepository()

}
////
struct ShopEntityMapper {

    // API 를 통한 모델
    func toEntity(_ dto: ShopItemDTOModel) -> ShopEntityModel?

    // Realm 모델의 대한
    func toEntity(_ likeModel: LikePostModel) -> ShopEntityModel
}

```

### 회고정리 : https://velog.io/@little_tail/DTO

---

## ViewModifier + Button

> Button 과 ViewModifer 를 이용하여 버튼을

```swift
extension View {
    func asButton(action: @escaping () -> Void ) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}

struct ButtonWrapper: ViewModifier {

    let action: () -> Void

    func body(content: Content) -> some View {
        Button(
            action:action,
            label: { content }
        )
    }
}
```

# 📷 프로젝트 중 새롭게 배운 것들

## Swift Concurrency

> WWDC 2021 에 발표한 Swift Concurrency에 대해서 학습하고,
> 이전에는 Completion Handler 를 통해 비동기 함수를 컨트롤 하였으나,
> Swift Concurrency를 활용하여 비동기 코드를 동기 코드처럼 보여질수 있게,
> 코드가 더 가독성 좋을수 있도록 구성 하였습니다.

```swift
import Foundation
import Combine

protocol NetworkManagerType {

    typealias FetchType<T: Decodable> = AnyPublisher<T,NetworkError>

    static func fetchNetwork<T:Decodable>(model: T.Type, router: NaverRouter) -> FetchType<T>

    static func checkReqeust<T: Decodable>(type: T.Type, router: NaverRouter) async throws -> T

    static func checkURLRequest(router: NaverRouter) throws -> URLRequest

    static func checkURLResponse(response: URLResponse) throws

    static func decode<T: Decodable>(data: Data) throws -> T
}

struct NetworkManager: NetworkManagerType { }

extension NetworkManager {

    static func fetchNetwork<T:Decodable>(model: T.Type, router: NaverRouter) -> FetchType<T> {

        Future <T, NetworkError> { promiss in
            Task {
                do {
                    let result = try await checkReqeust(type: model, router: router)
                    promiss(.success(result))
                } catch let error as NetworkError {
                    promiss(.failure(error))
                } catch {
                    promiss(.failure(.unknownError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
```

### 회고정리 : [https://velog.io/@little_tail/SwiftConcurrency 1편](https://velog.io/@little_tail/View-On-Appear-%EB%8A%94-ViewDidAppear%EB%9E%91-%EA%B0%99%EC%9D%84%EA%B9%8C-Swift-UI)

---

## HTML 태그 제거

> Naver 검색 Rest API - ful 를 통해 상품명을 받아오면 <b> (볼드 태그) 가 받아와 지는 이슈가 있었습니다.
> 처음에는 직접 bold 태그를 제거 하였었으나 후에 네이버 API 에서 볼드 태그가 아닌 다른 태그로 결과 값을
> 줄것을 대비하여 `NSAttributedString.DocumentReadingOptionKey` 의 옵션중 HTML 문서 형식으로 설정하여 태그를 제거하였습니다.

```swift
// Before
var rmHTMLBold: String {

     let first = self.replacingOccurrences(of: "<b>", with: "")

     let results = first.replacingOccurrences(of: "</b>", with: "")

     return results

 }
// After
extension String {

    typealias ReadingOption = NSAttributedString.DocumentReadingOptionKey
    typealias DocumentType = NSAttributedString.DocumentType

    var rmHTMLTag: String {
        guard let data = self.data(using: .utf8) else { return self }

        let options: [ReadingOption : Any] = [
            .documentType: DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attrubuted = try NSAttributedString(
                data: data,
                options: options,
                documentAttributes: nil)

            return attrubuted.string
        } catch {
            return self
        }
    }

}

```

---

## propertyWrapper

> 간단한 데이터를 저장하기 유용한 UserDefaults 를 구현하기 위한 코드중 중복되는 코드들이 많아
> Swift 5.1 에서 추가된 propertyWrapper 를 학습하고, UserDefaults 에 적용해 보았습니다.

```swift
@propertyWrapper
struct UserDefaultWrapper<T> {
    let key: String
    let placeValue: T

    let ofCase: UserDefaultCase

    private let US = UserDefaults.standard

    var wrappedValue: T

}

// UserDefaults Manager
@UserDefaultCodableWrapper(key: Key.productId.rawValue, placeValue: [])
    static var productId: Set<String>

@UserDefaultWrapper(key: Key.searchHistory.rawValue, placeValue: [], ofCase: Key.searchHistory.caseType)
    static var searchHistory: Array<String>
```

---

## Realm + **Xcode 15 + iOS 17 이하 버전 이슈**

> iOS 17 버전에서는 Realm 이 정상적으로 작동 하였으나, iOS 16 이하 버전으로 실행시
> ” Thread 1: EXC_BAD_ACCESS (code=1, address=0x0) “ 라는 메시지 와 함께
> Realm 이 동작하지 않던 이슈가 있었습니다. 해당하는 문제를 해결하기 위해 검색과,
> GitHub Issue Community을 활용하였으며, 사용해야 하는 렘의 모델을 직접 명시하는 방법으로
> 문제를 해결하였습니다.

```swift
private var realm: Realm?

    static func registerRealmClass() {
        let classes: [Object.Type] = [
            LikePostModel.self,
            ProfileRealmModel.self
        ]
        let config = Realm.Configuration(objectTypes: classes)
        Realm.Configuration.defaultConfiguration = config
    }

    init() {
        if #available(iOS 17, *) {
            // None
        } else {
            RealmRepository.registerRealmClass()
        }
        do {
            let realms = try Realm()
            realm = realms
            print(realm?.configuration.fileURL ?? "Realm MISS")
        } catch {
            print("Realm Init 문제 ")
            realm = nil
        }
    }
```

### Invalid frame dimension (negative or non-finite)

> Swift UI 를 처음으로 도입하면서 겪은 문제로,
> .Infinity ( 무한대 ) 를 마치 Spacer() 와 같은 개념이라고 착각을 하고
> 사용하였었는데 해당 오류를 겪고 Infinity 와 레이아웃 시스템에 대해서 학습하였습니다.
> 문제의 해결 방법은 아래와 같이 간단 하였으나 왜 음수라고 하였는지
> 원인을 알아야 한다고 생각 했었습니다.

### 회고정리 : Swift Layout System https://velog.io/@little_tail/SwiftUILayoutSysytem

```swift
// Before
.frame(width: .infinity, height: 46)
// After
.frame(maxWidth: .infinity)
.frame(height: 46)
```
