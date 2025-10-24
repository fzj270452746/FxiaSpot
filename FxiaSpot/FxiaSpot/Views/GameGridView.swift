//
//  GameGridView.swift
//  FxiaSpot - Views
//
//  Game grid container view
//

import UIKit
import SnapKit

/// Game grid view delegate
protocol GameGridViewDelegate: AnyObject {
    func gameGridView(_ gridView: GameGridView, didTapTileAt index: Int)
}

/// Game grid view
final class GameGridView: UIView {
    // MARK: - Properties
    private var tileViews: [TileView] = []
    private let gridSize: Int
    private let spacing: CGFloat = 12  // 增加间距，更现代化

    weak var delegate: GameGridViewDelegate?

    // MARK: - Initialization
    init(gridSize: Int) {
        self.gridSize = gridSize
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
    }

    // MARK: - Configuration
    func configureTiles(_ tiles: [Tile]) {
        // Remove existing tiles
        tileViews.forEach { $0.removeFromSuperview() }
        tileViews.removeAll()

        // Calculate tile size
        let containerSize = bounds.width > 0 ? bounds.width : UIScreen.main.bounds.width - 60
        let tileSize = (containerSize - CGFloat(gridSize - 1) * spacing) / CGFloat(gridSize)

        // Create and layout tiles
        for (index, tile) in tiles.enumerated() {
            let row = index / gridSize
            let col = index % gridSize

            let tileView = TileView()
            tileView.configure(tile: tile) { [weak self] in
                self?.handleTileTap(at: index)
            }

            addSubview(tileView)
            tileView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat(col) * (tileSize + spacing))
                make.top.equalToSuperview().offset(CGFloat(row) * (tileSize + spacing))
                make.width.height.equalTo(tileSize)
            }

            tileViews.append(tileView)

            // Animate appearance
            let delay = Double(index) * 0.03
            tileView.springAppear(delay: delay)
        }
    }

    func updateTileState(at index: Int, state: TileViewState) {
        guard index < tileViews.count else { return }
        tileViews[index].setState(state)
    }

    // MARK: - Actions
    private func handleTileTap(at index: Int) {
        delegate?.gameGridView(self, didTapTileAt: index)
    }

    // MARK: - Helpers
    func calculateSize(containerWidth: CGFloat) -> CGFloat {
        let availableWidth = containerWidth - 60
        return min(availableWidth, UIScreen.main.bounds.height - 300)
    }
}
