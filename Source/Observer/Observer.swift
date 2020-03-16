import Foundation

/// Observable the wraps around a type so that it can be observed.
public class Observer<T>: ObserverProtocol {
    public typealias Value = T
    public typealias Closure = (_ oldValue: T, _ newValue: T) -> Void
    private var observers = [String: Observer.Closure]()

    public var value: T {
        didSet {
            for closure in observers.values {
                closure(oldValue, value)
            }
        }
    }

    public init(value: T) {
        self.value = value
    }

    /// Method that is called in order to attach a closure to be notified when the value of this
    /// observer changes.  There can be more than one closure attached.
    /// - Parameter closure: (Closure) that will be bound to the value changes
    /// - Returns: (T) Generic Current value
    @discardableResult public func bind(closure: @escaping Closure) -> T {
        return bind(closure: closure).currentValue
    }

    /// Method that is called in order to attach a closure to be notified when the value of this
    /// observer changes.  There can be more than one closure attached.
    /// - Parameter closure: (Closure) Will be bound to the value changes
    /// - Returns: id (String) that represents the stored closure to be removed and is a
    /// randomly generated String, currentValue - Current value
    @discardableResult public func bind(closure: @escaping Closure) -> (id: String, currentValue: T) {
        return bind(id: UUID().uuidString, closure: closure)
    }

    /// Method that is called in order to attach a closure to be notified when the value of this
    /// observer changes.  There can be more than one closure attached.
    /// - Parameters:
    ///   - id: (String) to represent the stored closure
    ///   - closure: (Closure) that will be bound to the value changes
    /// - Returns: id (String) that represents the stored closure to be removed,
    /// currentValue - Current value
    @discardableResult public func bind(id: String, closure: @escaping Closure) -> (id: String, currentValue: T) {
        observers[id] = closure
        return (id, value)
    }

    /// Method that is called in order to remove a closure.
    /// - Parameter id: (String) for the the closure to be removed
    public func unbind(id: String) {
        observers[id] = nil
    }

    /// Method that will remove all closures that have been bound to this observer.
    public func unbindAll() {
        observers.removeAll()
    }

    /// Method to set the value, and ensure that it is all performed on the main thread rather than
    /// whatever thread that is currently running.
    /// - Parameter value: (T) New value to set on the observable
    public func post(value: T) {
        DispatchQueue.main.async {
            self.value = value
        }
    }
}
