//
//  LaneNumericValueChangerViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/2/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

protocol LaneNumericValueChangerProtocol: class {
    
    
}

class LaneNumericValueChangerViewController: UIViewController {

    @IBOutlet weak var valueTextField: UITextField!
    
    var valueTextFieldToolbar: UIToolbar = UIToolbar()
    var viewModel: LaneNumericValueChangerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupValueTextField()
        
        observe()
    }
    
    func setupValueTextField() {
        /// Workaround so system won't throw constraint errors
        valueTextFieldToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 100,
                                                        height: 100))
        valueTextFieldToolbar.barStyle = .default
        valueTextFieldToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressDone))
        ]
        valueTextFieldToolbar.sizeToFit()
        
        valueTextField.inputAccessoryView = valueTextFieldToolbar
    }
    
    @objc func didPressDone() {
        valueTextField.resignFirstResponder()
        
        #warning("Update lane value adding process")
        let value = valueTextField.text
        let newEntry = LaneEntryModel(context: CoreDataService.shared.context)
        newEntry.createdAt = Date.getDateInTimezone()
        newEntry.updatedAt = Date.getDateInTimezone()
        
        let valueEntry = LaneEntryValueModel(context: CoreDataService.shared.context)
        valueEntry.value = value
        valueEntry.createdAt = Date.getDateInTimezone()
        valueEntry.updatedAt = Date.getDateInTimezone()
        
        newEntry.addToValues(valueEntry)
        
        viewModel!.lane.value.addToEntries(newEntry)
        
        CoreDataService.shared.store(object: viewModel!.lane.value)
    }
}

extension LaneNumericValueChangerViewController {
    
    func observe() {
        guard let vm = viewModel else { return }
        
        vm.lane.subscribe(onNext: { [weak self] lane in
            
        }).disposed(by: vm.disposeBag)
    }
}
