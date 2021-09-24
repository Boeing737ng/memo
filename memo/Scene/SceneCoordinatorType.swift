//
//  SceneCoordinatorType.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene:Scene, using style:TransitionStyle, animated: Bool) -> Completable

    @discardableResult
    func close(animated: Bool) -> Completable
}
