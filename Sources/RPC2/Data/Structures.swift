//
//  File.swift
//  
//
//  Created by Daniel Leping on 15/12/2020.
//

import Foundation

public typealias RPCID = UInt32
let _id_queue = DispatchQueue(label: "one.tesseract.rpc.idqueue")
var _id_current:UInt32 = 1

extension RPCID {
    static func next() -> RPCID {
        _id_queue.sync {
            _id_current = _id_current + 1
            return _id_current
            return 1
        }
    }
}

public struct RequestEnvelope<P: Encodable>: Encodable {
    public let jsonrpc: String
    public let id: RPCID
    public let method: String
    public let params: P
}

public struct ResponseEnvelope<R: Decodable, E: Decodable>: Decodable {
    public let jsonrpc: String
    public let id: RPCID
    public let result: R?
    public let error: E?
}

public struct EnvelopeHeader: Decodable {
    public let jsonrpc: String
    public let id: RPCID?
    public let method: String?
}

public enum EnvelopeMetadata {
    case request(id: RPCID, method: String)
    case response(id: RPCID)
    case notification(method: String)
    case unknown(version: String)
    case malformed //no id and method at the same time
}

public extension EnvelopeHeader {
    var metadata: EnvelopeMetadata {
        get {
            guard self.jsonrpc == "1.0" || self.jsonrpc == "1.1" || self.jsonrpc == "2.0" else {
                return .unknown(version: self.jsonrpc)
            }
            
            if let id = self.id {
                if let method = self.method {
                    return .request(id: id, method: method)
                } else {
                    return .response(id: id)
                }
            } else {
                if let method = self.method {
                    return .notification(method: method)
                } else {
                    return .malformed
                }
            }
        }
    }
}

/*public struct EventEnvelope<M: Decodable>: Decodable {
    public let jsonrpc: String
    public let method: String
    public let params: M
}*/
