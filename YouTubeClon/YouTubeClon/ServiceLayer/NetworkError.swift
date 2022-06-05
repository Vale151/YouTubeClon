//
//  NetworkError.swift
//  YouTubeClon
//
//  Created by user on 05/06/2022.
//

import Foundation

enum NetworkError: String, Error{
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError = "ocurrió un error al tratar de consultar el API: status code"
    case jsonDecoder = "Error al intentar extraer datos de json."
    case unauthorized
}
