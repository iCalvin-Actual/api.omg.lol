//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class OAuthRequest: APIRequest<OAuthRequest.Parameters, OAuthResponse> {
    struct Parameters: RequestBody {
        let clientId: String
        let clientSecret: String
        let redirectURI: String
        let accessCode: String
        let scope = "everything"
    }
    init(with clientId: String, and clientSecret: String, redirect: String, accessCode: String) {
        super.init(
            path: AccountPath.oauth,
            body: Parameters(
                clientId: clientId,
                clientSecret: clientSecret,
                redirectURI: redirect,
                accessCode: accessCode
            )
        )
    }
}

class GETAccountInfoAPIRequest: APIRequest<None, AccountInfo> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

class GETAccountNameAPIRequest: APIRequest<None, AccountOwner> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.name(emailAddress)
        )
    }
}

class SETAccountNameAPIRequest: APIRequest<SETAccountNameAPIRequest.Parameters, AccountOwner> {
    struct Parameters: RequestBody {
        let name: String
    }
    init(newValue: String, for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.name(emailAddress),
            body: Parameters(name: newValue)
        )
    }
}

class GETAccountSettingsAPIRequest: APIRequest<None, AccountSettings> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.settings(emailAddress)
        )
    }
}

class SETAccountSettingsAPIRequest: APIRequest<SETAccountSettingsAPIRequest.Parameters, BasicResponse> {
    struct Parameters: RequestBody {
        let communication: CommunicationPreference
    }
    init(communicationPreference: CommunicationPreference, for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.settings(emailAddress),
            body: Parameters(communication: communicationPreference)
        )
    }
}

class GETAddresses: APIRequest<None, AddressCollection> {
    init(authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses
        )
    }
}

class GETAddressesForEmailAPIRequest: APIRequest<None, AddressCollection> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.emailAddresses(emailAddress)
        )
    }
}
