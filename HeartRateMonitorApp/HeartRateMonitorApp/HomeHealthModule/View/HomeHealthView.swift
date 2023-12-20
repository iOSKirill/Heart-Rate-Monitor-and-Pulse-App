//
//  HomeHealthView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct HomeHealthView: View {
    // MARK: - Property -
    @StateObject var viewModel = HomeHealthViewModel()
    @Binding var isPopupVisible: Bool

    // MARK: - Custom week calendar -
    var weekCalendar: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.currentWeek, id: \.self) { day in
                        VStack(spacing: 6) {
                            Text(day.getDayOfWeekNumber)
                                .font(.appSemibold(of: 17))
                                .foregroundColor(Color.mainText)
                                .background(
                                    ZStack {
                                        Circle()
                                            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                                            .foregroundColor(Color.currentDay)
                                            .frame(width: 32, height: 32)
                                            .opacity(day.todayDateInCalendar ? 1 : 0)
                                    }
                                )

                            Text(day.getWeekOfDayName)
                                .font(.appSemibold(of: 15))
                                .foregroundColor(Color.mainText)
                                .padding(.top, 6)
                        }
                        .frame(width: geo.size.width / 8, height: 69)
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }

    // MARK: - Measure dashboard -
    var measureDashboard: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(L10n.Dashboard.Measure.title)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        isPopupVisible.toggle()
                    }
                } label: {
                    Image(.informationButton)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 10)

            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color.white.opacity(0.08))

            HStack(alignment: .center) {
                VStack(spacing: 13) {
                    Button {
                        viewModel.isPresentedMeasurementView.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 76, height: 76)
                            Image(.tapToStartButton)
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.isPresentedMeasurementView) {
                        MeasurementView()
                    }
                    Text(L10n.Button.Start.title)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 28)
            .frame(maxWidth: .infinity)

            HStack(alignment: .center) {
                VStack(spacing: 8) {
                    Text(L10n.Dashboard.Measure.subtitle)
                        .font(.appUrbanistBold(of: 19))
                        .foregroundColor(.white)
                    Text(L10n.Dashboard.Measure.mainText)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(Color.measureDashboardSubtitle)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    Image(.pulseLine)
                        .resizable()
                        .padding(.top, 14)
                        .padding(.bottom, 24)
                }
            }
            .padding(.top, 25)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 367)
        .background(
            ZStack {
            Color.currentDay
            Image(.measureBackgound)
                .blur(radius: 8.5)
            }
        )
        .cornerRadius(20)
        .padding(.top, 70)
        .padding(.horizontal, 16)
    }

    // MARK: - Rectangles under dashboard -
    var rectanglesUnderDashboard: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 50)
                .background(.white.opacity(0.3))
                .cornerRadius(20)
                .padding(.horizontal, 25)
                .offset(y: 240)

            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 50)
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .offset(y: 225)
        }
    }

    // MARK: - Weekly assessment dashboard -
    var weeklyAssessmentDashboard: some View {
        VStack(alignment: .leading) {
            Text(L10n.Dashboard.Assessment.header)
                .font(.appUrbanistBold(of: 17))
                .foregroundColor(Color.mainText)
                .padding(.leading, 16)

            VStack(alignment: .leading) {
                HStack {
                    Image(.assessmentIcon)
                        .padding(.leading, 16)
                    Text(L10n.Dashboard.Assessment.title)
                        .font(.appUrbanistBold(of: 17))
                        .foregroundColor(Color.mainText)
                        .padding(.leading, 12)
                    Spacer()
                }
                .padding(.top, 16)

                HStack(alignment: .center) {
                    VStack(spacing: 2) {
                        Text(L10n.Dashboard.Assessment.subtitle)
                            .font(.appUrbanistBold(of: 19))
                            .foregroundColor(Color.mainText)
                        Text(L10n.Dashboard.Assessment.mainText)
                            .font(.appSemibold(of: 15))
                            .foregroundColor(Color.subtitle)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 176)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 69)
            }
            .frame(maxWidth: .infinity, minHeight: 238)
            .background(
                ZStack(alignment: .bottom) {
                Color.white
                Image(.assessmentBackground)
                        .opacity(0.4)
                        .blur(radius: 5.0)
                        .padding(.bottom, 16)
                }
            )
            .cornerRadius(20)
            .padding(.top, 12)
            .padding(.horizontal, 16)
        }
        .padding(.top, 31)
        .padding(.bottom, 30)
    }

    // MARK: - Body -
    var body: some View {
        ZStack {
            Color(.backgroundSreens).ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    weekCalendar
                    ZStack {
                        rectanglesUnderDashboard
                        measureDashboard
                        viewModel.getScrollOffsetReader()
                    }
                    weeklyAssessmentDashboard
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
                viewModel.updateSrollStatus(value: value)
            })
            .safeAreaInset(edge: .top, content: {
                Color.backgroundSreens
                    .frame(height: 30)
            })
            .overlay {
                CustomNavigationBar(isScrolling: $viewModel.isScroll)
            }
        }
    }
}

#Preview {
    HomeHealthView(isPopupVisible: .constant(true))
}
