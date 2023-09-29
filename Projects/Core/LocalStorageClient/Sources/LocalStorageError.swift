//
//  LocalStorageError.swift
//  LocalStorageClient
//
//  Created by 김윤서 on 2023/09/24.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public enum LocalStorageError: Error {
    case fileNotFound
    case readError
    case writeError
    case deleteError
    case unknownError
}
