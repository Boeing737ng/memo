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
}
