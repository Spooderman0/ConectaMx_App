//
//  FullImageView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 18/10/23.
//

import SwiftUI

struct FullImageView: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
    }
}

