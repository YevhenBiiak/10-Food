//
//  VerificationViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

protocol VerificationViewModel {
    var verificationError: String? { get }
    var verificationCode: String? { get }
    var onUpdate: ((VerificationViewModel) -> Void)? { get set }
    func codeChanged(code: String?)
    func resentCode()
}

class VerificationViewModelImpl: VerificationViewModel {
    
    var verificationError: String? {
        didSet { onUpdate?(self) }
    }
    var verificationCode: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((VerificationViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    private var phone: String
    private let authService: AuthService
    
    init(authService: AuthService, phone: String) {
        self.authService = authService
        self.phone = phone
        self.authService.sendVerificationCode(phone: phone)
    }
    
    func codeChanged(code: String?) {
        verificationError = nil
        verificationCode = String(code?.filter("0123456789".contains).prefix(4) ?? "")
        guard let code = verificationCode, code.count == 4 else { return }
        
        do {
            try authService.signUp(phone: phone, code: code)
            print("Verification is successful")
        } catch {
            verificationError = error.localizedDescription
        }
    }
    
    func resentCode() {
        verificationError = nil
        verificationCode = nil
        authService.sendVerificationCode(phone: phone)
    }
}
