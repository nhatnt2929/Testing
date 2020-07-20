//
//  LoginViewController.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import UIKit
import Reusable

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpUITesting()
    }
}

extension RegisterViewController {
    
    fileprivate func setUpUITesting() {
        view.accessibilityLabel = AccessibilityLabels.register_accessibility
        registerButton.accessibilityLabel =  AccessibilityLabels.register_toHome_accessibility
    }
    
    fileprivate func setUpUI() {
        validateForm()
        emailTextField.do {
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            $0.leftViewMode = .always
            $0.accessibilityLabel = AccessibilityLabels.register_email_accessibility
            $0.rx
            .controlEvent([.editingChanged])
            .subscribe(onNext: { [weak self] text in
                self?.validateForm()
            }).disposed(by: rx.disposeBag)
        }
        
        passTextField.do {
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            $0.leftViewMode = .always
            $0.accessibilityLabel = AccessibilityLabels.register_pass_accessibility
            $0.rx
            .controlEvent([.editingChanged])
            .subscribe(onNext: { [weak self] text in
                self?.validateForm()
            }).disposed(by: rx.disposeBag)
        }
        
        nameTextField.do {
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            $0.leftViewMode = .always
            $0.accessibilityLabel = AccessibilityLabels.register_name_accessibility
            $0.rx
            .controlEvent([.editingChanged])
            .subscribe(onNext: { [weak self] text in
                self?.validateForm()
            }).disposed(by: rx.disposeBag)
        }
        
        registerButton.rx.tap.bind { [weak self] in
            let homeVc = HomeViewController.instantiate()
            self?.navigationController?.pushViewController(homeVc, animated: true)
        }.disposed(by: rx.disposeBag)
    }
    
    fileprivate func validateForm() {
        guard let email = emailTextField.text,
            let pass = passTextField.text,
            let name = nameTextField.text else { return }
        let isValid = !email.isEmpty && !pass.isEmpty && !name.isEmpty
        registerButton.isEnabled = isValid
        registerButton.alpha = isValid ? 1.0 : 0.5
    }
}

extension RegisterViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.register
}
