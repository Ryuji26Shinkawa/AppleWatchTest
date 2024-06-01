//
//  PhoneContentViewModel.swift
//  AppleWatchTest
//
//  Created by 新川竜司 on 2024/06/01.
//

import WatchConnectivity

final class PhoneContentViewModel: NSObject, ObservableObject {
    
    @Published var counter = 0
    
    private let session: WCSession
    
    // Watch Connectivityの初期化
    init(session: WCSession = .default) {
        // WCSession を作成する
        self.session = session
        super.init()
        // WCSessionDelegate を設定する
        self.session.delegate = self
        // WCSession.activate() を呼ぶ
        self.session.activate()
    }
    
    func countup() {
        counter += 1
    }
    
    func countdown() {
        counter -= 1
    }
    
    /// カウントを送信
    /// - Parameter count: カウンタの値
    /// - Warning: シミュレータでの実行は不可
    func send(count: Int) {
        guard session.activationState == .activated else {
            print("Sending method can only be called while the session is active.")
            return
        }

        Task.detached(priority: .medium) { [self] in
            let userInfo = [
                "count" : count
            ] as [String : Any]
            
            session.transferUserInfo(userInfo)
        }
    }
}

extension PhoneContentViewModel: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        Task { @MainActor in
            if let value = message["count"] as? Int {
                counter = value
            }
        }
    }
}
