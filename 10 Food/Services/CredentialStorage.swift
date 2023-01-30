//
//  CredentialStorage.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

class DefaultsCredentialStorage: CredentialStorage {
    
    private let defaults = UserDefaults.standard
    private lazy var key = String(describing: self)
    
    func save(_ credential: Credential) {
        let data = try? JSONEncoder().encode(credential)
        defaults.set(data, forKey: key)
    }
    
    func getCredential() -> Credential? {
        let data = defaults.object(forKey: key) as? Data
        return try? JSONDecoder().decode(Credential.self, from: data ?? Data())
    }

    func removeCredential() {
        defaults.removeObject(forKey: key)
    }
}


class KeychainCredentialStorage: CredentialStorage {
    
    func save(_ credential: Credential) {
        guard let password = credential.password.data(using: .utf8) else { return }
        try? KeychainWrapper.set(value: password, account: credential.phone)
    }
    
    func getCredential() -> Credential? {
        guard let account = try? KeychainWrapper.getAllAccounts().first,
              let data = try? KeychainWrapper.get(account: account),
              let password = String(data: data, encoding: .utf8)
        else { return nil }
        
        return Credential(phone: account, password: password)
    }
    
    func removeCredential() {
        try? KeychainWrapper.deleteAll()
    }
}
