//
//  CustomNavigationBar.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 12.12.23.
//

import SwiftUI

enum NavBarLayout {
    case leftTitleRightButton(title: String, button: AnyView)
    case centerTitleRightButton(title: String, button: AnyView)
    case leftButtonCenterTitle(title: String, button: AnyView)
    case leftButtonCenterTitleRightButton(title: String, buttonFirst: AnyView, buttonSecond: AnyView)
}

struct CustomNavigationBar: View {
    // MARK: - Property -
    @Binding var scrollOffSet: CGFloat
    var navBarLayout: NavBarLayout

    // MARK: - Body -
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    switch navBarLayout {
                    case .leftTitleRightButton(let title, let button):
                        HStack {
                            Text(title)
                                .font(.appUrbanistBold(of: 32))
                                .foregroundColor(.mainText)
                            Spacer()
                            button
                        }
                    case .centerTitleRightButton(let title, let button):
                        ZStack {
                            Text(title)
                                .font(.appUrbanistBold(of: 24))
                                .foregroundColor(.mainText)
                            button
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    case .leftButtonCenterTitle(let title, let button):
                        ZStack {
                            button
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(title)
                                .font(.appUrbanistBold(of: 24))
                                .foregroundColor(.mainText)
                        }
                    case .leftButtonCenterTitleRightButton(let title, let buttonFirst, let buttonSecond):
                        HStack {
                            buttonFirst
                            Spacer()
                            Text(title)
                                .font(.appUrbanistBold(of: 24))
                                .foregroundColor(.mainText)
                            Spacer()
                            buttonSecond
                        }
                    }
                }
                .padding(.bottom, 11)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.15)
                .background(RoundedCorners(
                    color: .ultraThinMaterial,
                    topLeftRadius: 0,
                    topRightRadius: 0,
                    bottomLeftRadius: 15,
                    bottomRightRadius: 15
                )
                    .blur(radius: scrollOffSet > 0 ? 0.5 : 0)
                )
                .ignoresSafeArea(.all)
            }
        }
    }
}

 struct CustomScrollView<Content: View>: View {
    // MARK: - Property -
    @Binding var scrollOffSet: CGFloat
    var navBarLayout: NavBarLayout
    var content: () -> Content

    // MARK: - Body -
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { _ in
                    content()
                        .padding(.top, 50)
                        .background(GeometryReader {
                            Color.backgroundSreens.preference(
                                key: ViewOffSetKey.self,
                                value: -$0.frame(in: .named("scroll")).origin.y
                            )
                        })
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ViewOffSetKey.self) { self.scrollOffSet = $0 }

            CustomNavigationBar(scrollOffSet: $scrollOffSet, navBarLayout: navBarLayout)
        }
    }
 }

struct ViewOffSetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// MARK: - Rounding off the specified corners -
struct RoundedCorners: View {
    private(set) var color: Material
    private(set) var topLeftRadius: CGFloat
    private(set) var topRightRadius: CGFloat
    private(set) var bottomLeftRadius: CGFloat
    private(set) var bottomRightRadius: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let topRight = min(min(self.topRightRadius, height/2), width/2)
                let topLeft = min(min(self.topLeftRadius, height/2), width/2)
                let bottomLeft = min(min(self.bottomLeftRadius, height/2), width/2)
                let bottomRight = min(min(self.bottomRightRadius, height/2), width/2)

                path.move(to: CGPoint(x: width / 2.0, y: 0))
                path.addLine(to: CGPoint(x: width - topRight, y: 0))
                path.addArc(
                    center: CGPoint(x: width - topRight, y: topRight),
                    radius: topRight,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false
                )
                path.addLine(to: CGPoint(x: width, y: height - bottomRight))
                path.addArc(
                    center: CGPoint(
                        x: width - bottomRight,
                        y: height - bottomRight
                    ),
                    radius: bottomRight,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false
                )
                path.addLine(to: CGPoint(x: bottomLeft, y: height))
                path.addArc(
                    center: CGPoint(
                        x: bottomLeft,
                        y: height - bottomLeft
                    ),
                    radius: bottomLeft,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false
                )
                path.addLine(to: CGPoint(x: 0, y: topLeft))
                path.addArc(
                    center: CGPoint(
                        x: topLeft,
                        y: topLeft
                    ),
                    radius: topLeft,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false
                )
            }
            .fill(self.color)
        }
    }
}
