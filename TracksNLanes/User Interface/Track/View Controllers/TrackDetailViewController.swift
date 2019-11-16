//
//  TrackDetailViewController.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxSwift

class TrackDetailViewController: UIViewController {

    @IBOutlet weak var trackNameTextFieldWithLabel: TextFieldWithLabel!
    
    var viewModel: TrackDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        trackNameTextFieldWithLabel.label.text = "Name"
        trackNameTextFieldWithLabel.textField.placeholder = "Weight Loss Process"
        trackNameTextFieldWithLabel.textField.delegate = self
        trackNameTextFieldWithLabel.textField.becomeFirstResponder()
        observeChanges()
    }

    @objc func onNext() {
        let selectPredefinedLanesTVC = try! Storyboard.getVC(with: "SelectPredefinedLanesTableViewController",
                                                             in: .lane) as! SelectLanesTableViewController
        let selectPredefinedLanesTVM = SelectLanesTableViewModel()
        selectPredefinedLanesTVC.viewModel = selectPredefinedLanesTVM
        
        navigationController?.pushViewController(selectPredefinedLanesTVC, animated: true)
    }
    
    @objc func onCancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension TrackDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.count > 0 {
            onNext()
        }
        return false
    }
}

extension TrackDetailViewController {
    
    func observeChanges() {
        viewModel.mode.subscribe(onNext: { [weak self] mode in
            self?.update(to: mode)
        }).disposed(by: viewModel.disposeBag)
        
        trackNameTextFieldWithLabel.textField.rx.text.subscribe(onNext: { [weak self] text in
            guard let `self` = self else { return }
            guard let text = text, text.count > 0 else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                return
            }
            self.navigationItem.rightBarButtonItem?.isEnabled = (self.viewModel.mode.value == .create)
            (self.navigationController as? TrackNavigationViewController)?.trackCreationService?.buildingTrackModel.name = text
        }).disposed(by: viewModel.disposeBag)
    }
    
    func update(to mode: TrackDetailViewModel.Mode) {
        switch mode {
        case .create:
            title = "New Track"
            
            let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNext))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel))
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = nextButton
        case .edit:
            title = viewModel.trackModel.value?.name
        }
    }
}
