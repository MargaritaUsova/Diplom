//
//  ClusterView.swift
//  Diplom
//
//  Created by Margarita Usova on 10.03.2024.
//

import Foundation
import YandexMapsMobile

final class ClusterView: UIView {
    init(placemarks: [PlacemarkUserData]) {
        self.placemarks = placemarks
        super.init(frame: .zero)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let placemarks: [PlacemarkUserData]
}
