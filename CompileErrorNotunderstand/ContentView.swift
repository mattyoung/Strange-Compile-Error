//
//  ContentView.swift
//  CompileErrorNotunderstand
//
//  Created by Matthew Young on 9/22/23.
//

import SwiftUI

struct AnimatedTab: View, Identifiable {
    let id = UUID()
    var symbol: Symbol
    var isAnimating: Bool?
    
    var body: some View {
        Text("Hello")
    }
}


struct ContentView: View {
    static let tabSymbols = [
        Symbol.photos,
        .chat,
        .apps,
        .notifications,
        .profile,
    ]

    @State private var activeTab = Self.tabSymbols[0]
    @State private var tabs = Self.tabSymbols.compactMap { symbol -> AnimatedTab? in
            .init(symbol: symbol)
    }

    @State private var bouncesDown = true

    
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                ForEach(Self.tabSymbols) { symbol in
                    NavigationStack {
                        VStack {
                            
                        }
//                        .navigationTitle(symbol.title)    // we are not referencing Symbol anywhere
                    }
                    .setupTab(symbol)
                }
            }
    
            Picker("", selection: $bouncesDown) {
                Text("Bounces Down")
                    .tag(true)
                Text("Bounces Up")
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            
            customTabBar
        }
    }
    
    @ViewBuilder
    var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $animatedTab in
                let tabSymbol = animatedTab.symbol
                
                VStack(spacing: 4) {
                    Image(systemName: tabSymbol.rawValue)
                        .font(.title)
                        .symbolEffect(bouncesDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    Text(tabSymbol.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tabSymbol ? Color.primary : .gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                        activeTab = tabSymbol
                        animatedTab.isAnimating = true
                    } completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    }
                }
            }
        }
        .background(.bar)
    }
}



extension View {
    @ViewBuilder
    func setupTab(_ symbol: Symbol) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(symbol)
//            .toolbar(.hidden, for: .tabBar)   // this doesn't seem to do anything
    }
}


#Preview {
    ContentView()
}
