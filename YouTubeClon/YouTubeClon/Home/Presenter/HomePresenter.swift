//
//  HomePresenter.swift
//  YouTubeClon
//
//  Created by user on 05/06/2022.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]]) //es un array de array por el tipo de datos que se va a presentar: channelmodel, playlistmodel, videoModel, playlistmodel
}

class HomePresenter {
    var provider: HomeProviderProtocol
    weak var delegate: HomeViewProtocol?
    private var objectList: [[Any]] = []
    
    init(delegate: HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func getHomeObjects() async {
        objectList.removeAll()//una vez consultado se remueve todo
        
        //ACÅ las llamadas se hacen tipo cascada y eso no es performante. Se hace una llamada por cada uno. Lo ideal seria agarrar todos los llamados y agruparlos en un solo llamado.
        do {
            let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
            let channels = try await provider.getChannel(channelId: Constants.channelId).items
            let playlist = try await provider.getPlaylists(channelId: Constants.channelId).items
            
            let playlistItems = try await provider.getPlaylistsItems(playlistId: playlist.first?.id ?? "").items
            
            objectList.append(channels)
            objectList.append(playlistItems)
            objectList.append(videos)
            objectList.append(playlist)
            
        } catch {
            print(error)
        }
      
    }
}
