//
//  APICaller.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 19.07.2022.
//

import Foundation
import UIKit

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, competion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=51&seed_genres=\(seeds)"),
                      type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    competion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    competion(.success(result))
                } catch {
                    competion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(competion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
                      type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    competion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    competion(.success(result))
                } catch {
                    competion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getAlbumDetail(with album: Album, compeltion: @escaping((Result<AlbumDetailResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    compeltion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailResponse.self, from: data)
                    compeltion(.success(result))
                } catch {
                    compeltion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getPlaylistDetail(with playlist: Playlist, completion: @escaping((Result<PlaylistDetailResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists/?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LibraryPlaylistsResponce.self, from: data)
                    completion(.success(result.items))
                    
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume() 
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name": name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                                print("Created")
                                completion(true)
                            }
                            else {
                                print("Failed to get id")
                                completion(false)
                            }
                            
                        } catch {
                            print(error.localizedDescription)
                            completion(false)
                
                        }
                    }
                    task.resume()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Adding...")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    } else {
                        
                        completion(false)
                    }
                } catch {
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        
    }
    
    
    var imageCache = NSCache<NSString, UIImage>()
    func fetchImage(from urlString: String, completionHandler: @escaping (_ image: UIImage?) -> ()) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            completionHandler(image)
        } else {
            let session = URLSession.shared
            guard let url = URL(string: urlString) else { return }
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: urlString as NSString)
                        completionHandler(image)
                    }
                } else {
                    print("Error fetching the image with url : \(urlString)!")
                    completionHandler(nil)
                }
            }
            dataTask.resume()
        }
    }
    
    //MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        comletion: @escaping (URLRequest) -> Void) {
            AuthManager.shared.withValidToken { token in
                guard let apiURL = url else {
                    return
                }
                var request = URLRequest(url: apiURL)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpMethod = type.rawValue
                request.timeoutInterval = 30
                comletion(request)
            }
        }
}
