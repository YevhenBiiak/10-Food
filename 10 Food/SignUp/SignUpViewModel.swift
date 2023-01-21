//
//  SignUpViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

protocol SignUpViewModel {
    var phone: String? { get }
    var prompt: String? { get }
    var onUpdate: ((SignUpViewModel) -> Void)? { get set }
    func phoneChanged(_ phone: String?)
    func verificationViewModel() -> VerificationViewModel
}

class SignUpViewModelImpl: SignUpViewModel {
    
    var phone: String? {
        didSet { onUpdate?(self) }
    }
    var prompt: String? {
        "We have sent you an SMS with a code to number \(phone ?? "")"
    }
    var onUpdate: ((SignUpViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private var authService: AuthService
    
    init(authService: AuthService, phone: String?) {
        self.authService = authService
        self.phone = phone
    }
    
    func phoneChanged(_ phone: String?) {
        self.phone = phone
    }
    
    func verificationViewModel() -> VerificationViewModel {
        VerificationViewModelImpl(authService: authService, phone: phone ?? "")
    }
}
