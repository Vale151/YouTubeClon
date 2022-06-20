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
        
        //ACA vamos a hacer una cargar y dejarlos listos para hacer un unico llamado
        
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        async let channels = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylists(channelId: Constants.channelId).items
        
    
        
        do {
            //aca se agrupan las llamadas
            let (responseChannel, responsePlaylist, responseVideos) = await (try channels, try playlist, try videos)
            //index 0
            objectList.append(responseChannel)
            
            if let playlistId = responsePlaylist.first?.id, let playlistItems = await getPlaylistItems(playlistId: playlistId) {
                //index 1
                objectList.append(playlistItems.items)
            }
            //index 2
            objectList.append(responseVideos)
            //index 3
            objectList.append(responsePlaylist)
            
            delegate?.getData(list: objectList) //esto le pasa al HomeVC la list de objetos
            
        } catch {
            print(error)
        }
      
    }
    
    func getPlaylistItems(playlistId: String) async -> PlaylistItemsModel? {
        do{
            let playlistItems = try await provider.getPlaylistsItems(playlistId: playlistId)
            return playlistItems
        } catch {
            print("error", error)
            return nil
        }
      
    }
}
