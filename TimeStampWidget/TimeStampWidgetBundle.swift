//
//  TimeStampWidgetBundle.swift
//  TimeStampWidget
//
//  Created by Iori Suzuki on 2024/01/06.
//

import WidgetKit
import SwiftUI

@main
struct TimeStampWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimeStampWidget()
        TimeStampWidgetLiveActivity()
    }
}
