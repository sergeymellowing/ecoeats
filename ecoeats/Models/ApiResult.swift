//
//  ApiResult.swift
//  ecoeats
//
//  Created by 이준녕 on 8/20/24.
//

import Foundation

enum ApiResult<T> {
    case success(T), failure(Error)
}

enum ApiError: Error {
    case invalidUrl, invalidJSON, httpError, notFound, generalError
}
