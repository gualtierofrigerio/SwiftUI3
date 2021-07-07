//
//  ClockView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 06/07/21.
//

import SwiftUI

struct ClockView: View {
    enum ClockHandType {
        case hour
        case minute
        case second
    }
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1.0)) { context in
            VStack {
                Text(context.date.formatted(date: .omitted, time: .standard))
                ZStack {
                    clockHands(date: context.date)
                }
            }
            .frame(width: 300, height: 300)
        }
    }
    
    @ViewBuilder
    private func clockHands(date: Date) -> some View {
        ClockHand(handScale: 0.5)
            .stroke(lineWidth: 5.0)
            .rotationEffect(angle(fromDate: date, type: .hour))
        ClockHand(handScale: 0.6)
            .stroke(lineWidth: 3.0)
            .rotationEffect(angle(fromDate: date, type: .minute))
        ClockHand(handScale: 0.8)
            .stroke(lineWidth: 1.0)
            .rotationEffect(angle(fromDate: date, type: .second))
    }
        
    private func angle(fromDate: Date, type: ClockHandType) -> Angle {
        var timeDegree = 0.0
        let calendar = Calendar.current
        
        switch type {
        case .hour:
            // we have 12 hours so we need to multiply by 5 to have a scale of 60
            timeDegree = CGFloat(calendar.component(.hour, from: fromDate)) * 5
        case .minute:
            timeDegree = CGFloat(calendar.component(.minute, from: fromDate))
        case .second:
            timeDegree = CGFloat(calendar.component(.second, from: fromDate))
        }
        return Angle(degrees: timeDegree * 360.0 / 60.0)
    }
}

struct ClockHand: Shape {
    var handScale: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rectLength = rect.width / 2
        let lineEnd = rectLength - (rectLength * handScale)
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + lineEnd))
        
        return path
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
