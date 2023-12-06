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

    // MARK: - Settings button -
    var settingsButton: some View {
        NavigationLink {
            SettingsView(viewModel: viewModel.settingsVM)
        } label: {
            VStack {
                Image(.settingsButton)
                    .padding(8)
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding(.top, 16)
            .padding(.bottom, 13)
        }
    }

    // MARK: - Custom week calendar -
    var weekCalendar: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.currentWeek, id: \.self) { day in
                        VStack(spacing: 6) {
                            Text(day.getDayOfWeekNumber)
                                .font(.custom(FontFamily.Urbanist.semiBold, size: 17))
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
                                .font(.custom(FontFamily.Urbanist.semiBold, size: 15))
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
                    .font(.custom(FontFamily.Urbanist.bold, size: 17))
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    // Additional information
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
                        // The beginning of the pulse measurement
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 76, height: 76)
                            Image(.tapToStartButton)
                        }
                    }
                    Text(L10n.Button.Start.title)
                        .font(.custom(FontFamily.Urbanist.semiBold, size: 15))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 28)
            .frame(maxWidth: .infinity)

            HStack(alignment: .center) {
                VStack(spacing: 8) {
                    Text(L10n.Dashboard.Measure.subtitle)
                        .font(.custom(FontFamily.Urbanist.bold, size: 19))
                        .foregroundColor(.white)
                    Text(L10n.Dashboard.Measure.mainText)
                        .font(.custom(FontFamily.Urbanist.semiBold, size: 15))
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

    // MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backgroundSreens).ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        weekCalendar
                        ZStack {
                            rectanglesUnderDashboard
                            measureDashboard
                        }
                    }
                }
            }
            .navigationBarItems(leading: Text(L10n.NavigationBar.Health.title)
                                            .font(.custom(FontFamily.Urbanist.bold, size: 32))
                                            .foregroundColor(.mainText)
                                            .padding(.top, 16)
                                            .padding(.bottom, 13),
                                trailing: settingsButton)
        }
    }
}

#Preview {
    HomeHealthView()
}
