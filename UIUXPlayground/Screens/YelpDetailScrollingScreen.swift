//
//  YelpDetailScrollingScreen.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 8/30/24.
//

import Foundation
import SwiftUI

public struct YelpDetailScrollingScreen<Header: View, Content: View>: View {
  public typealias ScrollAction = (_ offset: CGPoint) -> Void
  private let showsIndicators: Bool
  private let header: () -> Header
  private let headerHeight: CGFloat
  private let headerMinHeight: CGFloat?
  private let onScroll: ScrollAction?
  private let content: () -> Content
  @State
  private var scrollOffset: CGPoint = .zero
  @State
  private var navigationBarHeight: CGFloat = .zero
    
  public init(
     @ViewBuilder header: @escaping () -> Header,
     headerHeight: CGFloat,
     headerMinHeight: CGFloat? = nil,
     showsIndicators: Bool = true,
     onScroll: ScrollAction? = nil,
     @ViewBuilder content: @escaping () -> Content
   ) {
     self.showsIndicators = showsIndicators
     self.header = header
     self.headerHeight = headerHeight
     self.headerMinHeight = headerMinHeight
     self.onScroll = onScroll
     self.content = content
   }
    
  public var body: some View {
    ZStack(alignment: .top) {
      scrollView
        .toolbar {
          ToolbarItem(placement: .principal) {
              HStack {
                  Image(systemName: "arrow.left")

                  
                  Spacer()
                  
                  Text("Rhydon")
                      .font(.headline.bold())
                      .fontDesign(.rounded)
                      .opacity(1 - headerVisibleRatio)
                  
                  Spacer()
              }
          }
        }
        
        
      if headerVisibleRatio <= 0 {
        Color.clear
          .frame(height: navigationBarHeight)
          .overlay(scrollHeaderView, alignment: .bottom)
          .ignoresSafeArea(edges: .top)
      }
    }
    .toolbarBackground(.hidden)
    .navigationBarTitleDisplayMode(.inline)
  }
    
  private var headerVisibleRatio: CGFloat {
    return max(0, (headerHeight + scrollOffset.y) / headerHeight)
  }
    
  var verticalOffset: CGFloat {
    guard headerVisibleRatio < 1 else { return 0 }
    return 70.0 * (1 - headerVisibleRatio)
  }
    
}

private extension YelpDetailScrollingScreen {
  var scrollHeaderView: some View {
    GeometryReader { geo in
      ZStack(alignment: .bottom) {
        Color.black
        Image(uiImage: UIImage(named: "rayimage")!)
          .resizable()
          .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
          .offset(y: verticalOffset)
          .opacity(headerVisibleRatio)
          .padding(.top, 60)
          .padding(.horizontal, 20)
          .aspectRatio(1, contentMode: .fit)
          .cornerRadius(5)
          .shadow(radius: 10)
          .frame(minWidth: geo.size.width, maxWidth: geo.size.width)
        HStack {
          Text("Rhydon")
            .font(.largeTitle)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .padding()
            .multilineTextAlignment(.leading)
            .opacity(headerVisibleRatio)
            .frame(width: .infinity)
            .shadow(radius: 10)
          Spacer()
        }
      }
      .stretchable(in: geo)
    }
    .frame(height: headerHeight)
//    ScrollViewHeader(content: header)
//      .frame(height: headerHeight)
  }
    
  var scrollView: some View {
    GeometryReader { proxy in
      OffsetScrollView(onScroll: handleScrollOffset) {
        VStack(spacing: 0) {
          scrollHeaderView
          content()
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
      }
      .onAppear {
        DispatchQueue.main.async {
          navigationBarHeight = proxy.safeAreaInsets.top
        }
      }
    }
  }
    
  func handleScrollOffset(_ offset: CGPoint) {
    self.scrollOffset = offset
    self.onScroll?(offset)
  }
}

public struct OffsetScrollView<Content: View>: View {
  public typealias ScrollAction = (_ offset: CGPoint) -> Void
  private let axes: Axis.Set
  private let showsIndicators: Bool
  private let onScroll: ScrollAction
  private let content: () -> Content
  public init(
    _ axes: Axis.Set = .vertical,
    showsIndicators: Bool = true,
    onScroll: ScrollAction? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.axes = axes
    self.showsIndicators = showsIndicators
    self.onScroll = onScroll ?? { _ in }
    self.content = content
  }
    
  public var body: some View {
    ScrollView(axes, showsIndicators: showsIndicators) {
      ZStack(alignment: .top) {
        ScrollViewOffsetTracker()
        content()
      }
    }
    .withOffsetTracking(action: onScroll)
    .scrollIndicators(.hidden)
  }
}

struct ScrollViewOffsetTracker: View {
  var body: some View {
    GeometryReader { geo in
      Color.clear
        .preference(
          key: ScrollOffsetPreferenceKey.self,
          value: geo.frame(in: .named(ScrollOffsetNamespace.namespace)).origin
        )
    }
    .frame(height: 0)
  }
}

public struct ScrollViewHeader<Content: View>: View {
  private let content: () -> Content
  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
  }
  public var body: some View {
    GeometryReader { geo in
      content()
        .stretchable(in: geo)
    }
  }
}

private extension View {
  func stretchable(in geo: GeometryProxy) -> some View {
    let width = geo.size.width
    let height = geo.size.height
    let minY = geo.frame(in: .global).minY
    let useStandard = minY <= 0
    return self.frame(width: width, height: height + (useStandard ? 0 : minY))
      .offset(y: useStandard ? 0 : -minY)
  }
  @ViewBuilder
  func prefersNavigationBarHidden() -> some View {
    self.toolbarBackground(.hidden)
  }
}

private extension ScrollView {
    func withOffsetTracking(
    action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
    self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
      .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
  }
}

enum ScrollOffsetNamespace {
  static let namespace = "scrollView"
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct InfoCell: View {
  var title: String
  var description: String
  var body: some View {
    VStack() {
      Text(title)
        .font(.title)
        .fontDesign(.rounded)
        .fontWeight(.bold)
      Text(description)
        .font(.body)
        .fontDesign(.rounded)
        .multilineTextAlignment(.center)
    }
    .padding()
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .foregroundStyle(.black)
  }
}

//#Preview {
//  struct Preview: View {
//    @State
//    var selection = 0
//    func header() -> some View {
////      TabView {
////        Color.red.tag(0)
////        Color.green.tag(1)
////        Color.blue.tag(2)
////      }
////      .tabViewStyle(.page)
//      ZStack {
//        Color.black
//        Image("rayimage", bundle: Bundle(identifier:"com.twny.PTUIUX"))
//          .resizable()
//          .scaledToFit()
//      }
//    }
//    var body: some View {
//      ZStack {
//        Color.black
//          YelpDetailScrollingScreen(
//          header: header,
//          headerHeight: 250,
//          headerMinHeight: 150,
//          showsIndicators: false
//        ) {
//          VStack {
//            InfoCell(title: "Type", description: "Ground, Rock")
//            InfoCell(title: "Abilities", description: "Lightning Rod or Rock Head, Reckless (Hidden Ability)")
//            InfoCell(title: "Gender Ratio", description: "50% male,50% female")
//            InfoCell(title: "Catch Rate", description: "60%")
//            InfoCell(title: "Egg Group", description: "Monster and Field")
//            InfoCell(title: "Hatch time", description: "20 cycles")
//            InfoCell(title: "Leveling rate", description: "Slow")
//            InfoCell(title: "Weight", description: "Big Boi")
//            InfoCell(title: "Color", description: "Gray")
//            InfoCell(title: "Description", description: "Rhydon is a large, gray, bipedal Pokémon with features similar to both dinosaurs and rhinoceroses. It has narrow, red eyes and two fangs in its upper jaw. On the tip of Rhydon's snout is a cream-colored horn, which is smaller on a female than on a male.")
//          }
//          .background(.white)
////          LazyVStack {
////            ForEach(1...100, id: \.self) {
////              Text("\($0)")
////                .foregroundStyle(.black)
////            }
////          }
//        }
//      }
//    }
//  }
//  return NavigationView {
//    Preview()
//  }
//  .accentColor(.white)
//  .colorScheme(.dark)
//}
