//
//  MemoComposeViewModel.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: CommonViewModel {
    
    // 새로운 메모를 편집할땐 Nil이 들어가있고, 편집할 땐 기존 내용
    private let content:String?;
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        
        // Action 기능 여기서 구현한 이유:
        // 뷰모델에서 직접 액션 구현하면 처리방식이 하나로 고정되지만, 파라미터로 받으면 처리방식을 동적으로 결정가능
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute()
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        //
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
