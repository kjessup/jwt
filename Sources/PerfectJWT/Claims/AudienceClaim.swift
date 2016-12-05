import Foundation


public struct AudienceClaim {
    fileprivate let value: Set<String>

    public init(_ string: String) {
        self.value = [string]
    }

    public init(_ strings: Set<String>) {
        self.value = strings
    }

    init?(_ node: Node) {
        switch node {
        case .string(let string):
            self.init(string)
        case .array(let nodes):
            let strings = nodes.flatMap { (node: Node) -> String? in
                if case .string(let string) = node {
                    return string
                }
                return nil
            }
            self.init(Set(strings))
        default:
            return nil
        }
    }
}

extension AudienceClaim: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

extension AudienceClaim: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: String...) {
        self.init(Set(elements))
    }
}

extension AudienceClaim: Claim {
    public static let name = "aud"

    public func verify(_ node: Node) -> Bool {
        guard let other = AudienceClaim(node) else {
            return false
        }

        return value.intersection(other.value).count == other.value.count
    }

    public var node: Node {
        return .array(value.array.map(Node.string))
    }
}
