
import UIKit

// Configuration struct for colors
struct IpupaLangiConfig {
    let ipupaPrimary: UIColor
    let ipupaSecondary: UIColor
    let ipupaAccent: UIColor
    let ipupaBackground: UIColor
    let ipupaCard: UIColor
    let ipupaCorrect: UIColor
    let ipupaWrong: UIColor
    let ipupaSelected: UIColor
    let ipupaText: UIColor
    let ipupaTextSecondary: UIColor
    let ipupaGold: UIColor

    static func ipupaBulukaDefault() -> IpupaLangiConfig {
        return IpupaLangiConfig(
            ipupaPrimary: UIColor(red: 1.0, green: 0.0, blue: 0.8, alpha: 1.0),           // 霓虹粉 #FF00CC
            ipupaSecondary: UIColor(red: 0.0, green: 0.85, blue: 1.0, alpha: 1.0),        // 电蓝色 #00D9FF
            ipupaAccent: UIColor(red: 0.0, green: 1.0, blue: 0.65, alpha: 1.0),           // 霓虹青 #00FFA6
            ipupaBackground: UIColor(red: 0.05, green: 0.0, blue: 0.15, alpha: 1.0),      // 深黑紫 #0D0026
            ipupaCard: UIColor(red: 0.15, green: 0.05, blue: 0.25, alpha: 0.6),           // 深紫半透明
            ipupaCorrect: UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),           // 霓虹绿 #00FF80
            ipupaWrong: UIColor(red: 1.0, green: 0.0, blue: 0.4, alpha: 1.0),             // 霓虹红 #FF0066
            ipupaSelected: UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0),          // 霓虹黄 #FFFF00
            ipupaText: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            ipupaTextSecondary: UIColor(red: 0.6, green: 0.9, blue: 1.0, alpha: 1.0),     // 浅蓝
            ipupaGold: UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)               // 霓虹金 #FFCC00
        )
    }
}

// Builder for theme configuration
class IpupaNsoseloBuilder {
    private var ipupaLangi: IpupaLangiConfig = .ipupaBulukaDefault()
    private var ipupaUbuneneFont: CGFloat = 1.0

    func nombaLangi(_ config: IpupaLangiConfig) -> IpupaNsoseloBuilder {
        self.ipupaLangi = config
        return self
    }

    func nombaUbuneneFont(_ ubunene: CGFloat) -> IpupaNsoseloBuilder {
        self.ipupaUbuneneFont = ubunene
        return self
    }

    func ipupaBuluka() -> NsoseloUmulamboMupangapo {
        return NsoseloUmulamboMupangapo(langi: ipupaLangi, ubuneneFont: ipupaUbuneneFont)
    }
}

// Main theme manager using singleton with builder
class NsoseloUmulamboMupangapo {
    static var ipupaShared: NsoseloUmulamboMupangapo = {
        IpupaNsoseloBuilder().ipupaBuluka()
    }()

    private let ipupaLangi: IpupaLangiConfig
    private let ipupaUbuneneFont: CGFloat

    init(langi: IpupaLangiConfig, ubuneneFont: CGFloat) {
        self.ipupaLangi = langi
        self.ipupaUbuneneFont = ubuneneFont
    }

    // Color accessors
    func ipupaTwalaLangiPrimary() -> UIColor { ipupaLangi.ipupaPrimary }
    func ipupaTwalaLangiSecondary() -> UIColor { ipupaLangi.ipupaSecondary }
    func ipupaTwalaLangiAccent() -> UIColor { ipupaLangi.ipupaAccent }
    func ipupaTwalaLangiBackground() -> UIColor { ipupaLangi.ipupaBackground }
    func ipupaTwalaLangiCard() -> UIColor { ipupaLangi.ipupaCard }
    func ipupaTwalaLangiCorrect() -> UIColor { ipupaLangi.ipupaCorrect }
    func ipupaTwalaLangiWrong() -> UIColor { ipupaLangi.ipupaWrong }
    func ipupaTwalaLangiSelected() -> UIColor { ipupaLangi.ipupaSelected }
    func ipupaTwalaLangiText() -> UIColor { ipupaLangi.ipupaText }
    func ipupaTwalaLangiTextSecondary() -> UIColor { ipupaLangi.ipupaTextSecondary }
    func ipupaTwalaLangiGold() -> UIColor { ipupaLangi.ipupaGold }

    // Font generators
    func ipupaBulukaFontMutwe(ubunene: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: ubunene * ipupaUbuneneFont, weight: .bold)
    }

    func ipupaBulukaFontUmubili(ubunene: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: ubunene * ipupaUbuneneFont, weight: .regular)
    }

    func ipupaBulukaFontCikansambo(ubunene: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: ubunene * ipupaUbuneneFont, weight: .semibold)
    }

    // Gradient generator - 霓虹赛博朋克渐变
    func ipupaBulukaGradient(ubwalwa: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = ubwalwa
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

    // Button gradient generator - 霓虹粉蓝渐变
    func ipupaBulukaButtonGradient(ubwalwa: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = ubwalwa
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

    // Shadow applier
    func ipupaBikaShadow(paBwino view: UIView, langi: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 8, offset: CGSize = CGSize(width: 0, height: 4)) {
        view.layer.shadowColor = langi.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }

    // Glow effect applier
    func ipupaBikaGlow(paBwino view: UIView, langi: UIColor, radius: CGFloat = 16, opacity: Float = 0.6) {
        view.layer.shadowColor = langi.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
    }
}

// Extension for button styling
extension UIButton {
    func ipupaBikaStylePrimary() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        setTitleColor(nsoselo.ipupaTwalaLangiText(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        layer.cornerRadius = 16

        // 使用渐变背景
        let gradientLayer = nsoselo.ipupaBulukaButtonGradient(ubwalwa: bounds)
        gradientLayer.cornerRadius = 16
        layer.insertSublayer(gradientLayer, at: 0)

        // 添加发光效果
        nsoselo.ipupaBikaGlow(paBwino: self, langi: nsoselo.ipupaTwalaLangiSecondary(), radius: 12, opacity: 0.5)
    }

    func ipupaBikaStyleSecondary() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        backgroundColor = nsoselo.ipupaTwalaLangiCard()
        setTitleColor(nsoselo.ipupaTwalaLangiText(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontCikansambo(ubunene: 16)
        layer.cornerRadius = 14
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(white: 1.0, alpha: 0.3).cgColor
        nsoselo.ipupaBikaShadow(paBwino: self, opacity: 0.3, radius: 8)
    }

    func ipupaBikaStyleIcibalo() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        backgroundColor = nsoselo.ipupaTwalaLangiCard()
        setTitleColor(nsoselo.ipupaTwalaLangiGold(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontMutwe(ubunene: 32)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = nsoselo.ipupaTwalaLangiSecondary().cgColor

        // 添加发光效果
        nsoselo.ipupaBikaGlow(paBwino: self, langi: nsoselo.ipupaTwalaLangiSecondary(), radius: 16, opacity: 0.4)
    }
}
