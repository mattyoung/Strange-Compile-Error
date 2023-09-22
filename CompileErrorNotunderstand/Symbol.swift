//
//  Symbol.swift
//  CompileErrorNotunderstand
//
//  Created by Matthew Young on 9/22/23.
//

import SwiftUI


// https://github.com/lukepistrol/SFSymbolsMacro
import SFSymbolsMacro

@SFSymbol
enum Symbol: String, Hashable, Identifiable, CaseIterable {
    case bookCircle = "book.circle"
    case charBar = "chart.bar"
    case circle
    case ellipsisCircle = "ellipsis.circle"
    case globe
    case listDash = "list.dash"
    case squareAndPencil = "square.and.pencil"
    case speakerWave3 = "speaker.wave.3"
    case touchId = "touchid"
    case wifi
    case photos = "photo.stack"
    case chat = "bubble.left.and.text.bubble.right"
    case apps = "square.3.layers.3d"
    case notifications = "bell.and.waves.left.and.right"
    case profile = "person.2.crop.square.stack"
    
    var id: Self { self }
    
    var title: String {         // cannot change this property name to anything else
        switch self {
        case .bookCircle:
            "Book"
        case .charBar:
            "Char"
        case .circle:
            "Circle"
        case .ellipsisCircle:
            "Ellipsis"
        case .globe:
            "Globe"
        case .listDash:
            "List"
        case .squareAndPencil:
            "Write"
        case .speakerWave3:
            "Sound"
        case .touchId:
            "Touch ID"
        case .wifi:
            "WiFi"
        case .photos:
            "Photos"
        case .chat:
            "Chat"
        case .apps:
            "Apps"
        case .notifications:
            "Notifications"
        case .profile:
            "Profile"
        }
    }
}

extension Image {
    init(symbol: Symbol) {
        self.init(systemName: symbol.rawValue)
    }
    
    init(symbol: Symbol, variableValue: Double) {
        self.init(systemName: symbol.rawValue, variableValue: variableValue)
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ title: LocalizedStringKey, symbol: Symbol) {
        self.init(title, systemImage: symbol.rawValue)
    }
}

