//
//  ContentView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FocusView()) {
                    Text("Focus")
                }
                NavigationLink(destination: ListView()) {
                    Text("List View")
                }
                NavigationLink(destination: CanvasView(viewModel: CanvasViewModel())) {
                    Text("Canvas")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
