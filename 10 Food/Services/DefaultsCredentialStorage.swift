//
//  DefaultsCredentialStorage.swift
//  10 Food
//
//  Created by Yevhen Biiak on 19.01.2023.
//

import Foundation

class DefaultsCredentialStorage: CredentialStorage {
    
    private lazy var key = String(describing: self)
    
    func save(_ credential: Credential) {
        let data = try? JSONEncoder().encode(credential)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getCredential() -> Credential? {
        let data = UserDefaults.standard.object(forKey: key) as? Data
        return try? JSONDecoder().decode(Credential.self, from: data ?? Data())
    }

    func removeCredential() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
