//
//  TransitionModel.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
