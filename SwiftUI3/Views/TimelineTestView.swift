//
//  TimelineTestView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 20/06/21.
//

import SwiftUI

struct TimelineTestView: View {
    var body: some View {
        TimelineView(.everyMinute) { context in
            Text(context.date.formatted())
        }
    }
}

struct TimelineTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTestView()
    }
}
