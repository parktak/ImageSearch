# ImageSearch
ImageSearch

## 앱 정보
Min SDK : 17.0
Swift Version : 6.0
Architecture : MVVM + Clean Architecture
Framework : Combine


## 설계의도
- Presentaion Layer, Domain Layer, Data Layer 를  책임을 분리하여 단일 책임, 확장성, 테스트 용이성을 확보
- DiContainer 를 사용하여 의존성을 한곳에서 관리하며, 필요 시 데이터를 공유 할 수 있도록 DIContainer 의 멤버변수로 선언 (CachceManger 등)


## 최적화
- 동시적인 이미지 URL 로드를 위해 각 셀마다 ImageLoader 를 생성하고, 같은 캐시에 접근 하기 위해 ImageLoader 생성 시 DiContainer 에서 CacheManager 를 주입
- ImageListView 의 경우 페이징처리로 구현하였고, 데이터 로드 속도가 느리지는 않아 preload 는 고려하지않았음.
- 이미지 로드 시 CacheManager 를 사용하여 메모리에 캐시된 데이터를 우선적으로 가져오도록 설계하여 네트워크 접근을 최소화
- 많은 이미지 로드 시 Memory 부하를 위해 Cache Size에 제한을 100으로 설정


## 발생할 수 있는 문제점
- Cache의 크기가 100이지만, 대용량 이미지를 로드 시 메모리에 부하가 걸릴 수 있음. 이를 위해 캐시 허용 크기를 줄이거나 thumbnail 을 로드하는 방식으로 변경해야 할 수도 있을 것 같아보임.
 

