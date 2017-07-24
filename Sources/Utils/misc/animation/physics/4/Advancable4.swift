import Foundation

protocol Advancable4 {
    //typealias InitValues = (value:Self,targetValue:Self,velocity:Self,stopVelocity:Self)
    
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    
    static var defaultEpsilon: Self { get }
    static var defaultConfig: Self { get }
    static var initValues:(value:Self,targetValue:Self,velocity:Self,stopVelocity:Self) {get}
    func isNear( value: Self, epsilon: Self) -> Bool
    //static func updatePosition(velocity:argType,value:argType,targetValue:argType,easing:argType) -> (value:argType,velocity:argType)
    //static func assertStop(velocity:argType,stopVelocity:argType) -> Bool
}

extension CGFloat: Advancable4 {
    static var initValues: (value: CGFloat, targetValue: CGFloat, velocity: CGFloat, stopVelocity: CGFloat) = (value:0,targetValue:0,velocity:0,stopVelocity:0)/*Convenient*/

    static let defaultEpsilon: CGFloat = 10e-5
    static let defaultConfig:CGFloat = (0.2)/*Convenient*/
    
    
    func isNear( value:  CGFloat,  epsilon: CGFloat) -> Bool {
        return self.isNear(value,epsilon)
    }
}
extension CGPoint: Advancable4 {
    static var initValues: (value: CGPoint, targetValue: CGPoint, velocity: CGPoint, stopVelocity: CGPoint) = (value:CGPoint(0,0),targetValue:CGPoint(0,0),velocity:CGPoint(0,0),stopVelocity:CGPoint(0,0))/*Convenient*/
    static var defaultConfig: CGPoint = CGPoint(0.2,0.2)
    static var defaultEpsilon: CGPoint = CGPoint(10e-5,10e-5)
    //static let defaultEpsilon: CGPoint = CGPoint(10e-5,10e-5)
    func isNear( value:  CGPoint,  epsilon: CGPoint) -> Bool {
        return self.isNear(value,epsilon.x)
    }
}