//
//  ClusterListener.swift
//  Diplom
//
//  Created by Margarita Usova on 10.03.2024.
//

import Foundation
import YandexMapsMobile

final class ClusterListener: NSObject, YMKClusterListener, YMKClusterTapListener {
    func onClusterTap(with cluster: YMKCluster) -> Bool {
       print( "Tapped the cluster")
        return true
    }
    
// MARK: - Constructor

    init(controller: UIViewController) {
        self.controller = controller
    }

    // MARK: - Public methods


func onClusterAdded(with cluster: YMKCluster) {
    let placemarks = cluster.placemarks.compactMap { $0.userData as? PlacemarkUserData }
    cluster.appearance.setViewWithView(YRTViewProvider(uiView: ClusterView(placemarks: placemarks)))
    cluster.addClusterTapListener(with: self)
}

// MARK: - Private properties

private weak var controller: UIViewController?
}

struct PlacemarkUserData {
    let name: String
//    let type: PlacemarkType
}
