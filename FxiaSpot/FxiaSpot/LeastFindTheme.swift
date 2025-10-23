
import UIKit

struct LeastFindTheme {
    // Main Color Palette
    static let leastFindPrimaryColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0) // Red
    static let leastFindSecondaryColor = UIColor(red: 0.95, green: 0.85, blue: 0.65, alpha: 1.0) // Gold
    static let leastFindAccentColor = UIColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0) // Green
    static let leastFindBackgroundColor = UIColor(red: 0.12, green: 0.15, blue: 0.18, alpha: 1.0) // Dark blue-grey
    static let leastFindCardBackgroundColor = UIColor(red: 0.18, green: 0.22, blue: 0.26, alpha: 1.0) // Card bg

    // Game Colors
    static let leastFindCorrectColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0) // Bright green
    static let leastFindWrongColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0) // Bright red
    static let leastFindSelectedBorderColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0) // Gold

    // Text Colors
    static let leastFindPrimaryTextColor = UIColor.white
    static let leastFindSecondaryTextColor = UIColor(white: 0.8, alpha: 1.0)
    static let leastFindGoldTextColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)

    // Fonts
    static func leastFindTitleFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func leastFindBodyFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func leastFindButtonFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    // Shadow
    static func leastFindApplyShadow(to view: UIView, color: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 8, offset: CGSize = CGSize(width: 0, height: 4)) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }

    // Gradient Background
    static func leastFindCreateGradientLayer(bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 0.12, green: 0.15, blue: 0.18, alpha: 1.0).cgColor,
            UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }
}

// MARK: - Button Styles
extension UIButton {
    func leastFindApplyPrimaryStyle() {
        backgroundColor = LeastFindTheme.leastFindPrimaryColor
        setTitleColor(LeastFindTheme.leastFindPrimaryTextColor, for: .normal)
        titleLabel?.font = LeastFindTheme.leastFindButtonFont(size: 18)
        layer.cornerRadius = 12
        LeastFindTheme.leastFindApplyShadow(to: self)
    }

    func leastFindApplySecondaryStyle() {
        backgroundColor = LeastFindTheme.leastFindSecondaryColor
        setTitleColor(LeastFindTheme.leastFindPrimaryColor, for: .normal)
        titleLabel?.font = LeastFindTheme.leastFindButtonFont(size: 16)
        layer.cornerRadius = 10
        LeastFindTheme.leastFindApplyShadow(to: self, opacity: 0.2, radius: 5)
    }

    func leastFindApplyGameModeStyle() {
        backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        setTitleColor(LeastFindTheme.leastFindGoldTextColor, for: .normal)
        titleLabel?.font = LeastFindTheme.leastFindTitleFont(size: 28)
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = LeastFindTheme.leastFindSecondaryColor.cgColor
        LeastFindTheme.leastFindApplyShadow(to: self)
    }
}
