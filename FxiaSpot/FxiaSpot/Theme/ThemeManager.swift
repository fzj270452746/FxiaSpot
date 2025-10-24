//
//  ThemeManager.swift
//  FxiaSpot - Theme
//
//  Centralized theme management system
//

import UIKit

/// Color palette configuration
struct ColorPalette {
    let primary: UIColor
    let secondary: UIColor
    let accent: UIColor
    let background: UIColor
    let cardBackground: UIColor
    let correctColor: UIColor
    let wrongColor: UIColor
    let selectedColor: UIColor
    let textPrimary: UIColor
    let textSecondary: UIColor
    let goldColor: UIColor

    static let `default` = ColorPalette(
        primary: UIColor(red: 1.0, green: 0.0, blue: 0.8, alpha: 1.0),           // 霓虹粉 #FF00CC
        secondary: UIColor(red: 0.0, green: 0.85, blue: 1.0, alpha: 1.0),        // 电蓝色 #00D9FF
        accent: UIColor(red: 0.0, green: 1.0, blue: 0.65, alpha: 1.0),           // 霓虹青 #00FFA6
        background: UIColor(red: 0.05, green: 0.0, blue: 0.15, alpha: 1.0),      // 深黑紫 #0D0026
        cardBackground: UIColor(red: 0.15, green: 0.05, blue: 0.25, alpha: 0.6), // 深紫半透明
        correctColor: UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),      // 霓虹绿 #00FF80
        wrongColor: UIColor(red: 1.0, green: 0.0, blue: 0.4, alpha: 1.0),        // 霓虹红 #FF0066
        selectedColor: UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0),     // 霓虹黄 #FFFF00
        textPrimary: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        textSecondary: UIColor(red: 0.6, green: 0.9, blue: 1.0, alpha: 1.0),     // 浅蓝
        goldColor: UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)          // 霓虹金 #FFCC00
    )
}

/// Typography configuration
struct Typography {
    let fontSizeMultiplier: CGFloat

    init(fontSizeMultiplier: CGFloat = 1.0) {
        self.fontSizeMultiplier = fontSizeMultiplier
    }

    func titleFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size * fontSizeMultiplier, weight: .bold)
    }

    func bodyFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size * fontSizeMultiplier, weight: .regular)
    }

    func buttonFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size * fontSizeMultiplier, weight: .semibold)
    }
}

/// Theme manager singleton
final class ThemeManager {
    static let shared = ThemeManager()

    private(set) var colorPalette: ColorPalette
    private(set) var typography: Typography

    private init() {
        self.colorPalette = .default
        self.typography = Typography()
    }

    // MARK: - Configuration
    func configure(colorPalette: ColorPalette? = nil, typography: Typography? = nil) {
        if let palette = colorPalette {
            self.colorPalette = palette
        }
        if let typo = typography {
            self.typography = typo
        }
    }

    // MARK: - Color Accessors
    var primaryColor: UIColor { colorPalette.primary }
    var secondaryColor: UIColor { colorPalette.secondary }
    var accentColor: UIColor { colorPalette.accent }
    var backgroundColor: UIColor { colorPalette.background }
    var cardBackgroundColor: UIColor { colorPalette.cardBackground }
    var correctColor: UIColor { colorPalette.correctColor }
    var wrongColor: UIColor { colorPalette.wrongColor }
    var selectedColor: UIColor { colorPalette.selectedColor }
    var textPrimaryColor: UIColor { colorPalette.textPrimary }
    var textSecondaryColor: UIColor { colorPalette.textSecondary }
    var goldColor: UIColor { colorPalette.goldColor }

    // MARK: - Gradient Generator - 霓虹赛博朋克渐变
    func createGradientLayer(frame: CGRect = .zero) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        // 深黑 → 深紫 → 深蓝紫 → 深粉紫
        gradient.colors = [
            UIColor(red: 0.0, green: 0.0, blue: 0.05, alpha: 1.0).cgColor,    // 深黑 #000008
            UIColor(red: 0.1, green: 0.0, blue: 0.2, alpha: 1.0).cgColor,     // 深紫 #1A0033
            UIColor(red: 0.15, green: 0.0, blue: 0.3, alpha: 1.0).cgColor,    // 蓝紫 #26004D
            UIColor(red: 0.2, green: 0.0, blue: 0.35, alpha: 1.0).cgColor     // 粉紫 #330059
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = [0.0, 0.3, 0.7, 1.0]
        return gradient
    }

    // MARK: - Button Gradient Generator - 霓虹粉蓝渐变
    func createButtonGradientLayer(frame: CGRect = .zero) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        // 霓虹粉 → 霓虹紫 → 电蓝
        gradient.colors = [
            UIColor(red: 1.0, green: 0.0, blue: 0.8, alpha: 1.0).cgColor,     // 霓虹粉 #FF00CC
            UIColor(red: 0.6, green: 0.0, blue: 1.0, alpha: 1.0).cgColor,     // 霓虹紫 #9900FF
            UIColor(red: 0.0, green: 0.85, blue: 1.0, alpha: 1.0).cgColor     // 电蓝 #00D9FF
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0, 0.5, 1.0]
        return gradient
    }

    // MARK: - Shadow Helper
    func applyShadow(
        to view: UIView,
        color: UIColor = .black,
        opacity: Float = 0.3,
        radius: CGFloat = 8,
        offset: CGSize = CGSize(width: 0, height: 4)
    ) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }

    // MARK: - Glow Effect Helper
    func applyGlow(
        to view: UIView,
        color: UIColor,
        radius: CGFloat = 16,
        opacity: Float = 0.6
    ) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
    }

    // MARK: - Frosted Glass Effect
    func applyFrostedGlass(to view: UIView, cornerRadius: CGFloat = 20) {
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor

        // 添加模糊效果
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true
        view.insertSubview(blurView, at: 0)
    }
}
