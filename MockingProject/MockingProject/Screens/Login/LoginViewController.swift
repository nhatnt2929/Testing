//
//  LoginViewController.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import NSObject_Rx

public struct AccessibilityLabels {
    public static let tabar_accessibility = "tabbar_accessibility"
    public static let login_accessibility = "login_accessibility"
    public static let login_button_accessibility = "login_button_accessibility"
    public static let register_button_accessibility = "register_button_accessibility"
    public static let login_email_accessibility = "login_email_accessibility"
    public static let login_password_accessibility = "login_password_accessibility"
    public static let login_error_accessibility = "login_error_accessibility"
    
    public static let register_accessibility = "register_accessibility"
    public static let register_email_accessibility = "register_email_accessibility"
    public static let register_pass_accessibility = "register_pass_accessibility"
    public static let register_name_accessibility = "register_name_accessibility"
    public static let register_toHome_accessibility = "register_toHome_accessibility"
    
    public static let home_accessibility = "home_accessibility"
}

public struct AccessibilityIdentifiers {
    public static let home_tableView_accessibility = "home_tableView_accessibility"
}

struct LoginConstants {
    static let loginAlphaEnable: CGFloat = 1.0
    static let loginAlphaDisable: CGFloat = 0.5
}

class LoginViewController: UIViewController, BindableType {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var viewModel: LoginViewModel!
    var loginSuccessButton: (() -> Void)?
    
    var validatePublishSubject = PublishSubject<(email: String, pass: String)>()
    var loginPublishSubject = PublishSubject<(email: String, pass: String)>()
    var registerPublishSubject = PublishSubject<Void>()
    var toHomePublishSubject = PublishSubject<Void>()
    
    var validateFormBinder: Binder<Bool> {
        return Binder(self) { vc, isValid in
            vc.handleUIValidate(isValid: isValid)
        }
    }
    
    var loginBinder: Binder<Token> {
        return Binder(self) { vc, token in
            vc.errorLabel.isHidden = true
            vc.toHomePublishSubject.onNext(())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUITesting()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func bindViewModel() {
        let validate = Driver.merge(validatePublishSubject.asDriverOnErrorJustComplete(),
                                    Driver.just((email: "", pass: "")))
        let input = LoginViewModel.Input(validateForm: validate,
                                         callLogin: loginPublishSubject.asDriverOnErrorJustComplete(),
                                         toRegister: registerPublishSubject.asDriverOnErrorJustComplete(),
                                         toHomeTrigger: toHomePublishSubject.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        
        output
            .validateForm
            .drive(validateFormBinder)
            .disposed(by: rx.disposeBag)
        
        output
            .callLogin
            .drive(loginBinder)
            .disposed(by: rx.disposeBag)
        
        output
            .toRegister
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.toHome
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.error.do(onNext: { [weak self] error in
            self?.errorLabel.text = error.localizedDescription
            self?.errorLabel.isHidden = false
        })
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension LoginViewController {
    
    fileprivate func setUpUITesting() {
        view.accessibilityLabel = AccessibilityLabels.login_accessibility
        loginButton.accessibilityLabel = AccessibilityLabels.login_button_accessibility
        registerButton.accessibilityLabel = AccessibilityLabels.register_button_accessibility
        emailTextField.accessibilityLabel = AccessibilityLabels.login_email_accessibility
        passTextField.accessibilityLabel = AccessibilityLabels.login_password_accessibility
        errorLabel.accessibilityLabel = AccessibilityLabels.login_error_accessibility
    }
    
    fileprivate func setUpUI() {
        errorLabel.isHidden = true
        emailTextField.do {
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            $0.leftViewMode = .always
            $0.rx
            .controlEvent([.editingChanged])
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self,
                    let email = self.emailTextField.text,
                    let pass = self.passTextField.text else { return }
                self.hiddenErrorMessage()
                self.validatePublishSubject.onNext((email: email, pass: pass))
            }).disposed(by: rx.disposeBag)
        }
        
        passTextField.do {
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            $0.leftViewMode = .always
            $0.rx
                .controlEvent([.editingChanged])
                .subscribe(onNext: { [weak self] text in
                    guard let `self` = self,
                        let email = self.emailTextField.text,
                        let pass = self.passTextField.text else { return }
                    self.hiddenErrorMessage()
                    self.validatePublishSubject.onNext((email: email, pass: pass))
                }).disposed(by: rx.disposeBag)
        }
        
        loginButton.rx.tap.bind { [weak self] in
                guard let `self` = self,
                            let email = self.emailTextField.text,
                            let pass = self.passTextField.text else { return }
            self.loginPublishSubject.onNext((email: email, pass: pass))
            self.view.endEditing(true)
        }.disposed(by: rx.disposeBag)
        
        registerButton.rx.tap.bind { [weak self] in
            self?.registerPublishSubject.onNext(())
        }.disposed(by: rx.disposeBag)
    }
    
    fileprivate func hiddenErrorMessage() {
        errorLabel.isHidden = true
    }
    
    fileprivate func handleUIValidate(isValid: Bool) {
        loginButton.isEnabled = isValid
        loginButton.alpha = isValid ? LoginConstants.loginAlphaEnable : LoginConstants.loginAlphaDisable
    }
}

extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
