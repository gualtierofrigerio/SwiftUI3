//
//  CanvasView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject var viewModel: CanvasViewModel
    
    var body: some View {
        Canvas { context, size in
            viewModel.size = size
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            for shape in viewModel.shapes {
                context.stroke(shape.path(in: frame), with: .color(.primary), lineWidth: 5.0)
            }
        }
        .gesture(DragGesture(coordinateSpace:.local).onChanged( { value in
            addValue(value)
        })
        .onEnded( { value in
            endGesture()
        }))
        .frame(width: 300, height: 300)
        .background(Color.secondary)
    }
    
    private func addValue(_ value: DragGesture.Value) {
        let point = value.location
        let size = viewModel.size
        // we skip a point if x or y are negative
        // or if they are bigger than the width/height
        // so we don't draw points outside the view
        if point.y < 0 ||
            point.y > size.height ||
            point.x < 0 ||
            point.x > size.width {
            viewModel.endPath()
            return
        }
        viewModel.addPoint(value.location)
    }
    
    private func endGesture() {
        viewModel.endPath()
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(viewModel: CanvasViewModel())
    }
}
