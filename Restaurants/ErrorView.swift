//
//  ErrorView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import SwiftUI

struct ErrorView: View {
    let errorText: String
    let retryClosure: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.system(size: 24))
            
            Text(errorText)
                .bold()
                .font(.title)
            Button("Retry", action: {
                retryClosure()
            })
            .font(.title2)
        }
    }
}
