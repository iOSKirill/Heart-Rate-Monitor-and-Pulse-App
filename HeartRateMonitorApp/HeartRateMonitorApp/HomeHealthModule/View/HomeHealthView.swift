//
//  HomeHealthView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct HomeHealthView: View {
    // MARK: - Property -
    @ObservedObject var viewModel: HomeHealthViewModel
    @Binding var isPopupVisible: Bool
    @Binding var showTabBar: Bool

    // MARK: - Custom week calendar -
    var weekCalendar: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.currentWeek, id: \.self) { day in
                        VStack(spacing: 6) {
                            Button {
                                viewModel.calculateDailyAverage(date: day)
                            } label: {
                                Text(day.getDayOfWeekNumber)
                                    .font(.appSemibold(of: 17))
                                    .foregroundColor(
                                        viewModel.hasMeasurementForDay(date: day) ?
                                        Color.clear : Color.appMarengo
                                    )
                                    .background(
                                        ZStack {
                                            Circle()
                                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                                                .foregroundColor(Color.appBlue)
                                                .frame(width: 36, height: 36)
                                                .opacity(day.todayDateInCalendar ? 1 : 0)

                                            if viewModel.hasMeasurementForDay(date: day) {
                                                Image(.checkMeasurementIcon)
                                            }
                                        }
                                    )
                            }

                            Text(day.getWeekOfDayName)
                                .font(.appSemibold(of: 15))
                                .foregroundColor(Color.appMarengo)
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
                .foregroundColor(Color.appMarengo)
                .padding(.leading, 16)

            VStack(alignment: .leading) {
                HStack {
                    Image(.assessmentIcon)
                        .padding(.leading, 16)
                    Text(L10n.Dashboard.Assessment.title)
                        .font(.appUrbanistBold(of: 17))
                        .foregroundColor(Color.appMarengo)
                        .padding(.leading, 12)
                    Spacer()
                }
                .padding(.top, 16)

                HStack(alignment: .center) {
                    VStack(spacing: 2) {
                        Text(L10n.Dashboard.Assessment.subtitle)
                            .font(.appUrbanistBold(of: 19))
                            .foregroundColor(Color.appMarengo)
                        Text(L10n.Dashboard.Assessment.mainText)
                            .font(.appSemibold(of: 15))
                            .foregroundColor(Color.appSlateGrey)
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
        NavigationView {
            ZStack {
                Color(.appPaleBlue).ignoresSafeArea()
                NavigationBarScroll(scrollOffSet: $viewModel.scrollOffSet, navBarLayout: .leftTitleRightButton(
                    title: L10n.NavigationBar.Health.title,
                    button: AnyView(SettingsButton(showTabBar: $showTabBar))
                )) {
                    VStack {
                        weekCalendar
                        ZStack {
                            rectanglesUnderDashboard

                            switch viewModel.measurementState {
                              case .noData:
                                  MeasureNoDataDashboard(isPopupVisible: $isPopupVisible)
                              case .defaultMeasurement:
                                  MeasureDefaultDashboard(viewModel: viewModel, isPopupVisible: $isPopupVisible)
                              case .details:
                                  MeasureDetailsDashboard(viewModel: viewModel, isPopupVisible: $isPopupVisible)
                              }
                        }

                        if !viewModel.pulseData.isEmpty {
                            PulseChartView(
                                isOn: $viewModel.isOnToggleTodayAndWeek,
                                pulseData: viewModel.pulseData,
                                blueGradient: viewModel.blueGradient
                            )
                        } else {
                            weeklyAssessmentDashboard
                        }
                    }
                    .onAppear {
                        viewModel.trackingChangesRealmDB()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeHealthView(
        viewModel: .init(dailyAverage: .init(pulse: 20, hrv: 20, assessment: 20, time: .now)),
        isPopupVisible: .constant(true),
        showTabBar: .constant(true)
    )
}
