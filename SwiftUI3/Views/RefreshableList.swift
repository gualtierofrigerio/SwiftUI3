//
//  RefreshableList.swfit.swift
//  RefreshableList.swfit
//
//  Created by Gualtiero Frigerio on 26/07/21.
//

import SwiftUI

struct RefreshableList: View {
    var body: some View {
        RefreshableView(viewModel: viewModel)
        .refreshable {
            await viewModel.refreshBeers()
        }
    }
    
    private var viewModel = ListViewModel()
}

struct RefreshableView: View {
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.refresh) var refreshAction: RefreshAction?
    
    var body: some View {
        VStack {
            Button {
                if let action = refreshAction {
                    Task {
                        await action()
                    }
                }
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
            ScrollView {
                ForEach(viewModel.beers) { beer in
                    HStack {
                        CustomImageView(url: URL(string: beer.imageUrl),
                                        placeHolder: Image(systemName: "xmark.octagon"))
                            .frame(width: 100, height: 100)
                        Text(beer.name)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct RefreshableList_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableList()
    }
}
