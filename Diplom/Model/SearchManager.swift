//
//  SearchManager.swift
//  Diplom
//
//  Created by Margarita Usova on 31.03.2024.
//

import Foundation
import Combine
import YandexMapsMobile

class SearchManager{

    
    static let shared = SearchManager()
    private var searchSession: YMKSearchSession?
    private var searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
    
    private let searchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        options.snippets = YMKSearchSnippet.photos
        options.resultPageSize = 20
        return options
    }()
    
    private let searchViewController = SearchViewController()
//    private let searchResultsViewController = SearchResultsViewController()
        
    private var averageBill = ""
    var placesResult: [Place] = []
    private var cost: String?
    private var searchWithFilters: Bool!
    private var mapController: MapController!
    @Published var mapState: MapState!
    @Published private var searchState = SearchState.idle
    @Published private var visibleRegion: YMKVisibleRegion?
    @Published private var visibleRegionAfterDebounce: YMKVisibleRegion?
    @Published private var searchText = String()
    private var subscriptions: Set<AnyCancellable> = []
    
    func setVisibleRegion(region: YMKVisibleRegion){
        visibleRegion = region
        
    }
    
    func setSearchText(){
        searchText = SearchViewController.queryText
    }
    
    func setupSubscriptions(){
        setupVisiblleRegionSubscription()
        setupSearchSubscription()
        setupMapStateSubscruption()
    }
    
    private func setupVisiblleRegionSubscription(){
        $visibleRegion
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .assign(to: \.visibleRegionAfterDebounce, on: self)
            .store(in: &subscriptions)
    }
    
    private func setupSearchSubscription() {
        $visibleRegionAfterDebounce
            .filter { [weak self] _ in
                if case .success = self?.searchState {
                    return true
                } else {
                    return false
                }
            }
            .compactMap { $0 }
            .sink { [weak self] visible in
                guard let self = self,
                let visible = visible as? YMKVisibleRegion else {
                    return
                }
                
                self.searchSession?.setSearchAreaWithArea(YMKVisibleRegionUtils.toPolygon(with: visible))
                self.searchSession?.resubmit(responseHandler: self.handleSearchSessionResponse)
                self.searchState = .loading
            }
            .store(in: &subscriptions)
    }
    
    private func setupMapStateSubscruption(){
        Publishers
            .CombineLatest (
                $searchText,
                $searchState
            )
            .map { searchText, searchState in
                MapState(searchText: searchText, searchState: searchState)
            }
            .assign(to: \.mapState, on: self)
            .store(in: &subscriptions)
        
    }
    
    func search(with text: String?){
        if let text = text,
           let visibleRegion = visibleRegion{
            searchByQuery(with: text, visibleRegion: visibleRegion)
            searchText = text
        }
        else{
            return
        }
    }
    
    func searchWithPolygon(text: String?, region: YMKPolygon){
        if let text = text{
            searchForPrediction(text: text, visibleRegion: region)
            searchText = text
        }
        else{
            return
        }
    }
    
    func searchForPrediction(text: String, visibleRegion: YMKPolygon){
        searchWithFilters = false
        searchSession?.cancel()
            searchSession = searchManager.submit(
                withText: "where to eat",
                geometry:  YMKGeometry(polygon: visibleRegion),
                searchOptions: searchOptions,
                responseHandler: handleSearchSessionResponse
            )
        
    }
    
    func searchByUri(uri: String) {
        searchWithFilters = false
        searchSession?.cancel()
        searchSession = searchManager.searchByURI(
            withUri: uri,
            searchOptions: YMKSearchOptions(),
            responseHandler: handleSearchSessionResponse
        )
//        searchState = .loading
       
    }
    
    func searchByQuery(with text: String, visibleRegion: YMKVisibleRegion){
        searchWithFilters = false
        searchSession?.cancel()
        searchSession = searchManager.submit(
            withText: text,
            geometry: YMKVisibleRegionUtils.toPolygon(with: visibleRegion),
            searchOptions: searchOptions,
            responseHandler: handleSearchSessionResponse
        )
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error = error {
            print("Ошибка запроса при поиске: ", error)
            return
        }
        
        guard let response = response,
              let boundingBox = response.metadata.boundingBox else {
            return
        }
        
        let items = response.collection.children.compactMap {
            if let point = $0.obj?.geometry.first?.point {
                return SearchResponseItem(point: point, geoObject: $0.obj)
            }
            return nil
        }
        searchState = SearchState.success(
            items: items,
            zoomToItems: false,
            itemsBoundingBox: boundingBox
        )
        makePlaceInfo(items)
    }
    
    func makePlaceInfo(_ items: [SearchResponseItem]) -> [Place]{
        var places: [Place] = []
        
        for item in items {
            let metadata = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessObjectMetadata.self) as! YMKSearchBusinessObjectMetadata
            let uris = item.geoObject?.metadataContainer.getItemOf(YMKUriObjectMetadata.self) as! YMKUriObjectMetadata
            let metadataPhoto = item.geoObject?.metadataContainer.getItemOf(YMKSearchBusinessPhotoObjectMetadata.self) as? YMKSearchBusinessPhotoObjectMetadata
            var photos: [String?] = []
            if let photosMetadata = metadataPhoto?.photos {
                for photoMetadata in photosMetadata {
                    var photoData = String(photoMetadata.id.dropLast(2))
                    photoData += "XL"
                    photos.append(photoData)
                }
            }
            
            let categoryNames = metadata.categories.map { $0.name }
            if let matchingCategory = categoryNames.first(where: {AcceptablePlaceCategories.placeCategories.contains($0)}){
                for (names, values) in zip(metadata.features, metadata.features.map {$0.value.textValue}) {
                    if let name = names.name, name.contains("средний счёт"), let value = values {
                        cost = value.joined()
                        if let cost = cost{
                            averageBill = "Средний счёт \(cost)"
                        }
                    }
                }
                
                let features = getFeatures(from: metadata.features)
                let place = Place(point: item.point,
                                  geoObject: item.geoObject,
                                  name: item.geoObject!.name!,
                                  category: categoryNames,
                                  address: metadata.address.formattedAddress,
                                  id: metadata.oid,
                                  phoneNumbers: metadata.phones.map {$0.formattedNumber},
                                  features: features,
                                  links: metadata.links.map {$0.link.href},
                                  averageBill: averageBill,
                                  workingHours: metadata.workingHours?.text,
                                  photos: photos,
                                  uri: uris.uris.first?.value)
                
                if searchWithFilters && applyFeatures(features) {
                    places.append(place)
                } else if !searchWithFilters {
                    places.append(place)
                }
                
            }
        }
        
        SearchResultsViewController.placesData = places
        
        return places
    }
    
    private func applyFeatures(_ features: [String : Any]) -> Bool{
        for (featureKey, featureValue) in features {
            if let selectedFeatureValue = SearchFiltersViewController.placesTypesEnumFilters[featureKey],
                let featureValue = featureValue as? [String]{
                if featureValue.contains(selectedFeatureValue){
                    return true
                }
                
            }
        }
        return false
    }

    private func getFeatures(from features: [YMKSearchFeature]) -> [String: Any]{
        var result: [String: Any] = [:]
        for data in features{
            var value: Any? = nil
            if let textValue = data.value.textValue{
                value = textValue
            }
            else if let booleanValue = data.value.booleanValue?.value{
                value = booleanValue
//                print(data.name, data.value.booleanValue?.value)
                
            }
            else if let enumValue = data.value.enumValue.map({$0.map{$0.name}}){
                value = enumValue
//                print(data.name)
            }
//            if let value = value as? [String],
               if let name = data.name{
//                   if let value = value as? [String]{
//                       print(name)
                       result[name] = value
                       
//                   print(name)
//                if name == "особенности заведения" {
//                    value.forEach{ item in
//                        if let cuisineType = item as? String {
//                            SearchFiltersViewController.placesFeatures.insert(item)
//                        }
//                    }
//                }
            }
        }
//        print(SearchFiltersViewController.placesFeatures)
        
            return result
        }
    
}

struct MapState{
    let searchText: String
    let searchState: SearchState

    init(searchText: String = String(), searchState: SearchState) {
        self.searchText = searchText
        self.searchState = searchState
    }
}

enum SearchState{
    case idle
    case loading
    case error
    case success(items: [SearchResponseItem], zoomToItems: Bool, itemsBoundingBox: YMKBoundingBox)
}
