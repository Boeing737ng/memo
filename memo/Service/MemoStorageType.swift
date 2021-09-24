//
//  MemoStorageType.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift

//기본적인 CRUD 처리 메소드 선언
protocol MemoStorageType {
    //discardableResult -> 리턴결과가 필요없을 때 (리턴 사용안한다는 warning 제거)
    @discardableResult
    //리턴타입:Observable -> 구독자가 작업결과를 원하는 방식으로 처리
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
    
    
}
