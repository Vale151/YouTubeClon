//
//  HomeProvider.swift
//  YouTubeClon
//
//  Created by user on 05/06/2022.
//

import Foundation

protocol HomeProviderProtocol{
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel //inyeccion de dependencias. Esto sirve para hacer pruebas. Mientras conforme el protocol se puede consultar a un proveedor diferente. (mocks) no  a la api necesariamente
        //es transparente
    func getChannel(channelId: String) async throws -> ChannelModel
    func getPlaylists(channelId: String) async throws -> PlaylistModel
    func getPlaylistsItems(playlistId: String) async throws -> PlaylistItemsModel
}

class HomeProvider: HomeProviderProtocol {
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        var queryParams: [String: String] = ["part":"snippet"]
        
        if !channelId.isEmpty {
            queryParams["channelId"] = channelId
        }
        
        if !searchString.isEmpty {
            queryParams["q"] = searchString
        }
        
        let requestModel = RequestModel(endPoint: .search, queryItems: queryParams)
        
        do{
            let model = try await  ServiceLayer.callService(requestModel, VideoModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
    func getChannel(channelId: String) async throws -> ChannelModel {
        let queryParams: [String: String] = ["part":"snippet, statistics, brandingSettings",
                                             "id": channelId]
        
        let requestModel = RequestModel(endPoint: .channels, queryItems: queryParams)
        
        do{
            let model = try await  ServiceLayer.callService(requestModel, ChannelModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        let queryParams: [String: String] = ["part":"snippet,contentDetails",
                                             "channelId": channelId]
        
        let requestModel = RequestModel(endPoint: .playlists, queryItems: queryParams)
        
        do{
            let model = try await  ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylistsItems(playlistId: String) async throws -> PlaylistItemsModel {
        let queryParams: [String: String] = ["part":"snippet,id,contentDetails",
                                             "playlistId": playlistId]
        
        let requestModel = RequestModel(endPoint: .playlistItems, queryItems: queryParams)
        
        do{
            let model = try await  ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
}
