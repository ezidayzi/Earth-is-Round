## 지구는 둥그니까

### ⛄ 눈사람과 함께하는 걸음 시각화 서비스

아이폰, 애플워치, 위젯을 통해 걷기 활동을 즐겁게 만들어줘요!

---

### 기능 소개

#### 만보기 기능
- 애플 워치 및 아이폰에서 걸음 수를 즉시 확인 가능합니다.
- 굴러가는 눈동이를 통해 시각적으로 확인할 수 있습니다. <br>

![image](https://github.com/Earth-Is-Round/Client-iOS/assets/77208067/9f00a0f6-c2cf-45d1-9fc7-abdc69e86e01)

#### 눈사람 보기

- 일주일 간의 걸음수에 따라 서로 다른 모습의 눈사람이 등장합니다.
- 걸음 수에 따라 다양한 아이템을 얻을 수 있습니다.

![image](https://github.com/Earth-Is-Round/Client-iOS/assets/77208067/2f1bc02f-319d-4867-bb6d-52c3042fe292)


---

### 🛠 개발 환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.8-orange)]() [![swiftUI](https://img.shields.io/badge/swift-5.8-orange)]() [![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]() [![tuist](https://img.shields.io/badge/Tuist-3.16.0-purple)]() [![TCA](https://img.shields.io/badge/TCA-0.5.0-yellow)]() [![Lottie](https://img.shields.io/badge/Lottie-4.1.3-orange)]()

<br>

### 📦 Modules

![graph](https://github.com/Earth-Is-Round/Client-iOS/assets/77208067/b868711e-9789-411d-8def-a5e661e5d332)

### 🏡 Skills

#### Tuist
- Tuist를 이용하여 다양한 모듈을 Mono Repo에서 구현합니다. 모듈 및 개발 환경을 편리하게 관리할 수 있습니다.

#### Modular Architecture
- 모듈을 분리하여 응집도 높고 결합도가 낮은 코드를 작성할 수 있는 환경을 구현합니다.

#### SwiftUI
- SwiftUI를 이용하여 UI를 구현합니다.

#### Composable Architecture
- TCA를 이용하여 요소를 Composable하게 작성합니다.

#### HealthKit & CoreMotion
- HealthKit을 통해 장기간의 걸음 정보를 가져옵니다.
- CoreMotion을 통해 실시간 걸음 수 및 속도를 가져옵니다.

#### Swift Concurrency
- Swift Concurrency를 이용하여 최적화된 비동기 처리를 구현합니다.

#### Testability
- 전반적으로 Testable한 코드를 지양합니다.
- 이러한 이점을 살려, 복잡한 로직의 경우 Unit Test를 작성하고 신뢰성 및 유지보수성을 확보할 예정입니다.
