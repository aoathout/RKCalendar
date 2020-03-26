//
//  LazyView.swift
//  RKCalendar
//
//  Created by aoathout on 3/25/20.
//  Copyright © 2020 Raffi Kian. All rights reserved.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}

struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView(Text("I am some content"))
    }
}
