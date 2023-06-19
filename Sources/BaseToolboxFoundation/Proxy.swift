import Foundation

@propertyWrapper
public struct AnyProxy<EnclosingType, Value> {
    public typealias ValueKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>
    public typealias SelfKeyPath = ReferenceWritableKeyPath<EnclosingType, Self>

    public static subscript(
        _enclosingInstance instance: EnclosingType,
        wrapped wrappedKeyPath: ValueKeyPath,
        storage storageKeyPath: SelfKeyPath
    ) -> Value {
        get {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            return instance[keyPath: keyPath]
        }
        set {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            instance[keyPath: keyPath] = newValue
        }
    }

    @available(*, unavailable, message: "@Proxy can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    private let keyPath: ValueKeyPath

    public init(_ keyPath: ValueKeyPath) {
        self.keyPath = keyPath
    }
}

public protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self, T>
}

extension NSObject: ProxyContainer {}
