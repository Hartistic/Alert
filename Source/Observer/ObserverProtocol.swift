import Foundation

/// Observer protocol.
public protocol ObserverProtocol {
    associatedtype Value
    typealias Closure = (_ oldValue: Value, _ newValue: Value) -> Void

    /// Value that is wrapped in the observable, and can be read from or written to.
    var value: Value { get set }

     /// Method that is used to bind a block of code to changes that may happen with the value that this
     /// observable wraps.
     /// - Parameter closure: (Closure) that will be called when the value that this observer wraps changes
     /// - Returns: The existing value that is wrapped
    mutating func bind(closure: @escaping Closure) -> Value
}
