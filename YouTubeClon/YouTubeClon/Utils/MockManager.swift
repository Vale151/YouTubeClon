//
//  MockManager.swift
//  YouTubeClon
//
//  Created by user on 20/06/2022.
//

import Foundation

//Crea un singleton
//crea una clase la cual va a tener una unica instancia. Y cuando sea true toma lo del mock, cuando es false tomo lo que sea que este configurado

class MockManager {
    static var shared = MockManager()
    var runAppWithMock: Bool = true //este bool en false toma data de la API. En false de los mocks
}
