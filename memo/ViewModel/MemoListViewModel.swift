//
//  MemoListViewModel.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            // .map {_ in} -> 옵저버블 void 타입이 리턴되야하는데 update 메소드는 편집된 메모에 대한 Observable을 방출하기때문에 map 사용 (방출타입 변경)
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 메모", content: "d", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    
                    //transition은 completable 방출하기때문에, asObservable().map{_ in} 써서 void로 캐스트
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                }
            
        }
    }
}
