//
//  TextFieldWithLabelPickerViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextFieldWithLabelPickerViewModel: TextFieldWithLabelViewModel {
    
    var pickerData: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    init(with data: [String]) {
        super.init(with: .textFieldWithPicker)
        pickerData.accept(data)
    }
}
