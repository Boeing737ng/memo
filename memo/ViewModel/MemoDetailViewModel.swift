//
//  MemoDetailViewModel.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action

// 이전 Scene에서 전달된 메모 저장
class MemoDetailViewModel: CommonViewModel {
    let memo: Memo
    
    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    // 메모 편집 후에 다시 보기화면으로 오면 편집화면이 반영되어야함. 새로운 문자열배열을 방출해야하는데, 일반 옵저버블로 선언하면 이게 불가능해서 BehaviorSubject 사용
    var contents: BehaviorSubject<[String]>
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.memo = memo
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    lazy var popAction = CocoaAction {[unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            // .map {_ in} -> 옵저버블 void 타입이 리턴되야하는데 update 메소드는 편집된 메모에 대한 Observable을 방출하기때문에 map 사용 (방출타입 변경)
            self.storage.update(memo: memo, content: input)
                .subscribe(onNext: {updated in
                    self.contents.onNext([
                        updated.content,
                        self.formatter.string(from: updated.insertDate)
                    ])
                })
                .disposed(by: self.rx.disposeBag)
            
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "메모 편집", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{_ in}
        }
    }
    
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
        }
    }
}
