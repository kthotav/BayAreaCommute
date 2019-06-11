//
//  MapTableViewCell.swift
//  BayAreaCommute
//
//  Created by Karthik on 6/9/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import MapKit
import SnapKit
import UIKit

final class MapTableViewCell: UITableViewCell {

    struct LayoutConstants {

        // addressView
        static let addressViewHeight = 55
    }

    // MARK: - Views
    let mapView: MKMapView = MKMapView()
    lazy var visualEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .regular)
        effectView.effect = blurEffect
        return effectView
    }()
    lazy var addressView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.insertSubview(visualEffectView, at: 0)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MapTableViewCell: CustomViewProtocol {

    func setupView() {
        addSubview(mapView)
        addSubview(addressView)
    }

    func setupConstraints() {

        mapView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }

        addressView.snp.makeConstraints {
            $0.height.equalTo(LayoutConstants.addressViewHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        visualEffectView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
