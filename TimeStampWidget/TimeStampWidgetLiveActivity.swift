//
//  TimeStampWidgetLiveActivity.swift
//  TimeStampWidget
//
//  Created by Iori Suzuki on 2024/01/06.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimeStampWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TimeStampWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeStampWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TimeStampWidgetAttributes {
    fileprivate static var preview: TimeStampWidgetAttributes {
        TimeStampWidgetAttributes(name: "World")
    }
}

extension TimeStampWidgetAttributes.ContentState {
    fileprivate static var smiley: TimeStampWidgetAttributes.ContentState {
        TimeStampWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TimeStampWidgetAttributes.ContentState {
         TimeStampWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TimeStampWidgetAttributes.preview) {
   TimeStampWidgetLiveActivity()
} contentStates: {
    TimeStampWidgetAttributes.ContentState.smiley
    TimeStampWidgetAttributes.ContentState.starEyes
}
