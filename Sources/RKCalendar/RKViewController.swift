//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

public struct RKViewController: View {
    
    var isPresented: Binding<Bool>
    var showHeader: Bool = true
    
    @ObservedObject var rkManager: RKManager
    
    public init (isPresented: Binding<Bool>, showHeader: Bool = true, rkManager: RKManager) {
        self.isPresented = isPresented
        self.showHeader = showHeader
        self.rkManager = rkManager
    }
    
    public var body: some View {
        Group {
            if showHeader {
                RKWeekdayHeader(rkManager: self.rkManager)
                Divider()
            }
            List {
                ForEach(0..<numberOfMonths(), id: \.self) { index in
                    LazyView(RKMonth(isPresented: self.isPresented, rkManager: self.rkManager, monthOffset: index))
                }
                Divider()
            }
        }
    }
    
    func numberOfMonths() -> Int {
        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return rkManager.calendar.date(from: components)!
    }
}

#if DEBUG
struct RKViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: .single))
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*32), mode: .single))
                .environment(\.colorScheme, .dark)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
#endif

