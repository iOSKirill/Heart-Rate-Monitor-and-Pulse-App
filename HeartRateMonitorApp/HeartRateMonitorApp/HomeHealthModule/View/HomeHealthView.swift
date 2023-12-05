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
                            Text(day.dayNum())
                                .font(.urbanistSemiBold(size: 17))
                                .foregroundColor(Color.mainText)
                                .background(
                                        ZStack {
                                            Circle()
                                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                                                .foregroundColor(Color.currentDay)
                                                .frame(width: 32, height: 32)
                                                .opacity(viewModel.isToday(date: day) ? 1 : 0)
                                        }
                                    )

                            Text(day.weekDayAbbrev())
                                .font(.urbanistSemiBold(size: 15))
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
    
    // MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backgroundSreens).ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        weekCalendar
                    }
                }
            }
            .navigationBarItems(leading: Text(L10n.healthNavigationTitile)
                                            .font(.urbanistBold(size: 32))
                                            .foregroundColor(.mainText)
                                            .padding(.top, 16)
                                            .padding(.bottom, 13),
                                trailing: settingsButton)
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    HomeHealthView()
}
