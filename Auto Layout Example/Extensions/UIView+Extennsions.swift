import UIKit

public extension UIView {
    enum LayoutEdge {
        case top, left, right, bottom // swiftlint:disable:this identifier_name
    }

    enum LayoutAxis {
        case horizontal, vertical
    }

    enum LayoutDimension {
        case height, width
    }

    @discardableResult
    func matchDimensions(of view: UIView) -> [NSLayoutConstraint] {
        let anchors = [
            heightAnchor.constraint(equalTo: view.heightAnchor),
            widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        anchors.forEach { $0.isActive = true }
        return anchors
    }

    @discardableResult
    func match(
        dimension: LayoutDimension,
        to view: UIView,
        withMultiplier multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = {
            switch dimension {
            case .width:
                return self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)

            case .height:
                return self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
            }
        }()

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinEdgeToSuperview(edge: LayoutEdge, inset: CGFloat = 0,
                            relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return constrain(edge: edge, to: superview!, constant: inset, relation: relation)
    }

    @discardableResult
    func pinEdgesToSuperview(edges: [LayoutEdge],
                             inset: CGFloat = 0,
                             relation: NSLayoutConstraint.Relation = .equal) -> [NSLayoutConstraint] {
        return edges.map({ constrain(edge: $0, to: superview!, constant: inset, relation: relation) })
    }

    @discardableResult
    func pinEdgeToSuperview(margin: LayoutEdge,
                            inset: CGFloat = 0,
                            relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return constrain(margin: margin, to: superview!, constant: inset, relation: relation)
    }

    @discardableResult
    func pinEdgesToSuperview(margins: [LayoutEdge],
                             inset: CGFloat = 0,
                             relation: NSLayoutConstraint.Relation = .equal) -> [NSLayoutConstraint] {
        return margins.map({ constrain(margin: $0, to: superview!, constant: inset, relation: relation) })
    }

    @discardableResult
    func pinEdgesToSuperviewEdges(insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let pairs: [(LayoutEdge, CGFloat)] = [(.top, insets.top),
                                              (.left, insets.left),
                                              (.bottom, insets.bottom),
                                              (.right, insets.right)]
        return pairs.map({ constrain(edge: $0.0, to: superview!, constant: $0.1, relation: .equal) })
    }

    @discardableResult
    func set(dimension: LayoutDimension, to size: CGFloat,
             relation: NSLayoutConstraint.Relation = .equal,
             priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return constrain(dimension: dimension, size: size, relation: relation, priority: priority)
    }

    @discardableResult
    func set(dimensionsTo size: CGSize, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        let dimensions: [(LayoutDimension, CGFloat)] = [(.width, size.width),
                                                        (.height, size.height)]
        return dimensions.map({ constrain(dimension: $0.0, size: $0.1, relation: .equal, priority: priority) })
    }

    @discardableResult
    func align(axis: LayoutAxis, offset: CGFloat = 0,
               relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return constrain(axis: axis, to: superview!, constant: offset, relation: relation)
    }

    @discardableResult
    func align(axis: LayoutAxis, toAxisOf view: UIView, offset: CGFloat = 0,
               relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return constrain(axis: axis, to: view, constant: offset, relation: relation)
    }

    @discardableResult
    func centerInSuperview() -> [NSLayoutConstraint] {
        let axis: [LayoutAxis] = [.horizontal, .vertical]
        return axis.map({ constrain(axis: $0, to: superview!, constant: 0, relation: .equal) })
    }

    @discardableResult
    func pin(edge: LayoutEdge, to edge2: LayoutEdge,
             of view: UIView, offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        switch (edge, edge2) {
        case (.top, .bottom):
            return constrain(topAnchor, to: view.bottomAnchor,
                             constant: offset, relation: relation)
        case (.bottom, .top):
            return constrain(bottomAnchor, to: view.topAnchor,
                             constant: offset, relation: relation)
        case (.left, .right):
            return constrain(leftAnchor, to: view.rightAnchor,
                             constant: offset, relation: relation)
        case (.right, .left):
            return constrain(rightAnchor, to: view.leftAnchor,
                             constant: offset, relation: relation)
        default:
            fatalError("Only bottom<->top and left<->right constraints are supported")
        }
    }
}

extension UIView {
    private func constrain<T>(_ anchor1: NSLayoutAnchor<T>,
                              to anchor2: NSLayoutAnchor<T>,
                              constant: CGFloat = 0,
                              relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint = {
            switch relation {
            case .equal:
                return anchor1.constraint(equalTo: anchor2, constant: constant)

            case .greaterThanOrEqual:
                return anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)

            case .lessThanOrEqual:
                return anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)

            @unknown default:
                return anchor1.constraint(equalTo: anchor2, constant: constant)
            }
        }()
        constraint.isActive = true
        return constraint
    }
}

extension UIView {
    private func constrain(dimension: LayoutDimension,
                           size: CGFloat,
                           relation: NSLayoutConstraint.Relation,
                           priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = {
            switch dimension {
            case .height:
                return heightAnchor.constraint(equalToConstant: size)

            case .width:
                return widthAnchor.constraint(equalToConstant: size)
            }
        }()
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

extension UIView {
    private func constrain(axis: LayoutAxis,
                           to view: UIView,
                           constant: CGFloat,
                           relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        switch axis {
        case .horizontal:
            return constrain(centerYAnchor, to: view.centerYAnchor,
                             constant: constant, relation: relation)
        case .vertical :
            return constrain(centerXAnchor, to: view.centerXAnchor,
                             constant: constant, relation: relation)
        }
    }
}

extension UIView {
    private func constrain(edge: LayoutEdge,
                           to view: UIView,
                           constant: CGFloat = 0,
                           relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        switch edge {
        case .top:
            return constrain(topAnchor, to: view.topAnchor,
                             constant: constant, relation: relation)
        case .left:
            return constrain(leftAnchor, to: view.leftAnchor,
                             constant: constant, relation: relation)
        case .right:
            return constrain(rightAnchor, to: view.rightAnchor,
                             constant: -constant, relation: relation)
        case .bottom:
            return constrain(bottomAnchor, to: view.bottomAnchor,
                             constant: -constant, relation: relation)
        }
    }

    private func constrain(margin: LayoutEdge,
                           to view: UIView,
                           constant: CGFloat = 0,
                           relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            switch margin {
            case .top:
                return constrain(topAnchor, to: view.safeAreaLayoutGuide.topAnchor,
                                 constant: constant, relation: relation)
            case .left:
                return constrain(leftAnchor, to: view.safeAreaLayoutGuide.leftAnchor,
                                 constant: constant, relation: relation)
            case .right:
                return constrain(rightAnchor, to: view.safeAreaLayoutGuide.rightAnchor,
                                 constant: -constant, relation: relation)
            case .bottom:
                return constrain(bottomAnchor, to: view.safeAreaLayoutGuide.bottomAnchor,
                                 constant: -constant, relation: relation)
            }
        } else {
            switch margin {
            case .top:
                return constrain(topAnchor, to: view.layoutMarginsGuide.topAnchor,
                                 constant: constant, relation: relation)
            case .left:
                return constrain(leftAnchor, to: view.layoutMarginsGuide.leftAnchor,
                                 constant: constant, relation: relation)
            case .right:
                return constrain(rightAnchor, to: view.layoutMarginsGuide.rightAnchor,
                                 constant: -constant, relation: relation)
            case .bottom:
                return constrain(bottomAnchor, to: view.bottomAnchor,
                                 constant: -constant, relation: relation)
            }
        }
    }
}
