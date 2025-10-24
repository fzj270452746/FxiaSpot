//
//  UIButton+Style.swift
//  FxiaSpot - Extensions
//
//  UIButton styling extensions - Neon Cyberpunk Theme
//

import UIKit

extension UIButton {
    /// Apply primary button style with neon gradient
    func applyPrimaryStyle() {
        let theme = ThemeManager.shared

        setTitleColor(theme.textPrimaryColor, for: .normal)
        titleLabel?.font = theme.typography.buttonFont(size: 18)
        layer.cornerRadius = 16

        // 清除旧的渐变层
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        // 添加霓虹渐变背景
        let gradientLayer = theme.createButtonGradientLayer(frame: bounds)
        gradientLayer.cornerRadius = 16
        layer.insertSublayer(gradientLayer, at: 0)

        // 添加霓虹发光效果
        theme.applyGlow(to: self, color: theme.secondaryColor, radius: 16, opacity: 0.7)
    }

    /// Apply secondary button style with dark glass
    func applySecondaryStyle() {
        let theme = ThemeManager.shared

        backgroundColor = theme.cardBackgroundColor
        setTitleColor(theme.textPrimaryColor, for: .normal)
        titleLabel?.font = theme.typography.buttonFont(size: 16)
        layer.cornerRadius = 14
        layer.borderWidth = 2
        layer.borderColor = theme.secondaryColor.withAlphaComponent(0.4).cgColor

        theme.applyShadow(to: self, opacity: 0.4, radius: 10)
    }

    /// Apply mode selection button style with intense neon glow
    func applyModeSelectionStyle() {
        let theme = ThemeManager.shared

        backgroundColor = theme.cardBackgroundColor
        setTitleColor(theme.goldColor, for: .normal)
        titleLabel?.font = theme.typography.titleFont(size: 32)
        layer.cornerRadius = 20
        layer.borderWidth = 3
        layer.borderColor = theme.secondaryColor.cgColor

        // 添加强烈霓虹发光效果
        theme.applyGlow(to: self, color: theme.secondaryColor, radius: 20, opacity: 0.6)
    }

    /// Animate button tap with neon pulse
    func animateTap(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .identity
            }) { _ in
                completion?()
            }
        }
    }
}
