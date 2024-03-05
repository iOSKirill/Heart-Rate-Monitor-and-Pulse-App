//
//  PulseChartView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 18.02.24.
//

import Foundation
import SwiftUI

struct PulseChartView: View {
    // MARK: - Property -
    @Binding var isOn: Bool
    var pulseData: [PulseData]
    var blueGradient: Gradient

    // MARK: - Body -
    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.Dashboard.Assessment.header)
                .font(.appUrbanistBold(of: 17))
                .foregroundColor(Color.appMarengo)
                .padding(.leading, 16)

            VStack {
                HStack {
                    Image(.assessmentIcon)
                    Text(L10n.Dashboard.Statistics.title)
                        .font(.appUrbanistBold(of: 17))
                        .foregroundColor(Color.appMarengo)
                        .padding(.leading, 12)
                    Spacer()
                    TodayWeekToggleView(isOn: $isOn)
                }
                .padding(.top, 18)
                .padding(.horizontal, 16)

                VStack {
                    ZStack(alignment: .bottomLeading) {
                        // Chart background grid
                        Image(.chartBackground)
                            .resizable()
                            .scaledToFit()

                        // Сhart columns
                        HStack(alignment: .bottom) {
                            ForEach(pulseData, id: \.time) { data in
                                ZStack(alignment: .bottom) {
                                    VStack {
                                        Text("\(data.pulse)")
                                            .font(.appUrbanistBold(of: 13))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: CGFloat(data.pulse))
                                .background(
                                    LinearGradient(
                                        gradient: blueGradient,
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .mask(RoundedAllCorners(
                                    topLeftRadius: 12,
                                    topRightRadius: 12,
                                    bottomLeftRadius: 0,
                                    bottomRightRadius: 0
                                ))
                            }
                        }
                    }

                    // Time measurement
                    HStack(alignment: .top) {
                        ForEach(pulseData, id: \.time) { data in
                            VStack {
                                Text(isOn ? data.time.getDateStatistics : data.time.getWeekOfDayName)
                                    .font(.appUrbanistBold(of: 13))
                                    .foregroundColor(.appMarengo)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 6)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 16)

            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 16)
        }
        .padding(.top, 31)
        .padding(.bottom, 30)
    }
}

// MARK: - Rounding off the specified corners -
struct RoundedAllCorners: View {
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
        }
    }
}
