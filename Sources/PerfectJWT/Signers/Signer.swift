

public protocol Signer {
    var name: String { get }
    func sign(_ message: Bytes) throws -> Bytes
    func verifySignature(_ signature: Bytes, message: Bytes) throws -> Bool
}

extension Signer {
    public var name: String {
        return String(describing: Self.self)
    }
}

public protocol Key {
    var key: Bytes { get }
    init(key: Bytes)
}

extension Key {
    public init(key: String) {
        self.init(key: key.bytes)
    }

    public init(encodedKey key: String, encoding: Encoding = Base64Encoding()) throws {
        try self.init(key: encoding.decode(key))
    }
}
