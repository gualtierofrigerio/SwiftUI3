//
//  ListView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel = ListViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.beers) { beer in
                HStack {
                    CustomImageView(url: URL(string: beer.imageUrl),
                    placeHolder: Image(systemName: "xmark.octagon"))
                        .frame(width: 100, height: 100)
                    Text(beer.name)
                }
            }
            .refreshable {
                await viewModel.refreshBeers()
            }
            .searchable(text: $viewModel.filterString)
        }
        .task {
            await viewModel.refreshBeers()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
