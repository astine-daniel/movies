enum URLFormComponent {
    case string(String)
    case array([URLFormComponent])
    case object([String: URLFormComponent])
}

// MARK: - Methods
extension URLFormComponent {
    var array: [URLFormComponent] {
        switch self {
        case let .array(array):
            return array

        default:
            return []
        }
    }

    var object: [String: URLFormComponent] {
        switch self {
        case let .object(object):
            return object

        default:
            return [:]
        }
    }

    mutating func set(to value: URLFormComponent, at path: [CodingKey]) {
        set(&self, to: value, at: path)
    }
}

// MARK: - Private extension
private extension URLFormComponent {
    func set(_ context: inout URLFormComponent, to value: URLFormComponent, at path: [CodingKey]) {
        guard path.count >= 1 else {
            context = value
            return
        }

        let key = path[0]
        var child: URLFormComponent

        switch path.count {
        case 1:
            child = value

        case 2...:
            if let index = key.intValue {
                let array = context.array
                if array.count > index {
                    child = array[index]
                } else {
                    child = .array([])
                }

                set(&child, to: value, at: Array(path[1...]))
            } else {
                child = (context.object[key.stringValue]) ?? .object([:])
                set(&child, to: value, at: Array(path[1...]))
            }

        default:
            fatalError("Unreachable")
        }

        if let index = key.intValue {
            if !context.array.isEmpty {
                var array = context.array

                if array.count > index {
                    array[index] = child
                } else {
                    array.append(child)
                }

                context = .array(array)
            } else {
                context = .array([child])
            }
        } else {
            if !context.object.isEmpty {
                var object = context.object
                object[key.stringValue] = child

                context = .object(object)
            } else {
                context = .object([key.stringValue: child])
            }
        }
    }
}
