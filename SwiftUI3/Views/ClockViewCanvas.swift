//
//  ClockViewCanvas.swift
//  ClockViewCanvas
//
//  Created by Gualtiero Frigerio on 22/07/21.
//

import SwiftUI

struct ClockViewCanvas: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { timeContext in 
            Canvas { context, size in
                let date = timeContext.date
                let textTime = Text(date.formatted(date: .omitted, time: .standard))
                context.draw(textTime, at: CGPoint(x: size.width / 2, y: 10))
                             
                let clockFrame = CGRect(x: 0,
                                        y: 0,
                                        width: 100,
                                        height: 100)
                
                var clockContext = context
                clockContext.translateBy(x: (size.width / 2) - 50, y: (size.height / 2) - 50)
                
                addLabels(toContext: clockContext, frame: clockFrame)
                
                drawClockHands(inContext: clockContext, frame: clockFrame, date: date)                
            }
        }
    }
    
    private func addLabels(toContext context: GraphicsContext, frame: CGRect) {
        // I use CGContext here just to demostrate we can use a CGConxtex inside a GraphicsContext
        context.withCGContext { cgContext in
            let rect = CGRect(x: -frame.size.width / 2,
                              y: -frame.size.width / 2,
                              width: frame.size.width * 2,
                              height: frame.size.height * 2)
            cgContext.setStrokeColor(CGColor(red: 255, green: 0, blue: 0, alpha: 1.0))
            cgContext.setFillColor(CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
            cgContext.setLineWidth(2.0)
            cgContext.addEllipse(in: rect)
            cgContext.drawPath(using: .fillStroke)
        }
        
        let innerFrame = getRect(fromRect: frame, ratio: 0.9)
        let radius = innerFrame.size.width
        let midX = innerFrame.size.width / 2 + (innerFrame.origin.x / 2)
        let midY = innerFrame.size.height / 2 + (innerFrame.origin.y / 2)
        let labels = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        for index in 0..<labels.count {
            let angle = CGFloat(index) * CGFloat.pi * 2 / 12 - (CGFloat.pi / 2)
            let x = round(cos(angle) * radius) + midX
            let y = round(sin(angle) * radius) + midY
            let text = Text("\(labels[index])")
            context.draw(text, at: CGPoint(x: x, y: y))
        }
    }
    
    private func createPath(fromDate: Date, type: ClockHandType, frame: CGRect) -> Path {
        var timeDegree = 0.0
        var widthScale = 1.0
        let midX = frame.size.width / 2 + (frame.origin.x / 2)
        let midY = frame.size.height / 2 + (frame.origin.y / 2)
        
        let radius = frame.size.width
        
        let (degree, scale) = getDegreeAndScale(fromDate: fromDate, type: type)
        timeDegree = degree
        widthScale = scale
        
        timeDegree =  -timeDegree * CGFloat.pi * 2 / 60 - (CGFloat.pi)
        
        let startPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let endX = (widthScale * radius) * sin(timeDegree) + midX
        let endY = (widthScale * radius) * cos(timeDegree) + midY
        let endPoint = CGPoint(x: endX, y: endY)
        
        var path = Path()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    private func drawClockHands(inContext context: GraphicsContext, frame: CGRect, date: Date) {
        let hourPath = createPath(fromDate: date, type: .hour, frame: frame)
        context.stroke(hourPath, with: .color(Color.blue), lineWidth: 3.0)
        
        let minutePath = createPath(fromDate: date, type: .minute, frame: frame)
        context.stroke(minutePath, with: .color(Color.blue), lineWidth: 2.0)
        
        let secondPath = createPath(fromDate: date, type: .second, frame: frame)
        context.stroke(secondPath, with: .color(Color.red), lineWidth: 1.0)
    }
    
    private func getRect(fromRect rect: CGRect, ratio: CGFloat) -> CGRect {
        var newRect = rect
        newRect.size.width = newRect.size.width * ratio
        newRect.size.height = newRect.size.height * ratio
        newRect.origin.x = rect.size.width - newRect.size.width
        newRect.origin.y = rect.size.height - newRect.size.height
        return newRect
    }
    
    private func getDegreeAndScale(fromDate: Date, type: ClockHandType) -> (CGFloat, CGFloat) {
        let calendar = Calendar.current
        var timeDegree = 0.0
        var widthScale = 1.0
        
        switch type {
        case .hour:
            // we have 12 hours so we need to multiply by 5 to have a scale of 60
            timeDegree = CGFloat(calendar.component(.hour, from: fromDate)) * 5
            widthScale = 0.4
        case .minute:
            timeDegree = CGFloat(calendar.component(.minute, from: fromDate))
            widthScale = 0.6
        case .second:
            timeDegree = CGFloat(calendar.component(.second, from: fromDate))
            widthScale = 0.8
        }
        
        return (timeDegree, widthScale)
    }
}

struct ClockViewCanvas_Previews: PreviewProvider {
    static var previews: some View {
        ClockViewCanvas()
    }
}
