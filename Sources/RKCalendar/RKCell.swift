//
//  RKCell.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKCell: View {
    
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            Text(rkDate.getText())
                .fontWeight(rkDate.getFontWeight())
                .foregroundColor(rkDate.getTextColor())
                .frame(width: cellWidth, height: cellWidth)
                .font(.system(size: 20))
                .background(rkDate.getBackgroundColor())
                .cornerRadius(cellWidth/2)
                .fixedSize(horizontal: false, vertical: true)
            
            Circle()
                .fill(rkDate.hasEvent ? rkDate.getEventFillColor() : Color.clear)
                .frame(width: 10)
                .padding(.top, 2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#if DEBUG
struct RKCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RKCell(rkDate:
                RKDate(date: Date(),
                       rkManager: RKManager(calendar: Calendar.current,
                                            minimumDate: Date(),
                                            maximumDate: Date().addingTimeInterval(60*60*24*365),
                                            mode: .single),
                       isDisabled: false,
                       isToday: false,
                       isSelected: false,
                       isBetweenStartAndEnd: false,
                       hasEvent: true),
                   cellWidth: CGFloat(32))
                .previewDisplayName("Control")
            
            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: .single), isDisabled: true, isToday: false, isSelected: false, isBetweenStartAndEnd: false, hasEvent: true), cellWidth: CGFloat(32))
                .previewDisplayName("Disabled Date")
            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: .single), isDisabled: false, isToday: true, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
                .previewDisplayName("Today")
            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: .single), isDisabled: false, isToday: false, isSelected: true, isBetweenStartAndEnd: false, hasEvent: true), cellWidth: CGFloat(32))
                .previewDisplayName("Selected Date")
            RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: .single), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: true), cellWidth: CGFloat(32))
                .previewDisplayName("Between Two Dates")
        }
        .previewLayout(.fixed(width: 300, height: 70))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif


