//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

extension URLConstructor {
    private var accountInfo: String      { "account/{email}/info/" }
    private var accountName: String      { "account/{email}/name/"}
    private var accountSettings: String  { "account/{email}/settings/" }
    private var accountAddresses: String { "account/{email}/addresses/" }
    
    public func accountInfo(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountInfo), relativeTo: baseURL)!
    }
    
    public func accountName(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountName), relativeTo: baseURL)!
    }
    
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   settings: AccountSettings
 
 POST
 Auth: Yes
 Body: AccountSettings
 Response: BasicResponse
*/
    public func accountSettings(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountSettings), relativeTo: baseURL)!
    }
    
/*
 GET
 Auth: YES
 Body: None
 Response: [
     AccountAddress, AccountAddress, ...
 ]
*/
    public func accountAddresses(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountAddresses), relativeTo: baseURL)!
    }
    
}
