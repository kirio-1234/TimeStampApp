//
//  TimeStampWidget.swift
//  TimeStampWidget
//
//  Created by Iori Suzuki on 2024/01/06.
//

import WidgetKit
import SwiftUI
import AppIntents
import SFUserFriendlySymbols

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context)  async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct TimeStampWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            TimeStampWidgetView()
        }
    }
}

struct TimeStampIntent: AppIntent {
    static var title: LocalizedStringResource = "Time Stamp"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

struct SuperCharge: AppIntent {
    
    static var title: LocalizedStringResource = "Emoji Ranger SuperCharger"
    static var description = IntentDescription("All heroes get instant 100% health.")
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

struct TimeStampWidgetView: View {
    var body: some View {
        Button(intent: SuperCharge()) {
            Image(symbol: .plus)
                .resizable()
                .scaledToFit()
                .padding()
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

struct TimeStampWidget: Widget {
    let kind: String = "TimeStampWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TimeStampWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    TimeStampWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
