//
//  MemoryStorage.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift

// 메모리에 메모를 저장하는 클래스
class MemoryStorage: MemoStorageType {
    
    //Observable을 통해 외부로 공개
    private var list = [
        Memo(content: "Hello RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Hello RxSwift22", insertDate: Date().addingTimeInterval(-20))
    ]
    
    // 초기에 dummy 데이터를 표시해야서 BehaviorSubject 사용 (value: << default 값)
    // BehaviourSubject -> subscribe한 시점부터 발생하는 값 가져옴 
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content:  content)
        list.insert(memo, at: 0)

        store.onNext(list)
        return Observable.just(memo)
    }
    
    //class 외부에선 memoList() 호출해서 메모리스트에 접근
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo}) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo}) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    
}
