//
//  CustomShape.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 18/06/21.
//

import SwiftUI

struct CustomShape: Shape {
    var points: [CGPoint] = []
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if points.count == 0 {
            return path
        }

        path.move(to: points[0])
        for index in 1..<points.count {
            path.addLine(to: points[index])

        }
        return path
    }
    
    mutating func addPoint(_ point: CGPoint) {
        points.append(point)
    }
}

struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomShape(points: [])
    }
}
