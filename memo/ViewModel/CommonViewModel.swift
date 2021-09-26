//
//  CommonViewModel.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/26.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    
    // 앱을 구성하고 있는 모든 Scene은 네비게이션 컨트롤러에 임베드되기때문에 네비게이션 타이틀 필요.
    // UI관련된 subscription을 만들 땐 Observable보단 Driver 사용하는게 명확
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
}
