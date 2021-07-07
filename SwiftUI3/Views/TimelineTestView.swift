//
//  TimelineTestView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 20/06/21.
//

import SwiftUI

struct TimelineTestView: View {
    var body: some View {
        VStack {
            TimelineView(.everyMinute) { context in
                Text(context.date.formatted())
            }.padding()
            TimelineView(.periodic(from: .now, by: 1.0)) { context in
                Text(context.date.formatted(date: .omitted, time: .standard))
            }.padding()
            TimelineView(ExplicitTimelineSchedule(getDates())) { context in
                Text(context.date.formatted(date: .omitted, time: .standard))
            }
        }
    }
    
    private func getDates() -> [Date] {
        let date = Date()
        return [date,
                date.addingTimeInterval(2.0),
                date.addingTimeInterval(4.0),
                date.addingTimeInterval(6.0)]
    }
}

struct TimelineTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTestView()
    }
}
