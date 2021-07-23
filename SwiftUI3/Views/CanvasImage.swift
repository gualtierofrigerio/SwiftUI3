//
//  CanvasImage.swift
//  CanvasImage
//
//  Created by Gualtiero Frigerio on 22/07/21.
//

import SwiftUI

struct CanvasImage: View {
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1.0)) { timeContext in
            Canvas { context, size in
                let date = timeContext.date
                var currentPoint = CGPoint(x: 0, y: 0)
                var image = context.resolve(Image(systemName: "clock"))
                image.shading = .color(.green)
                
                for i in 0..<20 {
                    var innerContext = context
                    innerContext.opacity = 0.1 * Double(i)
                    currentPoint.x += 20
                    currentPoint.y = offsetFromDate(date: date)
                    innerContext.draw(image, at: currentPoint)
                }
            }
        }
    }
    
    private func offsetFromDate(date: Date) -> CGFloat {
        let seconds = CGFloat(Calendar.current.component(.second, from: date))
        return seconds * 10
    }
}

struct CanvasImage_Previews: PreviewProvider {
    static var previews: some View {
        CanvasImage()
    }
}
