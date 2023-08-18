//
//  KeychainValue.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/08/18.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation
import Security

@propertyWrapper
public struct KeychainValue {
    private let key: String
    private let service = "com.earthIsRound.release"

    init(key: String) {
        self.key = key
    }

    public var wrappedValue: String? {
        get {
            return getData()
        }
        set {
            if let value = newValue {
                saveData(value)
            } else {
                deleteData()
            }
        }
    }

    private func saveData(_ value: String) {
        guard let data = value.data(using: .utf8) else {
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to save data in Keychain")
        }
    }

    private func getData() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess,
            let data = dataTypeRef as? Data,
            let value = String(data: data, encoding: .utf8) {
            return value
        } else {
            return nil
        }
    }

    private func deleteData() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Failed to delete data from Keychain")
        }
    }
}
