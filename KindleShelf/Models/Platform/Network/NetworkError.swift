//
//  NetworkError.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    /// Unknown or not supported error.
    case unknown

    /// Not connected to the internet.
    case notConnectedToInternet

    /// International data roaming turned off.
    case internationalRoamingOff

    /// Cannot reach the server.
    case notReachedServer

    /// Connection is lost.
    case connectionLost

    /// Incorrect data returned from the server.
    case incorrectDataReturned

    internal init(error: Error) { // swiftlint:disable:this cyclomatic_complexity function_body_length
        if error._domain == NSURLErrorDomain {
            switch error._code {
            case NSURLErrorUnknown:
                self = .unknown
            case NSURLErrorCancelled:
                self = .unknown // Cancellation is not used in this project.
            case NSURLErrorBadURL:
                self = .incorrectDataReturned // Because it is caused by a bad URL returned in a JSON response from the server.
            case NSURLErrorTimedOut:
                self = .notReachedServer
            case NSURLErrorUnsupportedURL:
                self = .incorrectDataReturned
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                self = .notReachedServer
            case NSURLErrorDataLengthExceedsMaximum:
                self = .incorrectDataReturned
            case NSURLErrorNetworkConnectionLost:
                self = .connectionLost
            case NSURLErrorDNSLookupFailed:
                self = .notReachedServer
            case NSURLErrorHTTPTooManyRedirects:
                self = .unknown
            case NSURLErrorResourceUnavailable:
                self = .incorrectDataReturned
            case NSURLErrorNotConnectedToInternet:
                self = .notConnectedToInternet
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .incorrectDataReturned
            case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
                self = .unknown
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .incorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .incorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .internationalRoamingOff
            case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
                self = .unknown
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .incorrectDataReturned
            case NSURLErrorNoPermissionsToReadFile,
                 NSURLErrorSecureConnectionFailed,
                 NSURLErrorServerCertificateHasBadDate,
                 NSURLErrorServerCertificateUntrusted,
                 NSURLErrorServerCertificateHasUnknownRoot,
                 NSURLErrorServerCertificateNotYetValid,
                 NSURLErrorClientCertificateRejected,
                 NSURLErrorClientCertificateRequired,
                 NSURLErrorCannotLoadFromNetwork,
                 NSURLErrorCannotCreateFile,
                 NSURLErrorCannotOpenFile,
                 NSURLErrorCannotCloseFile,
                 NSURLErrorCannotWriteToFile,
                 NSURLErrorCannotRemoveFile,
                 NSURLErrorCannotMoveFile,
                 NSURLErrorDownloadDecodingFailedMidStream,
                 NSURLErrorDownloadDecodingFailedToComplete:
                self = .unknown
            default:
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }

}
