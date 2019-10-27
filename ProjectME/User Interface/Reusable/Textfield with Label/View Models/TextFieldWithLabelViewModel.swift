//
//  TextFieldWithLabelViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextFieldWithLabelViewModel {
    
    enum Modes {
        case textField
        case textFieldWithPicker
    }
    
    var mode: Modes = .textField
    var disposeBag = DisposeBag()
   
    init() { }
    
    init(with mode: Modes) {
        self.mode = mode
    }
}
