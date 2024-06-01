//
//  WatchContentViewModel.swift
//  AppleWatchTest Watch App
//
//  Created by 新川竜司 on 2024/06/01.
//

import WatchConnectivity

final class WatchContentViewModel: NSObject, ObservableObject {

    @Published var counter = 0
    
    private let session: WCSession

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
    
    /// 直ちにカウントを送信
    /// - Parameter count: カウンタの値
    func sendImmediately(count: Int) {
        guard session.activationState == .activated else {
            print("Sending method can only be called while the session is active.")
            return
        }
        
        Task.detached(priority: .medium) { [self] in
            let message = [
                "count" : count
            ] as [String : Any]
            
            self.session.sendMessage(message, replyHandler: nil) { error in
                print(error)
            }
        }
    }
}

extension WatchContentViewModel: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        Task { @MainActor in
            if let value = userInfo["count"] as? Int {
                counter = value
            }
        }
    }
}
