//
//  UIView+Animation.swift
//  FxiaSpot - Extensions
//
//  UIView animation extensions
//

import UIKit

extension UIView {
    /// Fade in animation
    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { _ in
            completion?()
        }
    }

    /// Fade out animation
    func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { _ in
            completion?()
        }
    }

    /// Scale up animation
    func scaleUp(duration: TimeInterval = 0.3, scale: CGFloat = 1.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            completion?()
        }
    }

    /// Scale down animation
    func scaleDown(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = .identity
        }) { _ in
            completion?()
        }
    }

    /// Pop animation (scale up and down)
    func popAnimation(duration: TimeInterval = 0.15, scale: CGFloat = 1.15) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            }
        }
    }

    /// Shake animation
    func shakeAnimation(duration: TimeInterval = 0.5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        layer.add(animation, forKey: "shake")
    }

    /// Pulse animation (continuous)
    func pulseAnimation(duration: TimeInterval = 2.0, scale: CGFloat = 1.05) {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = 1.0
        pulse.toValue = scale
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        layer.add(pulse, forKey: "pulse")
    }

    /// Stop pulse animation
    func stopPulseAnimation() {
        layer.removeAnimation(forKey: "pulse")
    }

    /// Appear with spring animation
    func springAppear(delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(
            withDuration: 0.4,
            delay: delay,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.alpha = 1
                self.transform = .identity
            },
            completion: { _ in completion?() }
        )
    }

    /// Floating animation (continuous up and down)
    func floatingAnimation(duration: TimeInterval = 3.0, distance: CGFloat = 10) {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = duration
        animation.fromValue = -distance
        animation.toValue = distance
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(animation, forKey: "floating")
    }

    /// Stop floating animation
    func stopFloatingAnimation() {
        layer.removeAnimation(forKey: "floating")
    }

    /// Shimmer animation (light sweep effect)
    func shimmerAnimation(duration: TimeInterval = 2.0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor(white: 1.0, alpha: 0.3).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = duration
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")

        layer.addSublayer(gradientLayer)
    }

    /// Bounce animation (elastic bounce)
    func bounceAnimation(scale: CGFloat = 1.2) {
        let scaleUp = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleUp.values = [1.0, scale, 0.9, 1.05, 1.0]
        scaleUp.keyTimes = [0.0, 0.3, 0.5, 0.8, 1.0]
        scaleUp.duration = 0.5
        scaleUp.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(scaleUp, forKey: "bounce")
    }

    /// Rotate animation (360 degree rotation)
    func rotateAnimation(duration: TimeInterval = 1.0, repeatCount: Float = 1.0) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = duration
        rotation.repeatCount = repeatCount
        layer.add(rotation, forKey: "rotation")
    }
}
