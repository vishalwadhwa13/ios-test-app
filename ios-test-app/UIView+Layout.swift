//
//  UIView+Layout.swift
//  SwiftLayout
//
//  Created by Mehul Srivastava on 19/04/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

fileprivate extension NSLayoutConstraint.Relation {
    
    func inverse() -> NSLayoutConstraint.Relation {
        switch self {
        case .equal:
            return .equal
        case .greaterThanOrEqual:
            return .lessThanOrEqual
        case .lessThanOrEqual:
            return .greaterThanOrEqual
        @unknown default:
            return self
        }
    }
}

public class ConstraintCreator: NSObject {

    let constraints: [Constraint]
    
    public init(constraints: [Constraint]) {
        self.constraints = constraints
    }
    
    //Public enum containing all possible cases for "Getting" the constraint
    public enum ConstraintType {
        
        case top
        case bottom
        case leading
        case trailing
        case width
        case height
        case centerX
        case centerY
        case aspectRatio
    }
    
    //Public enum containing all possible cases for constraints
    public enum Constraint {
        
        case equate(viewAttribute: NSLayoutConstraint.Attribute, toView: UIView, toViewAttribute:  NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat)
        
        case height(view: UIView?, relation: NSLayoutConstraint.Relation, constant:CGFloat)
        
        case width(view: UIView?, relation: NSLayoutConstraint.Relation, constant:CGFloat)
        
        case top(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case bottom(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case leading(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case trailing(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case before(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case after(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case above(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case below(view: UIView, constant: CGFloat, relation: NSLayoutConstraint.Relation)
        
        case centerX(view: UIView, constant:CGFloat)
        
        case centerY(view: UIView, constant:CGFloat)
        
        case aspectRatio(ratio: CGFloat)
        
        //A helper method which returns a NSLayoutConstraint on the basis of provided values
        func getConstraint(for view: UIView) -> NSLayoutConstraint {
            
            switch self {
                
            case .equate(viewAttribute: let viewAttribute, toView: let toView, toViewAttribute: let toViewAttribute, relation: let relation, constant: let constant):
                
                return NSLayoutConstraint(item: view, attribute: viewAttribute, relatedBy: relation, toItem: toView, attribute: toViewAttribute, multiplier: 1, constant: constant)
                
            case .height(view: let toView, relation: let relation, constant: let constant):
                
                return NSLayoutConstraint(item: view, attribute: .height, relatedBy: relation, toItem: nil, attribute: toView == nil ? .notAnAttribute : .height, multiplier: 1, constant: constant)
                
            case .width(view: let toView, relation: let relation, constant: let constant):
                
                return NSLayoutConstraint(item: view, attribute: .width, relatedBy: relation, toItem: nil, attribute: toView == nil ? .notAnAttribute : .width, multiplier: 1, constant: constant)
                
            case .top(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: toView, attribute: .top, multiplier: 1, constant: constant)
                
            case .bottom(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: relation.inverse(), toItem: toView, attribute: .bottom, multiplier: 1, constant: -constant)
                
            case .leading(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .leading, relatedBy: relation, toItem: toView, attribute: .leading, multiplier: 1, constant: constant)
                
            case .trailing(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: relation.inverse(), toItem: toView, attribute: .trailing, multiplier: 1, constant: -constant)
                
            case .before(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: relation.inverse(), toItem: toView, attribute: .leading, multiplier: 1, constant: -constant)
                
            case .above(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: relation.inverse(), toItem: toView, attribute: .top, multiplier: 1, constant: -constant)
                
            case .after(view: let toView, constant: let constant, relation: let relation):
                
                return NSLayoutConstraint(item: view, attribute: .leading, relatedBy: relation, toItem: toView, attribute: .trailing, multiplier: 1, constant: constant)
                
            case .below(view: let toView, constant: let constant, relation: let relation):
                return NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: toView, attribute: .bottom, multiplier: 1, constant: constant)
                
            case .centerX(view: let toView, constant: let constant):
                
                return NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1, constant: constant)
                
            case .centerY(view: let toView, constant: let constant):
                
                return NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1, constant: constant)
                
            case .aspectRatio:
                
                return view.widthAnchor.constraint(equalTo: view.heightAnchor)
            }
        }
    }
    

    //Use this method to equate constraints between any two attributes of two views
    ////Param - attibute - the attribute of main view
    ////Param - view - secondary view
    ////Param - toAttibute - the attribute of secondary view
    ////Param  - relation - the Layout constraint relation
    ////Param - constant - the height to be fixed
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func equateAttribute(_ attribute: NSLayoutConstraint.Attribute, toView view: UIView, toAttribute: NSLayoutConstraint.Attribute, withRelation relation: NSLayoutConstraint.Relation, _ constant: CGFloat = 0) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.equate(viewAttribute: attribute, toView: view, toViewAttribute: toAttribute, relation: relation, constant: constant)])
    }
    
    //Use this method to provide the height of the view
    ////Param - constant - the height to be fixed
    ////Param  - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func height(_ constant: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {

        return ConstraintCreator(constraints: [Constraint.height(view: nil, relation: relation, constant: constant)])
    }
    
    //Use this method to provide the width of the view
    ////Param - constant - the width to be fixed
    ////Param  - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func width(_ constant: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.width(view: nil, relation: relation, constant: constant)])
    }
    
    //Use this method to align top anchors of two views
    ////Param - view - the view to align top anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func top(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.top(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align bottom anchors of two views
    ////Param - view - the view to align bottom anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func bottom(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.bottom(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align leading anchors of two views
    ////Param - view - the view to align leading anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func leading(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.leading(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align trailing anchors of two views
    ////Param - view - the view to align trailing anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func trailing(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.trailing(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align the trailing and leading anchors of two views
    ////Param - view - the view to align trailing anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func before(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.before(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align the leading and trailing anchors of two views
    ////Param - view - the view to align leading anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func after(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.after(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align the bottom and top anchors of two views
    ////Param - view - the view to align bottom anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func above(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.above(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align the top and bottom anchors of two views
    ////Param - view - the view to align top anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Param - relation - the Layout constraint relation
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func below(_ view: UIView, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.below(view: view, constant: constant, relation: relation)])
    }
    
    //Use this method to align the centerX anchors of two views
    ////Param - view - the view to align center X anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func centerX(_ view: UIView, _ constant: CGFloat = 0) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.centerX(view: view, constant: constant)])
    }
    
    //Use this method to align the centerY anchors of two views
    ////Param - view - the view to align center Y anchor with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func centerY(_ view: UIView, _ constant: CGFloat = 0, _ priority: UILayoutPriority = .required, _ relation: NSLayoutConstraint.Relation = .equal) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.centerY(view: view, constant: constant)])
    }
    
    //Use this method to align the center anchors of two views
    ////Param - view - the view to align center anchors with
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func centerView(_ view: UIView) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.centerX(view).constraints + ConstraintCreator.centerY(view).constraints)
    }
    
    //Use this method to align the height and width anchors of a view
    ////Param - width - the constant to be applied while fixing width
    ////Param - height - the constant to be applied while fixing height
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func size(_ width: CGFloat, _ height: CGFloat) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.width(width).constraints +  ConstraintCreator.height(height).constraints)
    }
    
    //Use this method to align the height and width anchors of a view
    ////Param - size - the constant to be applied while fixing size
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func size(_ size: CGSize) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.width(size.width).constraints +  ConstraintCreator.height(size.height).constraints)
    }
    
    //Use this method to align the leading and trailing anchors of a view
    ////Param - view - the view to align leading and trailing anchors with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func sameLeadingTrailing(_ view: UIView, _ constant: CGFloat = 0) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.leading(view, constant).constraints +  ConstraintCreator.trailing(view, constant).constraints)
    }
    
    //Use this method to align the top and bottom anchors of a view
    ////Param - view - the view to align top and bottom anchors with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func sameTopBottom(_ view: UIView, _ constant: CGFloat = 0) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.top(view, constant).constraints +  ConstraintCreator.bottom(view, constant).constraints)
    }
    
    //Use this method to align the leading, trailing, top and bottom anchors of a view
    ////Param - view - the view to align all 4 anchors with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func setIn(_ view: UIView, _ top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) -> ConstraintCreator {
        var constraints: [Constraint] = []
        
        if let leftInset = left {
            constraints += ConstraintCreator.leading(view, leftInset).constraints
        }
        
        if let bottomInset = bottom {
            constraints += ConstraintCreator.bottom(view, bottomInset).constraints
        }
        
        if let rightInset = right {
            constraints += ConstraintCreator.trailing(view, rightInset).constraints
        }
        
        if let topInset = top {
            constraints += ConstraintCreator.top(view, topInset).constraints
        }
    
        return ConstraintCreator(constraints: constraints)
    }
    
    //Use this method to align the leading, trailing, top and bottom anchors of a view
    ////Param - view - the view to align all 4 anchors with
    ////Param - constant - the constant to be applied while aligning views
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func fillSuperView(_ view: UIView, _ constant: CGFloat = 0) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: ConstraintCreator.sameLeadingTrailing(view, constant).constraints +  ConstraintCreator.sameTopBottom(view, constant).constraints)
    }
    
    //Use this create a ratio between width and height of the view
    ////Param - value - the ratio provided, will be taken as positive
    ////Returns - ConstraintCreator Object with suitable constraints
    public static func aspectRatio(_ value: CGFloat) -> ConstraintCreator {
        
        return ConstraintCreator(constraints: [Constraint.aspectRatio(ratio: abs(value))])
    }
}

public extension UIView {
    
    //A struct containing all keys for Objective-C runtime association
    struct AssociatedKeys {
        static var leadingConstraint = "leadingConstraint"
        static var trailingConstraint = "trailingConstraint"
        static var topConstraint = "topConstraint"
        static var bottomConstraint = "bottomConstraint"
        static var heightConstraint = "heightConstraint"
        static var widthConstraint = "widthConstraint"
        static var centerXConstraint = "centerXConstraint"
        static var centerYConstraint = "centerYConstraint"
        static var aspectRatioConstraint = "aspectRatioConstraint"
    }
    
    
    private static let constraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    //The parameter for holding leading constraint on UIView
    private var leadingConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.leadingConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.leadingConstraint, newValue: newValue) }
    }
    
    //The parameter for holding trailing constraint on UIView
    private var trailingConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.trailingConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.trailingConstraint, newValue: newValue) }
    }
    
    //The parameter for holding top constraint on UIView
    private var topConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.topConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.topConstraint, newValue: newValue) }
    }
    
    //The parameter for holding bottom constraint on UIView
    private var bottomConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.bottomConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.bottomConstraint, newValue: newValue) }
    }
    
    //The parameter for holding height constraint on UIView
    private var heightConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.heightConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.heightConstraint, newValue: newValue) }
    }
    
    //The parameter for holding width constraint on UIView
    private var widthConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.widthConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.widthConstraint, newValue: newValue) }
    }
    
    //The parameter for holding centerX constraint on UIView
    private var centerXConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.centerXConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.centerXConstraint, newValue: newValue) }
    }
    
    //The parameter for holding centerY constraint on UIView
    private var centerYConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.centerYConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.centerYConstraint, newValue: newValue) }
    }
    
    //The parameter for holding aspect ratio constraint on UIView
    private var aspectRatioConstraint: NSLayoutConstraint? {
        get { return UIView.constraintAssociation.get(index: self, key: &AssociatedKeys.aspectRatioConstraint) }
        set { UIView.constraintAssociation.set(index: self, key: &AssociatedKeys.aspectRatioConstraint, newValue: newValue) }
    }
}


public extension UIView {
    
    //MARK:- Public APIs
    
    //This function is used to add constraints to a view, and this in turn calls
    //another private function of the same name.
    ////Param - An array of "ConstraintCreator" objects
    func set(_ constraints: ConstraintCreator...) {
        constraints.forEach { constraintCreator in
            let allConstraints = constraintCreator.constraints
            allConstraints.forEach { self.set($0) }
        }
    }
    
    //This function is used to get constraints of a view
    ////Param - A GetConstraint object
    ////Returns - An optional NSLayoutConstraint
    func get(_ constraint: ConstraintCreator.ConstraintType) -> NSLayoutConstraint? {
        switch constraint {
        case .top:
            return self.topConstraint
        case .bottom:
            return self.bottomConstraint
        case .leading:
            return self.leadingConstraint
        case .trailing:
            return self.trailingConstraint
        case .width:
            return self.widthConstraint
        case .height:
            return self.heightConstraint
        case .centerX:
            return self.centerXConstraint
        case .centerY:
            return self.centerYConstraint
        case .aspectRatio:
            return self.aspectRatioConstraint
        }
    }
    
}


fileprivate extension UIView {
    
    //MARK:- Private APIs
    
    //This function is used to add constraints to a view
    ////Param - A array of Constraint object
    private func set(_ constraint: ConstraintCreator.Constraint) {
        let nsLayoutConstraint = constraint.getConstraint(for: self)
        
        guard let view = nsLayoutConstraint.firstItem as? UIView else {
            assertionFailure("Constraint is not attached to a view. Please check")
            return
        }
        
        switch constraint {
        case .top:
            checkIfConstraintActiveAlready(self.topConstraint)
            self.topConstraint = nsLayoutConstraint
            break
            
        case .leading:
            checkIfConstraintActiveAlready(self.leadingConstraint)
            self.leadingConstraint = nsLayoutConstraint
            break
            
        case .height:
            checkIfConstraintActiveAlready(self.heightConstraint)
            self.heightConstraint = nsLayoutConstraint
            break
            
        case .width:
            checkIfConstraintActiveAlready(self.widthConstraint)
            self.widthConstraint = nsLayoutConstraint
            break
            
        case .bottom:
            checkIfConstraintActiveAlready(self.bottomConstraint)
            self.bottomConstraint = nsLayoutConstraint
            break
            
        case .trailing:
            checkIfConstraintActiveAlready(self.trailingConstraint)
            self.trailingConstraint = nsLayoutConstraint
            break
            
        case .before:
            checkIfConstraintActiveAlready(self.trailingConstraint)
            self.trailingConstraint = nsLayoutConstraint
            break
            
        case .above:
            checkIfConstraintActiveAlready(self.bottomConstraint)
            self.bottomConstraint = nsLayoutConstraint
            break
            
        case .after:
            checkIfConstraintActiveAlready(self.leadingConstraint)
            self.leadingConstraint = nsLayoutConstraint
            break
            
        case .below:
            checkIfConstraintActiveAlready(self.topConstraint)
            self.topConstraint = nsLayoutConstraint
            break
            
        case .centerX:
            checkIfConstraintActiveAlready(self.centerXConstraint)
            self.centerXConstraint = nsLayoutConstraint
            break
            
        case .centerY:
            checkIfConstraintActiveAlready(self.centerYConstraint)
            self.centerYConstraint = nsLayoutConstraint
            break
            
        case .aspectRatio:
            checkIfConstraintActiveAlready(self.aspectRatioConstraint)
            self.aspectRatioConstraint = nsLayoutConstraint
            break
            
        case .equate:
            checkIfConstraintActiveAlready(nsLayoutConstraint)
            break;
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if (validate(constraint: nsLayoutConstraint)) {
            nsLayoutConstraint.isActive = true
        }
    }
    
    //This function checks if the constraint is already active or if repeated constraints
    //are being applied. If that is the case, it deactivates the previous one, and always
    //honors the latest one.
    ////Param - constraint - a NSLayoutConstraint to be validated
    private func checkIfConstraintActiveAlready(_ constraint: NSLayoutConstraint?) {
        if let unwrappedConstraint = constraint, constraint?.isActive == true {
            unwrappedConstraint.isActive = false
        }
    }
    
    //This function validates the constraint before activating it
    ////Param - The NSLayoutConstraint to be validated
    ////Returns - Whether to activate the constraint or not.
    private func validate(constraint: NSLayoutConstraint) -> Bool {
        if Thread.isMainThread == false {
            assertionFailure("This API can only be used from the main thread")
        }
        
        guard let _ = constraint.firstItem as? UIView else {
            assertionFailure("Constraint is not attached to a view. Please check")
            return false
        }
        
        return true
    }
}

//Helper class for getting and setting Objective-C runtime properties on objects.
//In this case object -> UIView and properties -> NSLayoutConstraint
public final class ObjectAssociation<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }
    
    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public func get(index: AnyObject, key: inout String) -> T? {
        return objc_getAssociatedObject(index, &key) as! T?
    }
    
    public func set(index: AnyObject, key: inout String, newValue: T?) {
        objc_setAssociatedObject(index, &key, newValue, policy)
    }
}


