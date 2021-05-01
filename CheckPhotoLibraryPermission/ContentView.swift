//
//  ContentView.swift
//  CheckPhotoLibraryPermission
//
//  Created by 米国梁 on 2021/4/29.
//

import SwiftUI
import Photos

struct ContentView: View {
    
    @State var title = ""
    
    @State var message = ""
    
    var body: some View {
        
        VStack {

            if title != "" {
                
                Text(title)
                
                Text(message)
            }
            
            Button("Check Photo Library Permission") {
                
                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                switch status {
                case .limited:
                    title = "Limited"
                    message = "You can access user specified photos only"
                case .authorized:
                    title = "Authorized"
                    message = "You can access all photos"
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { result in
                        switch result {
                        case .authorized:
                            title = "Authorized"
                            message = "You can access all photos"
                        case .limited:
                            title = "Authorized"
                            message = "You can access all photos"
                        case .denied:
                            title = "Denied"
                            message = "You can not access anything, and you should guide user to settings here"
                        case .restricted:
                            fatalError("Should never be RESTRICT.")
                        case .notDetermined:
                            fatalError("Should never be NOT DETERMINED.")
                        @unknown default:
                            fatalError("Unknown status: \(result.rawValue)")
                        }
                    }
                case .denied:
                    title = "Denied"
                    message = "You can not access anything, and you should guide user to settings here"
                case .restricted:
                    title = "Restricted"
                    message = "Forbidden by Parent strategy"
                @unknown default:
                    fatalError("Unknown status: \(status.rawValue)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
