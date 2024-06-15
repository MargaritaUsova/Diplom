//
//  ClusterListener.swift
//  Diplom
//
//  Created by Margarita Usova on 10.03.2024.
//

import Foundation
import YandexMapsMobile

final class ClusterListener: NSObject, YMKClusterListener, YMKClusterTapListener {
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func onClusterTap(with cluster: YMKCluster) -> Bool {
        if let placemarkUserData = cluster.placemarks.first?.userData as? PlacemarkUserData {
                print("Tapped on \(placemarkUserData.name)")
                return true
            }
            return false
    }

    func onClusterAdded(with cluster: YMKCluster) {
        let placemarks = cluster.placemarks.compactMap { $0.userData as? PlacemarkUserData }
        cluster.appearance.setViewWithView(YRTViewProvider(uiView: ClusterView(placemarks: placemarks)))
        cluster.addClusterTapListener(with: self)
        print("Cluster added")
    }


    private weak var controller: UIViewController?
    }

    struct PlacemarkUserData {
        let name: String
        let index: Int
        
    //    let type: PlacemarkType
    }
