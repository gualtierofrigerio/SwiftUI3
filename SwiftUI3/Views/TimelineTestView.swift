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
            TimelineView(PeriodicTimelineSchedule(from: .now, by: 1.0)) { context in
                Text(context.date.formatted(date: .omitted, time: .standard))
            }
        }
    }
}

struct TimelineTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTestView()
    }
}
