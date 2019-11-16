//
//  TextFieldWithLabelPickerViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextFieldWithLabelPickerViewModel: TextFieldWithLabelViewModel {
    
    var pickerData: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var pickerSelectedRow: Int = 0
    
    init(with data: [String], selectDataAt row: Int = 0) {
        super.init(with: .textFieldWithPicker)
        pickerData.accept(data)
        pickerSelectedRow = row
    }
}
