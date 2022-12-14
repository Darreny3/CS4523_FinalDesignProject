//
//  Logo.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/14/22.
//

import SwiftUI

var start: CGFloat = 0.18
var end: CGFloat = 0.82

struct LogoView: View {
    var body: some View {
        Ellipse()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round))
            .foregroundColor(.green)
            .scaledToFit()
            
            
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
