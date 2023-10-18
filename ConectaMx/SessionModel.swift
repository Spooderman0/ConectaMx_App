//
//  SessionModel.swift
//  ConectaMx
//
//  Created by Alumno on 17/10/23.
//

import Foundation
class SessionModel: ObservableObject {
    @Published var token: String = ""
    @Published var person: Person?
}
