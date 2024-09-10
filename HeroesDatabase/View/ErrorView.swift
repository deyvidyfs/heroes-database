//
//  ErrorView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

struct ErrorView: View {
    
    let errorMessage: String?
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Text(errorMessage ?? "Error")
                .foregroundStyle(.white)
                .padding()
            
            if let retryAction = retryAction {
                Button {
                    retryAction()
                } label: {
                    Text("Try Again")
                }
                .padding()
                .background(Color.marvelRed)
                .foregroundStyle(.white)
                .clipShape(Capsule(style: .continuous))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.marvelGray)
    }
}

#Preview {
    ErrorView(errorMessage: "An error has occured.", retryAction: {})
}
