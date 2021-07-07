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
                }.padding()
                NavigationLink(destination: ListView()) {
                    Text("List View")
                }.padding()
                NavigationLink(destination: CanvasView(viewModel: CanvasViewModel())) {
                    Text("Canvas")
                }.padding()
                NavigationLink(destination: TimelineTestView()) {
                    Text("Timeline")
                }.padding()
                NavigationLink(destination: ClockView()) {
                    Text("Clock")
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
