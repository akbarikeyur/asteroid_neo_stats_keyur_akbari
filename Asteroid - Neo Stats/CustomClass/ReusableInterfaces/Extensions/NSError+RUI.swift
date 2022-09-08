//
//  NSErrorAdditions.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

public extension NSError {
    
    func isNoConnectionError() -> Bool {
        return self.domain == NSURLErrorDomain && self.code == NSURLErrorNotConnectedToInternet
    }
    
    func isFileNotFoundError() -> Bool {
        return self.domain == NSCocoaErrorDomain && self.code == NSFileReadNoSuchFileError
    }
    
}
