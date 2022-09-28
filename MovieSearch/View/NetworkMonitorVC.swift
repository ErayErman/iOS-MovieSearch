//
//  NetworkMonitori.swift
//  MovieSearch
//
//  Created by Eray on 23.09.2022.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    public private(set) var isConnected: Bool = false
    
    private init(){
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            
            
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    
    
}
