//
//  TextFieldWithLabel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol TextFieldWithLabelDelegate: class {
    
    func picker(at textField: UITextField, didSelect value: String)
}

class TextFieldWithLabel: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderBottom: UIView!
    
    var pickerView: UIPickerView?
    
    weak var delegate: TextFieldWithLabelDelegate?
    
    var viewModel: BehaviorRelay<TextFieldWithLabelViewModel> = BehaviorRelay(value: TextFieldWithLabelViewModel())
    var disposeBag: DisposeBag = DisposeBag()
    
    private var pickerVM: TextFieldWithLabelPickerViewModel? {
        get {
            return viewModel.value as? TextFieldWithLabelPickerViewModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeContentView()
    }
    
    func customizeContentView() {
        Bundle.main.loadNibNamed("TextFieldWithLabel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        contentView.backgroundColor = UIColor.secondarySystemBackground
        borderBottom.backgroundColor = UIColor.tertiarySystemBackground
            
        observe()
    }
    
    func update(for mode: TextFieldWithLabelViewModel.Modes) {
        switch mode {
        case .textField: break
        case .textFieldWithPicker:
            let picker = UIPickerView()
            textField.inputView = picker
            
            picker.delegate = self
            picker.dataSource = self
            
            self.pickerView = picker
        }
    }
}

extension TextFieldWithLabel: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerVM = pickerVM else { return 0 }
        return pickerVM.pickerData.value.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pickerVM = pickerVM else { return nil }
        return pickerVM.pickerData.value[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let pickerVM = pickerVM else { return }
        textField.text = ""
        textField.insertText(pickerVM.pickerData.value[row])
        delegate?.picker(at: textField, didSelect: pickerVM.pickerData.value[row])
    }
}

extension TextFieldWithLabel {
    
    func observe() {

        viewModel.subscribe(onNext: { [weak self] vm in
            guard let `self` = self else { return }
            self.update(for: vm.mode)
            
            switch vm.mode {
            case .textField: break
            case .textFieldWithPicker:
                guard let pickerVM = self.pickerVM else { return }
                pickerVM.pickerData.subscribe(onNext: { [weak self] _ in
                    self?.pickerView?.reloadAllComponents()
                    self?.pickerView?.selectRow(pickerVM.pickerSelectedRow, inComponent: 0, animated: true)
                    self?.textField.text = ""
                    self?.textField.insertText(pickerVM.pickerData.value[pickerVM.pickerSelectedRow])
                }).disposed(by: vm.disposeBag)
            }
        }).disposed(by: disposeBag)
    }
}
