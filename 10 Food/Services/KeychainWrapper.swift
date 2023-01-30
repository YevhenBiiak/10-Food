//
//  KeychainWrapper.swift
//  10 Food
//
//  Created by Yevhen Biiak on 30.01.2023.
//

import Foundation

// MARK: - KeychainWrapper

public class KeychainWrapper: NSObject {
    /**
     Function to store a keychain item
     - parameters:
     - value: Value to store in keychain in `data` format
     - account: Account name for keychain item
     */
    public static func set(value: Data, account: String) throws {
        // If the value exists `update the value`
        if try KeychainOperations.exists(account: account) {
            try KeychainOperations.update(value: value, account: account)
        } else {
            // Just insert
            try KeychainOperations.add(value: value, account: account)
        }
    }
    /**
     Function to retrieve an item in ´Data´ format (If not present, returns nil)
     - parameters:
     - account: Account name for keychain item
     - returns: Data from stored item
     */
    public static func get(account: String) throws -> Data? {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.retreive(account: account)
        } else {
            throw Errors.operationError
        }
    }
    /**
     Function to delete a single item
     - parameters:
     - account: Account name for keychain item
     */
    public static func delete(account: String) throws {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.delete(account: account)
        } else {
            throw Errors.operationError
        }
    }
    /**
     Function to retrieve accounts of all keychain entries matching the current ServiceName  if one is set.
     */
    public static func getAllAccounts() throws -> Set<String> {
        try KeychainOperations.allAccounts()
    }
    /**
     Function to delete all accounts of this service
     */
    public static func deleteAll() throws {
        try KeychainOperations.deleteAll()
    }
}

// MARK: - KeychainOperations

internal class KeychainOperations: NSObject {
    
    internal static let service = Bundle.main.bundleIdentifier ?? "MyKeychainStorage"
    
    /**
     Funtion to add an item to keychain
     - parameters:
     - value: Value to save in `data` format (String, Int, Double, Float, etc)
     - account: Account name for keychain item
     */
    internal static func add(value: Data, account: String) throws {
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock, // Allow background access
            kSecValueData: value,
            ] as NSDictionary, nil)
        guard status == errSecSuccess else { throw KeychainWrapper.Errors.operationError }
    }
    /**
     Function to update an item to keychain
     - parameters:
     - value: Value to replace for
     - account: Account name for keychain item
     */
    internal static func update(value: Data, account: String) throws {
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            ] as NSDictionary, [
                kSecValueData: value,
                ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainWrapper.Errors.operationError }
    }
    /**
     Function to retrieve an item to keychain
     - parameters:
     - account: Account name for keychain item
     */
    internal static func retreive(account: String) throws -> Data? {
        /// Result of getting the item
        var result: AnyObject?
        /// Status for the query
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            ] as NSDictionary, &result)
        // Switch to conditioning statement
        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainWrapper.Errors.operationError
        }
    }
    /**
     Function to retrieve accounts of all keychain entries matching the current ServiceName  if one is set.
     */
    internal static func allAccounts() throws -> Set<String> {
        /// Result of getting the item
        var result: AnyObject?
        /// Status for the query
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecReturnAttributes: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitAll,
        ] as CFDictionary, &result)

        guard status == errSecSuccess else { throw KeychainWrapper.Errors.operationError }
        
        var accounts = Set<String>()
        if let results = result as? [[CFString: Any]] {
            for attributes in results {
                if let account = attributes[kSecAttrAccount] as? String {
                    accounts.insert(account)
                }
            }
        }
        return accounts
    }
    /**
     Function to delete a single item
     - parameters:
     - account: Account name for keychain item
     */
    internal static func delete(account: String) throws {
        /// Status for the query
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainWrapper.Errors.operationError }
    }
    /**
     Function to delete all accounts of this service
     */
    internal static func deleteAll() throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
            ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainWrapper.Errors.operationError }
    }
    /**
     Function to check if we've an existing a keychain `item`
     - parameters:
     - account: String type with the name of the item to check
     - returns: Boolean type with the answer if the keychain item exists
     */
    static func exists(account: String) throws -> Bool {
        /// Constant with current status about the keychain to check
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: false,
            ] as NSDictionary, nil)
        // Switch to conditioning statement
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainWrapper.Errors.creatingError
        }
    }
}

// MARK: - KeychainError

extension KeychainWrapper {
    /// Private enum to return possible errors
    internal enum Errors: Error {
        /// Error with the keychain creting and checking
        case creatingError
        /// Error for operation
        case operationError
    }
}
