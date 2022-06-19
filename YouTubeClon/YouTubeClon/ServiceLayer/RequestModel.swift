//
//  RequestModel.swift
//  YouTubeClon
//
//  Created by user on 05/06/2022.
//

import Foundation

struct RequestModel {
    let endPoint: Endpoints
    let queryItems: [String: String]?
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLBase = .youtube
    
    func getURL() -> String {
        return baseUrl.rawValue + endPoint.rawValue
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    enum Endpoints: String {
        case search = "/search"
        case channels = "/channels"
        case playlists = "/playlists"
        case playlistItems = "/playlistItems"
        case empty = ""
    }
    
    enum URLBase: String {
        case youtube = "https://youtube.googleapis.com/youtube/v3"
        case google = "https://otherweb.com/v2"
    }
}
