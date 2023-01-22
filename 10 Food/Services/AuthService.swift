//
//  AuthService.swift
//  10 Food
//
//  Created by Yevhen Biiak on 18.01.2023.
//

import Foundation

struct User {
    let phone: String
}

struct Credential: Hashable, Codable {
    let phone: String
    let password: String
}

protocol CredentialStorage {
    func save(_ credential: Credential)
    func getCredential() -> Credential?
    func removeCredential()
}

protocol NotificationService {
    func notify(phone: String, withTitle title: String, message: String)
}

protocol AuthService {
    func currentUser() -> User?
    func signIn(phone: String, password: String) throws -> User
    func signUp(phone: String, code: String) throws -> User
    func sendVerificationCode(phone: String)
}

class AuthServiceImpl: AuthService {
    
    private let credentialStorage: CredentialStorage
    private let notificationService: NotificationService
    
    private var phoneToVerification: String?
    private var verificationCode: String?
    
    init(credentialStorage: CredentialStorage, notificationService: NotificationService) {
        self.credentialStorage = credentialStorage
        self.notificationService = notificationService
    }
    
    func currentUser() -> User? {
        let credential = credentialStorage.getCredential()
        return credential == nil ? nil : User(phone: credential!.phone)
    }
    
    func signIn(phone: String, password: String) throws -> User {
        let credential = credentialStorage.getCredential()
        
        switch (credential?.phone, credential?.password) {
        case (phone, password):
            return User(phone: phone)
        case (phone, _), (_, password):
            throw AuthError.wrongPhoneOrPassowrd
        default:
            throw AuthError.userIsNotRegistered(phone: phone)
        }
    }
    
    func signUp(phone: String, code: String) throws -> User {
        guard phone == phoneToVerification, code == verificationCode else {
            throw AuthError.incorrectVerificationCode
        }
        
        // generate password
        let password = String("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".shuffled().prefix(4))
        let credential = Credential(phone: phone, password: password)
        
        credentialStorage.save(credential)
        notificationService.notify(phone: phone, withTitle: "Your password for 10 Food App", message: password)
        
        return User(phone: phone)
    }
    
    func sendVerificationCode(phone: String) {
        phoneToVerification = phone
        
        // generate verification code
        verificationCode = "\(Int.random(in: 1000...9999))"
        notificationService.notify(phone: phone, withTitle: "Verification Code", message: verificationCode!)
    }
}

extension AuthServiceImpl {
    
    enum AuthError: Error, LocalizedError {
        case wrongPhoneOrPassowrd
        case userIsNotRegistered(phone: String)
        case incorrectVerificationCode
        
        var errorDescription: String? {
            switch self {
            case .wrongPhoneOrPassowrd:
                return "Wrong phone or passowrd"
            case .userIsNotRegistered(let phone):
                return "User with phone \(phone) is not registered"
            case .incorrectVerificationCode:
                return "The verification code is incorrect"
            }
        }
    }
}
