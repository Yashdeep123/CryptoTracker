//
//  CustomColor.swift
//  CryptoTracker
//
//  Created by Yash Patil on 19/08/22.
//

import Foundation
import SwiftUI

extension Color
{
    static let theme = ColorTheme()
    static let Launch = LaunchTheme()
}

struct ColorTheme
{
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let accentColor = Color("AccentColor")
    let secondaryText = Color("SecondaryTextColor")
    let backgroundText = Color("BackgroundColor")
}


struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let backgroundColor = Color("LaunchBackgroundColor")
}
