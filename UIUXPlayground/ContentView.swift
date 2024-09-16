//
//  ContentView.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("")
//        NavigationStack {
//            VStack {
//                List(Screen.allCases) { value in
//                    NavigationLink(value.rawValue, value: value)
//                }
//            }
//            .navigationTitle("UIUX Playground")
//            .navigationBarTitleDisplayMode(.large)
//            .navigationDestination(for: Screen.self) { screen in
//                screen.getView()
//            }
//        }
    }
}

//enum Screen: String, CaseIterable, Identifiable {
//    var id : String { UUID().uuidString }
//    case yelpDetail = "Yelp Detail Scrolling Screen"
//    
//    func getView() -> AnyView {
//        switch self {
//        case .yelpDetail:
//            return AnyView(YelpDetailScrollingScreen())
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
