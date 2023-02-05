//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAddressProfile: APIRequest<None, AddressProfileResponseModel> {
    init(_ address: AddressName, with authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: ProfilePath.profile(address)
        )
    }
}

class SETAddressProfile: APIRequest<PublicProfile.Draft, BasicResponse> {
    init(_ newContent: PublicProfile.Draft, for address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: ProfilePath.profile(address),
            body: newContent
        )
    }
}

class GETAddressPhoto: APIRequest<ProfilePhoto, BasicResponse> {
    init(_ address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            path: ProfilePath.photo(address)
        )
    }
}

class SETAddressPhoto: APIRequest<ProfilePhoto, BasicResponse> {
    init(_ photo: ProfilePhoto, for address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: ProfilePath.profile(address),
            body: photo
        )
    }
}

extension APIRequestConstructor {
    func getAddressProfile(_ address: String) -> URLRequest {
        return request(with: urlConstructor.addressProfile(address: address))
    }
    
    func udpateAddressProfile(_ address: String, newContent: String, publish: Bool = false) -> URLRequest {
        struct Parameters: Encodable {
            let publish: Bool
            let conetnt: String
        }
        return request(method: .POST, with: urlConstructor.addressProfile(address: address), bodyParameters: Parameters(publish: publish, conetnt: newContent))
    }
    
    func updatePhoto(_ address: String, data: Data) -> URLRequest {
        var request = request(method: .POST, with: urlConstructor.addressPhoto(address: address))
        
        var body = Data()
        let lineBreak = "\r\n"
        let boundary: String = "Boundary-\("562F49C8-26CD-4D87-9C8F-DEA380DE4BF007")"
        let file = "multipartData"
        let boundaryPrefix = "--\(boundary)\r\n"
        body.append(Data(boundaryPrefix.utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(file)\"\r\n".utf8))
        body.append(Data("Content-Type: \("application/json;charset=utf-8")\r\n\r\n".utf8))
        body.append(data)
        body.append(Data("\r\n".utf8))
        body.append(Data("--\(boundary)--\(lineBreak)".utf8))

        request.httpBody = body
        
        return request
    }
}
