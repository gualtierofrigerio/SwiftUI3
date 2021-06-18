//
//  CanvasViewModel.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 18/06/21.
//

import Foundation
import SwiftUI

class CanvasViewModel: ObservableObject {
    @Published var shapes: [CustomShape] = []
    var size: CGSize = CGSize.zero
    
    func addPoint(_ point: CGPoint) {
        var shape = getCurrentShape()
        shape.addPoint(point)
        shapes.removeLast()
        shapes.append(shape)
    }
    
    func endPath() {
        newShape()
    }
    
    // MARK: - Private
        
    private func getCurrentShape() -> CustomShape {
        if let shape = shapes.last {
            return shape
        }
        return newShape()
    }
    
    @discardableResult private func newShape() -> CustomShape {
        let newShape = CustomShape()
        shapes.append(newShape)
        return newShape
    }
}
