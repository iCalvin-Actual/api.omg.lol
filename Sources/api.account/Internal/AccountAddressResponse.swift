//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

struct AccountAddressResponse: Response {
    let message: String?
    let address: String
    let registration: TimeStamp
}

typealias AddressCollection = [AccountAddressResponse]
extension AddressCollection: Response { }
