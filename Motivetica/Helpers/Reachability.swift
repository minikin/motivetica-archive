//
//  Reachability.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/8/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation
import SystemConfiguration

enum ReachabilityStatus {
  case notReachable
  case reachableViaWiFi
  case reachableViaWWAN
}

class Reachability: NSObject {
  
  /// Property to store the SCNetworkReachability object.
  private var networkReachability: SCNetworkReachability?
  private var notifying: Bool = false
  
  init?(hostName: String) {
    networkReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, (hostName as NSString).utf8String!)
    
    super.init()
    
    if networkReachability == nil {
      return nil
    }
  }
  
  init?(hostAddress: sockaddr_in) {
    var address = hostAddress
    
    guard let defaultRouteReachability = withUnsafePointer(to: &address, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, $0)
      }
    }) else {
      return nil
    }
    
    networkReachability = defaultRouteReachability
    
    super.init()
    if networkReachability == nil {
      return nil
    }
  }
  
  /// Method creates a reachability instance to control if we are connected to internet.
  static func networkReachabilityForInternetConnection() -> Reachability? {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    return Reachability(hostAddress: zeroAddress)
  }
  
  /// Method allows to check if we are connected to a local WiFi
  static func networkReachabilityForLocalWiFi() -> Reachability? {
    var localWifiAddress = sockaddr_in()
    localWifiAddress.sin_len = UInt8(MemoryLayout.size(ofValue: localWifiAddress))
    localWifiAddress.sin_family = sa_family_t(AF_INET)
    // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0 (0xA9FE0000).
    localWifiAddress.sin_addr.s_addr = 0xA9FE0000
    
    return Reachability(hostAddress: localWifiAddress)
  }
  
  func startNotifier() -> Bool {
    
    guard notifying == false else {
      return false
    }
    
    var context = SCNetworkReachabilityContext()
    context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
    
    guard let reachability = networkReachability, SCNetworkReachabilitySetCallback(reachability, { (target: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
      if let currentInfo = info {
        let infoObject = Unmanaged<AnyObject>.fromOpaque(currentInfo).takeUnretainedValue()
        if infoObject is Reachability {
          let networkReachability = infoObject as! Reachability
          NotificationCenter.default.post(name: .reachabilityDidChangeNotificationName, object: networkReachability)
        }
      }
    }, &context) == true else { return false }
    
    guard SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue) == true else { return false }
    
    notifying = true
    return notifying
  }
  
  /// Stop notifying, we just unschedule the network reachability reference from the run loop.
  func stopNotifier() {
    if let reachability = networkReachability, notifying == true {
      SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode as! CFString)
      notifying = false
    }
  }
  

  /// Deinit
  deinit {
    stopNotifier()
  }
  
  /// Computed property that will get the current flags of the SCNetworkReachability object.
  private var flags: SCNetworkReachabilityFlags {
    
    var flags = SCNetworkReachabilityFlags(rawValue: 0)
    
    if let reachability = networkReachability, withUnsafeMutablePointer(to: &flags, { SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0)) }) == true {
      return flags
    }
    else {
      return []
    }
  }
  
  /// Method that is able to return the reachability status for the set of flags passed to it.
  var currentReachabilityStatus: ReachabilityStatus {
    
    if flags.contains(.reachable) == false {
      // The target host is not reachable.
      return .notReachable
    }
    else if flags.contains(.isWWAN) == true {
      // WWAN connections are OK if the calling application is using the CFNetwork APIs.
      return .reachableViaWWAN
    }
    else if flags.contains(.connectionRequired) == false {
      // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
      return .reachableViaWiFi
    }
    else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
      // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
      return .reachableViaWiFi
    }
    else {
      return .notReachable
    }
  }
  
  /// Method to determine the reachability status of the current flags of our network reachability reference, and a computed property to verify if we are connected or not.
  var isReachable: Bool {
    switch currentReachabilityStatus {
    case .notReachable:
      return false
    case .reachableViaWiFi, .reachableViaWWAN:
      return true
    }
  }
  
}
