//
//  ContentView.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//


import SwiftUI

struct ContentView : View {
    
    static let YEAR: TimeInterval = 60*60*24*365
    static let DAY: TimeInterval = 60*60*24
    
    @State var singleIsPresented = false
    @State var startIsPresented = false
    @State var multipleIsPresented = false
    @State var deselectedIsPresented = false
    
    var rkManager1 = RKManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Date().addingTimeInterval(YEAR),
        eventDates: [Date().addingTimeInterval(DAY)],
        mode: .single)
    
    var rkManager2 = RKManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Date().addingTimeInterval(YEAR),
        mode: .range) // automatically goes to mode=2 after start selection, and vice versa.
    
    var rkManager3 = RKManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Date().addingTimeInterval(YEAR),
        mode: .multiple)
    
    var rkManager4 = RKManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Date().addingTimeInterval(YEAR),
        mode: .single)
    
    
    var body: some View {
        VStack (spacing: 25) {
            
            Group {
                Button(action: { self.singleIsPresented.toggle() }) {
                    Text("Example 1 - Single Date Selection").foregroundColor(.blue)
                }
                .sheet(isPresented: self.$singleIsPresented, content: {
                    RKViewController(isPresented: self.$singleIsPresented,
                                     rkManager: self.rkManager1)})
                Text(self.getTextFromDate(date: self.rkManager1.selectedDate))
            }
            
            Group {
                Button(action: { self.startIsPresented.toggle() }) {
                    VStack {
                        Text("Example 2 - Range of Dates Selection").foregroundColor(.blue)
                        Text("(end date > start date)").foregroundColor(.blue)
                    }
                }
                .sheet(isPresented: self.$startIsPresented, content: {
                    RKViewController(isPresented: self.$startIsPresented, rkManager: self.rkManager2)})
                VStack {
                    Text(self.getTextFromDate(date: self.rkManager2.startDate))
                    Text(self.getTextFromDate(date: self.rkManager2.endDate))
                }
            }
            
            Group {
                Button(action: { self.multipleIsPresented.toggle() }) {
                    Text("Example 3 - Multiple Dates Selection ").foregroundColor(.blue)
                }
                .sheet(isPresented: self.$multipleIsPresented, content: {
                    RKViewController(isPresented: self.$multipleIsPresented, rkManager: self.rkManager3)})
                datesView(dates: self.rkManager3.selectedDates)
            }
            
            Group {
                Button(action: { self.deselectedIsPresented.toggle() }) {
                    Text("Example 4 - Disabled Dates Setting").foregroundColor(.blue)
                }
                .sheet(isPresented: self.$deselectedIsPresented, content: {
                    RKViewController(isPresented: self.$deselectedIsPresented, rkManager: self.rkManager4)})
                datesView(dates: self.rkManager4.disabledDates)
            }
            
        }.onAppear(perform: startUp)
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func datesView(dates: [Date]) -> some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(dates, id: \.self) { date in
                    Text(self.getTextFromDate(date: date))
                }
            }
        }.padding(.horizontal, 15)
    }
 
    func startUp() {
        
        // example of pre-setting selected dates
        let testOnDates = [Date().addingTimeInterval(ContentView.DAY), Date().addingTimeInterval(ContentView.DAY*2)]
        rkManager3.selectedDates.append(contentsOf: testOnDates)
        
        // example of some foreground colors
        rkManager3.colors.weekdayHeaderColor = Color.blue
        rkManager3.colors.monthHeaderColor = Color.green
        rkManager3.colors.textColor = Color.blue
        rkManager3.colors.disabledColor = Color.red
        
        // example of pre-setting disabled dates
        let testOffDates = [
            Date().addingTimeInterval(ContentView.DAY*4),
            Date().addingTimeInterval(ContentView.DAY*5),
            Date().addingTimeInterval(ContentView.DAY*7)]
        rkManager4.disabledDates.append(contentsOf: testOffDates)
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
