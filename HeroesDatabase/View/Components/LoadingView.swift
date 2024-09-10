//
//  LoadingView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

struct LoadingView: View {
    var text: String?
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
            
            if let text = text {
                Text(text)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.marvelGray)
    }
}

#Preview {
    LoadingView(text: "Retrieving database...")
}
