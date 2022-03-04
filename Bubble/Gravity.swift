//
//  Gravity.swift
//  Bubble
//
//  Created by Zhibek Rahymbekkyzy on 03.03.2022.
//

import UIKit
import CoreMotion

public class Gravity: NSObject {

    private var animator: UIDynamicAnimator!
    private var gravity: UIGravityBehavior!
    private var motion: CMMotionManager = CMMotionManager()
    private var queue: OperationQueue!

    private var dynamicItems: [UIDynamicItem]
    private var collisionItems: [UIDynamicItem]
    private var boundaryPath: UIBezierPath

    /// Initialize the components
    public init( gravityItems: [UIDynamicItem],
                 collisionItems: [UIDynamicItem]?,
                 referenceView: UIView,
                 boundary: UIBezierPath,
                 queue: OperationQueue? )
    {
        self.dynamicItems = gravityItems

        if let collisionItems = collisionItems {
            self.collisionItems = collisionItems
        } else {
            self.collisionItems = self.dynamicItems
        }

        self.boundaryPath = boundary
        
        if let queue = queue {
            self.queue = queue
        } else {
            self.queue = OperationQueue.current ?? OperationQueue.main
        }

        animator = UIDynamicAnimator(referenceView: referenceView)
        gravity = UIGravityBehavior(items: self.dynamicItems)
    }
    
    /// Enable motion and behaviors
    public func enable() {
        animator.addBehavior(collisionBehavior())
        animator.addBehavior(gravity)
        motion.startDeviceMotionUpdates(to: queue, withHandler: motionHandler)
    }

    /// Disable motion and behaviors
    public func disable() {
        animator.removeAllBehaviors()
        motion.stopDeviceMotionUpdates()
    }
    
    /// Restart motion and behaviors
    public func restart() {
        disable()
        enable()
    }

    private func collisionBehavior() -> UICollisionBehavior {
        let collision = UICollisionBehavior(items: self.collisionItems)
        collision.addBoundary(withIdentifier: "borders" as NSCopying, for: self.boundaryPath)
        return collision
    }

    private func motionHandler( motion: CMDeviceMotion?, error: Error? ) {
        guard let motion = motion else { return }

        let grav: CMAcceleration = motion.gravity
        let x = CGFloat(grav.x)
        let y = CGFloat(grav.y)
        var p = CGPoint(x: x, y: y)

        if let orientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation {
            if orientation == .landscapeLeft {
                let t = p.x
                p.x = 0 - p.y
                p.y = t
            } else if orientation == .landscapeRight {
                let t = p.x
                p.x = p.y
                p.y = 0 - t
            } else if orientation == .portraitUpsideDown {
                p.x *= -1
                p.y *= -1
            }
        }

        let v = CGVector(dx: p.x, dy: 0 - p.y)
        self.gravity.gravityDirection = v
    }

}

class BubbleView: UIView {

    var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        _shapeLayer.fillColor = UIColor.clear.cgColor
        _shapeLayer.allowsEdgeAntialiasing = true
        _shapeLayer.backgroundColor = UIColor.clear.cgColor
        return _shapeLayer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width / 2
        self.backgroundColor = .white

        layer.addSublayer(shapeLayer)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.path = circularPath(lineWidth: 0, center: center).cgPath
    }

    private func circularPath(lineWidth: CGFloat = 0, center: CGPoint = .zero) -> UIBezierPath {
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }

    override var collisionBoundingPath: UIBezierPath {
        return circularPath()
    }


}
