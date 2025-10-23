//
//  NsoseloUmulambo.swift
//  FxiaSpot
//
//  Refactored with builder pattern and configuration objects
//

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
            ipupaPrimary: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
            ipupaSecondary: UIColor(red: 0.95, green: 0.85, blue: 0.65, alpha: 1.0),
            ipupaAccent: UIColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0),
            ipupaBackground: UIColor(red: 0.12, green: 0.15, blue: 0.18, alpha: 1.0),
            ipupaCard: UIColor(red: 0.18, green: 0.22, blue: 0.26, alpha: 1.0),
            ipupaCorrect: UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0),
            ipupaWrong: UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0),
            ipupaSelected: UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0),
            ipupaText: .white,
            ipupaTextSecondary: UIColor(white: 0.8, alpha: 1.0),
            ipupaGold: UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
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

    // Gradient generator
    func ipupaBulukaGradient(ubwalwa: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = ubwalwa
        gradient.colors = [
            UIColor(red: 0.12, green: 0.15, blue: 0.18, alpha: 1.0).cgColor,
            UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
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
}

// Extension for button styling
extension UIButton {
    func ipupaBikaStylePrimary() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        backgroundColor = nsoselo.ipupaTwalaLangiPrimary()
        setTitleColor(nsoselo.ipupaTwalaLangiText(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        layer.cornerRadius = 12
        nsoselo.ipupaBikaShadow(paBwino: self)
    }

    func ipupaBikaStyleSecondary() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        backgroundColor = nsoselo.ipupaTwalaLangiSecondary()
        setTitleColor(nsoselo.ipupaTwalaLangiPrimary(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontCikansambo(ubunene: 16)
        layer.cornerRadius = 10
        nsoselo.ipupaBikaShadow(paBwino: self, opacity: 0.2, radius: 5)
    }

    func ipupaBikaStyleIcibalo() {
        let nsoselo = NsoseloUmulamboMupangapo.ipupaShared
        backgroundColor = nsoselo.ipupaTwalaLangiCard()
        setTitleColor(nsoselo.ipupaTwalaLangiGold(), for: .normal)
        titleLabel?.font = nsoselo.ipupaBulukaFontMutwe(ubunene: 28)
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = nsoselo.ipupaTwalaLangiSecondary().cgColor
        nsoselo.ipupaBikaShadow(paBwino: self)
    }
}
