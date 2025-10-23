//
//  LeastFindTileView.swift
//  FxiaSpot
//
//  Created by Claude on 2025-01-23.
//

import UIKit
import SnapKit

enum LeastFindTileState {
    case leastFindNormal
    case leastFindSelected
    case leastFindCorrect
    case leastFindWrong
}

class LeastFindTileView: UIView {

    var leastFindTile: uansdKsjsMahjongTile?
    var leastFindState: LeastFindTileState = .leastFindNormal {
        didSet {
            leastFindUpdateAppearance()
        }
    }
    var leastFindOnTap: (() -> Void)?

    private let leastFindImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let leastFindBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.clear.cgColor
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        leastFindSetupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func leastFindSetupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        layer.cornerRadius = 8
        LeastFindTheme.leastFindApplyShadow(to: self, opacity: 0.2, radius: 4, offset: CGSize(width: 0, height: 2))

        addSubview(leastFindImageView)
        addSubview(leastFindBorderView)

        leastFindImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.85)
        }

        leastFindBorderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leastFindHandleTap))
        addGestureRecognizer(tapGesture)
    }

    func leastFindConfigure(with tile: uansdKsjsMahjongTile) {
        self.leastFindTile = tile
        leastFindImageView.image = UIImage(named: tile.leastFindImageName)
        leastFindState = .leastFindNormal
    }

    private func leastFindUpdateAppearance() {
        UIView.animate(withDuration: 0.2) {
            switch self.leastFindState {
            case .leastFindNormal:
                self.leastFindBorderView.layer.borderColor = UIColor.clear.cgColor
                self.transform = .identity

            case .leastFindSelected:
                self.leastFindBorderView.layer.borderColor = LeastFindTheme.leastFindSelectedBorderColor.cgColor
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

            case .leastFindCorrect:
                self.leastFindBorderView.layer.borderColor = LeastFindTheme.leastFindCorrectColor.cgColor
                self.transform = .identity

            case .leastFindWrong:
                self.leastFindBorderView.layer.borderColor = LeastFindTheme.leastFindWrongColor.cgColor
                self.transform = .identity
            }
        }

        if leastFindState == .leastFindWrong {
            leastFindShakeAnimation()
        } else if leastFindState == .leastFindCorrect {
            leastFindPopAnimation()
        }
    }

    @objc private func leastFindHandleTap() {
        leastFindOnTap?()
    }

    // MARK: - Animations
    private func leastFindShakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        layer.add(animation, forKey: "leastFindShake")
    }

    private func leastFindPopAnimation() {
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = .identity
            }
        }
    }

    func leastFindResetState() {
        leastFindState = .leastFindNormal
    }
}
