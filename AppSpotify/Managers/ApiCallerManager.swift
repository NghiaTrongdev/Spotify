//
//  ApiCallerManager.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation
final class ApiCallerManager {
    static let shared = ApiCallerManager()
    
    private init(){}
    
    public func getCurrentUser(completion : @escaping(Result<UserProfile,Error>)->Void){
        createRequest(url:URL(string: Constants.constUrl + "/me") , type: .GET){ baserequest in
            let task = URLSession.shared.dataTask(with: baserequest){data,_,error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self,from: data)
                    completion(.success(result))
                } catch {
                    
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    enum APIError : Error {
        case failuaretogetData
    }
    enum HTTPMethods : String {
        case GET
        case POST
    }
    public func createRequest(url : URL?,type : HTTPMethods,completion : @escaping(URLRequest)->Void ){
        AuthManager.shared.withValidToken{ token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    public func getNewRelease(completion : @escaping ((Result<NewReleaseResponse , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/browse/new-releases?limit=50") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleaseResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylist(completion : @escaping ((Result<FeaturedPlaylistResponse , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/browse/featured-playlists?limit=8") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendGenres(completion : @escaping ((Result<RecommendGenres , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/recommendations/available-genre-seeds") , type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendGenres.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getRecommendations(genres : Set<String>,completion : @escaping ((Result<Recommendation , Error>)) -> Void){
        let seeds = genres.joined(separator: ",")
        createRequest(url:URL(string: Constants.constUrl + "/recommendations?limit=2&seed_genres=\(seeds)") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Recommendation.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
//                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getDetailPlaylist(playlistId : String,completion : @escaping ((Result<PlaylistDetailResponse , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/playlists/\(playlistId)") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailResponse.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
                    
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecentlytPlayed(completion : @escaping ((Result<RecentlyPlayedModel , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/me/player/recently-played?limit=2") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecentlyPlayedModel.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
//                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getCategories(completion : @escaping ((Result<CategoriesRespone , Error>)) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/browse/categories?limit=20") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoriesRespone.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
                    
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getSomeArtist(completion : @escaping ((Result<getSomeArtistResponse , Error>)) -> Void){
        let ids = "7Cp2hGcriAaDUAWpXnSEwm,2xK6qcvfXuFFbU0NL95aeo,1LEtM3AleYg1xabW6CRkpi,0gGd4WhPXBSgDX6fdOHcOw,3FwYnbtGNt8hJfjNuOfpeG"
        createRequest(url:URL(string: Constants.constUrl + "/artists?ids=\(ids)") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(getSomeArtistResponse.self, from: data)
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
//                    print(result)
                    
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getUserPlaylist (completion : @escaping ((Result <UserPlayListResponse ,Error > )) -> Void){
        createRequest(url:URL(string: Constants.constUrl + "/users/31ls6zveyiee5heooeyncskz6rcu/playlists") , type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failuaretogetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserPlayListResponse.self, from: data)


                    
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
