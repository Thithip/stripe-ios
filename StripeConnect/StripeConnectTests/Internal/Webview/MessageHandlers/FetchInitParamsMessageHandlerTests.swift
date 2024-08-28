//
//  FetchInitParamsMessageHandlerTests.swift
//  StripeConnectTests
//
//  Created by Chris Mays on 8/13/24.
//

@testable import StripeConnect
import XCTest

class FetchInitParamsMessageHandlerTests: ScriptWebTestBase {
    
    @MainActor
    func testMessageSend() async throws {
        let expectation = self.expectation(description: "Message received")
        let message = FetchInitParamsMessageHandler.Reply(locale: "en")
        webView.addMessageReplyHandler(messageHandler: FetchInitParamsMessageHandler(didReceiveMessage: { _ in
            return message
        }), verifyResult: { result in
            XCTAssertEqual(result, message)
            expectation.fulfill()
        })
        
        try await webView.evaluateMessageWithReply(name: "fetchInitParams",
                                           json: "{}")
        await fulfillment(of: [expectation], timeout: 0.2)
    }
}