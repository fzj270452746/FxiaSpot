//
//  UIView+Decorations.swift
//  FxiaSpot - Extensions
//
//  Background decoration helpers
//

import UIKit

extension UIView {
    /// 添加装饰圆圈到视图
    func addDecorativeCircles() {
        let theme = NsoseloUmulamboMupangapo.ipupaShared

        // 大圆圈
        let circle1 = UIView()
        circle1.backgroundColor = theme.ipupaTwalaLangiSecondary().withAlphaComponent(0.08)
        circle1.layer.cornerRadius = 120
        addSubview(circle1)
        sendSubviewToBack(circle1)

        circle1.snp.makeConstraints { make in
            make.width.height.equalTo(240)
            make.top.equalToSuperview().offset(-80)
            make.right.equalToSuperview().offset(60)
        }

        // 中圆圈
        let circle2 = UIView()
        circle2.backgroundColor = theme.ipupaTwalaLangiAccent().withAlphaComponent(0.06)
        circle2.layer.cornerRadius = 80
        addSubview(circle2)
        sendSubviewToBack(circle2)

        circle2.snp.makeConstraints { make in
            make.width.height.equalTo(160)
            make.bottom.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(-40)
        }

        // 小圆圈
        let circle3 = UIView()
        circle3.backgroundColor = theme.ipupaTwalaLangiPrimary().withAlphaComponent(0.05)
        circle3.layer.cornerRadius = 50
        addSubview(circle3)
        sendSubviewToBack(circle3)

        circle3.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerY.equalToSuperview().offset(-100)
            make.left.equalToSuperview().offset(30)
        }
    }

    /// 创建卡片容器
    func createCardContainer(cornerRadius: CGFloat = 25, withBorder: Bool = true) -> UIView {
        let theme = NsoseloUmulamboMupangapo.ipupaShared
        let card = UIView()
        card.backgroundColor = theme.ipupaTwalaLangiCard()
        card.layer.cornerRadius = cornerRadius

        if withBorder {
            card.layer.borderWidth = 1.5
            card.layer.borderColor = UIColor(white: 1.0, alpha: 0.15).cgColor
        }

        theme.ipupaBikaShadow(paBwino: card, opacity: 0.3, radius: 15)
        return card
    }
}
