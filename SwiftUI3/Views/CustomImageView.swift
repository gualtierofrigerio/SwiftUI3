//
//  CustomImaveView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 18/06/21.
//

import SwiftUI

struct CustomImageView: View {
    var url: URL?
    
    var body: some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                viewForPhase(phase)
            }
        }
        else {
            emptyImage
        }
    }
    
    @ViewBuilder
    private func viewForPhase(_ phase:AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            let _ = print("error \(error)")
            emptyImage
        @unknown default:
            let _ = print("unknown phase \(phase)")
            emptyImage
        }
    }
    
    private var emptyImage: some View {
        Image(systemName: "xmark.octagon")
            .font(.largeTitle)
    }
}

struct CustomImaveView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView()
    }
}
