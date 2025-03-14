// Copyright © 2017 Trust.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import TrezorCryptoC

// Hierarchical deterministic key.
public class HDKey {
    var node: HDNode

    init(node: HDNode) {
        self.node = node
    }

    /// Signs a hash using this key.
    ///
    /// - Parameters:
    ///   - hash: hash to sign
    /// - Returns: signature
    public func sign(hash: Data) throws -> Data {
        return try Secp256k1.shared.sign(hash: hash, privateKey: privateKey)
    }

    /// The key's address.
    public var address: Address {
        var addressData = Data(repeating: 0, count: 20)
        _ = addressData.withUnsafeMutableBytes { addrPtr in
            hdnode_get_ethereum_pubkeyhash(&node, addrPtr)
        }
        return Address(data: addressData)
    }

    /// Private key data.
    public var privateKey: Data {
        return Data(bytes: withUnsafeBytes(of: &node.private_key) { ptr in
            return ptr.map({ $0 })
        })
    }

    /// Public key data.
    public var publicKey: Data {
        var key = Data(repeating: 0, count: 65)
        privateKey.withUnsafeBytes { ptr in
            key.withUnsafeMutableBytes { keyPtr in
                ecdsa_get_public_key65(node.curve.pointee.params, ptr, keyPtr)
            }
        }
        return key
    }
}
