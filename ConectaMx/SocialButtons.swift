//
//  SocialButtons.swift
//  ConectaMx
//
//  Created by Danna Valencia on 18/10/23.
//

import SwiftUI

struct SocialButton: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isVisible: Bool
    var image: String
    var url: String
}
