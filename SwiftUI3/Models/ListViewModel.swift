//
//  ListViewModel.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var beers:[Beer] = []
    @Published var filterString: String = ""
    
    
    init() {
        restClient = RESTClient()
        let baseUrl = "https://api.punkapi.com/v2/"
        dataSource = DataSource(baseURLString: baseUrl, restClient: restClient)
        
        searchCancellable = $filterString
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { filter in
                self.filterBeers(filter: filter)
            }
    }
    
    func filterBeers(filter: String) {
        let filteredBeers: [Beer]
        if filter.count > 0 {
            filteredBeers = allBeers.filter({$0.name.lowercased().contains(filter.lowercased())})
        }
        else {
            filteredBeers = allBeers
        }
        self.beers = filteredBeers
    }
    
    func refreshBeers() async {
        if let beers = await dataSource.getBeers(page: 1) {
            self.beers = beers
            self.allBeers = beers
        }
    }
    
    // MARK: - Private

    private var allBeers: [Beer] = []
    private var dataSource: DataSource
    private var restClient: RESTClient
    private var searchCancellable: AnyCancellable?
}
