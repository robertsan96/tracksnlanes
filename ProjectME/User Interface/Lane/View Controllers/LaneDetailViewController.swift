//
//  LaneDetailViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

protocol LaneDetailViewControllerDelegate: class {
    func didCreateLane(mode: LaneDetailViewModel.Mode, lane: LaneModel)
}

class LaneDetailViewController: UIViewController {
    
    enum TextFields: Int {
        case name
        case descriptionShort
        case descriptionLong
        case unitCategory
        case unit
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var laneNameTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneDetailTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneLongDetailTextViewWithLabel: TextViewWithLabel!
    @IBOutlet weak var laneUnitCategoryTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneUnitTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var viewControllerDescriptionLabel: UILabel!
    
    weak var delegate: LaneDetailViewControllerDelegate?
    var viewModel: LaneDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laneNameTextFieldWithLabel.label.text = "Name"
        laneNameTextFieldWithLabel.textField.placeholder = "Weight Loss Tracker"
        laneNameTextFieldWithLabel.textField.delegate = self
        laneNameTextFieldWithLabel.textField.tag = TextFields.name.rawValue
        laneNameTextFieldWithLabel.textField.becomeFirstResponder()
        
        laneDetailTextFieldWithLabel.label.text = "Detail"
        laneDetailTextFieldWithLabel.textField.placeholder = "I'll log my weight in this lane."
        laneDetailTextFieldWithLabel.textField.delegate = self
        laneDetailTextFieldWithLabel.textField.tag = TextFields.descriptionShort.rawValue
        
        laneLongDetailTextViewWithLabel.label.text = "Long Detail"
        laneLongDetailTextViewWithLabel.textView.text = ""
//        laneLongDetailTextViewWithLabel.textView.delegate = self
        laneLongDetailTextViewWithLabel.textView.tag = TextFields.descriptionLong.rawValue
        
        laneUnitCategoryTextFieldWithLabel.label.text = "Type"
        laneUnitCategoryTextFieldWithLabel
            .viewModel
            .accept(TextFieldWithLabelPickerViewModel(with: viewModel.getUnitCategoryNames()))
        laneUnitCategoryTextFieldWithLabel.textField.tag = TextFields.unitCategory.rawValue
        laneUnitCategoryTextFieldWithLabel.delegate = self

        laneUnitTextFieldWithLabel.label.text = "Unit"
        laneUnitTextFieldWithLabel
            .viewModel
            .accept(TextFieldWithLabelPickerViewModel(with: viewModel.getUnitNames(for: .mass)))
        laneUnitTextFieldWithLabel.textField.tag = TextFields.unit.rawValue
        laneUnitTextFieldWithLabel.delegate = self

        observe()
    }
    
    @IBAction func onBackgroundTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func didPressSave() {
        switch viewModel.mode.value {
        case .create: break
        case .createWithoutSave:
            guard let unit = UnitSystemIdentifier.getUnitSystemIdentifierByDescription(for: laneUnitTextFieldWithLabel.textField.text) else { return }
            let lane = viewModel.buildLane(name: laneNameTextFieldWithLabel.textField.text,
                                           shortDescription: laneDetailTextFieldWithLabel.textField.text,
                                           longDescription: laneLongDetailTextViewWithLabel.textView.text,
                                           unitCategory: unit.getCategory(),
                                           unit: unit)
            dismiss(animated: true) { [weak self] in
                guard let vm = self?.viewModel else { return }
                self?.delegate?.didCreateLane(mode: vm.mode.value, lane: lane)
            }
        case .edit: break
        }
    }
}

extension LaneDetailViewController {
    
    func observe() {
        viewModel.mode.subscribe(onNext: { [weak self] mode in
            guard let `self` = self else { return }
            self.update(to: mode)
            
        }).disposed(by: viewModel.disposeBag)
        
        laneUnitCategoryTextFieldWithLabel
            .textField
            .rx
            .text
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                guard let vm = self?.viewModel else { return }
                guard let category = UnitSystemCategoryIdentifier.getUnitSystemCategoryIdentifier(for: text) else {
                    return
                }
                self?.laneUnitTextFieldWithLabel
                    .viewModel
                    .accept(TextFieldWithLabelPickerViewModel(with: vm.getUnitNames(for: category)))
        }).disposed(by: viewModel.disposeBag)
    }
    
    func update(to mode: LaneDetailViewModel.Mode) {
        switch mode {
        case .create:
            title = "New Lane"
        case .createWithoutSave:
            title = "Add Lane"
            viewControllerDescriptionLabel.text = "This lane will temporary be saved to the track you're building. Keep in mind that if you cancel the track creation process, you'll lose this lane aswell."
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(self.didPressSave))
        case .edit:
            title = viewModel.track.value.name
        }
    }
}

extension LaneDetailViewController: UITextFieldDelegate, TextFieldWithLabelDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == TextFields.name.rawValue {
            laneDetailTextFieldWithLabel.textField.becomeFirstResponder()
        }
        if textField.tag == TextFields.descriptionShort.rawValue {
            laneLongDetailTextViewWithLabel.textView.becomeFirstResponder()
        }
        if textField.tag == TextFields.descriptionLong.rawValue {
            laneUnitCategoryTextFieldWithLabel.textField.becomeFirstResponder()
            scrollView.scrollToBottom(animated: true)
        }
        if textField.tag == TextFields.unitCategory.rawValue {
            laneUnitTextFieldWithLabel.textField.becomeFirstResponder()
            scrollView.scrollToBottom(animated: true)
        }
        return true
    }
    
    func picker(at textfield: UITextField, didSelect value: String) {
        if textfield.tag == TextFields.unitCategory.rawValue {
            laneUnitTextFieldWithLabel.textField.becomeFirstResponder()
        }
        if textfield.tag == TextFields.unit.rawValue {
            view.endEditing(true)
        }
    }
}
