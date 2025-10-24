//
//  TileView.swift
//  FxiaSpot - Views
//
//  Individual tile view component
//

import UIKit
import SnapKit

/// Tile view state for visual representation
enum TileViewState {
    case normal
    case selected
    case correct
    case wrong

    func borderColor(theme: ThemeManager) -> UIColor {
        switch self {
        case .normal: return .clear
        case .selected: return theme.selectedColor
        case .correct: return theme.correctColor
        case .wrong: return theme.wrongColor
        }
    }
}

/// Tile view component
final class TileView: UIView {
    // MARK: - Properties
    private var tile: Tile?
    private var tapHandler: (() -> Void)?

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.clear.cgColor
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: - Setup
    private func setupView() {
        let theme = ThemeManager.shared

        // 新的现代化样式：半透明白色背景
        backgroundColor = UIColor(white: 0.98, alpha: 0.9)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 1.0, alpha: 0.4).cgColor

        // 更柔和的阴影
        theme.applyShadow(to: self, opacity: 0.25, radius: 6, offset: CGSize(width: 0, height: 3))

        addSubview(imageView)
        addSubview(borderView)

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.85)
        }

        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    // MARK: - Configuration
    func configure(tile: Tile, tapHandler: @escaping () -> Void) {
        self.tile = tile
        self.tapHandler = tapHandler
        imageView.image = UIImage(named: tile.imageName())
        setState(.normal)
    }

    func setState(_ state: TileViewState) {
        let theme = ThemeManager.shared
        let borderColor = state.borderColor(theme: theme)

        UIView.animate(withDuration: 0.2) {
            self.borderView.layer.borderColor = borderColor.cgColor

            switch state {
            case .normal:
                self.transform = .identity
            case .selected:
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            case .correct, .wrong:
                self.transform = .identity
            }
        }

        // Apply specific animations
        switch state {
        case .correct:
            popAnimation()
        case .wrong:
            shakeAnimation()
        default:
            break
        }
    }

    // MARK: - Actions
    @objc private func handleTap() {
        tapHandler?()
    }
}
