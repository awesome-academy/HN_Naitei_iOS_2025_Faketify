//
//  AuthManager.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "e9f87f02cc0a4a6b9cdc2612eadafecf"
        static let clientSecret = "7829b08bb2a849748a210770370dc090"
    }
    private init() {}
    
     var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.faketify.io"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)"
        return URL(string: string)
    }
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shoulRefreshToken: Bool {
        return false
    }
    
    func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    )  {
        
    }
    
}
