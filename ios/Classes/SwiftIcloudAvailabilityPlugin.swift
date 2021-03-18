import Flutter
import UIKit

public class SwiftIcloudAvailabilityPlugin: NSObject, FlutterPlugin {
    var streamHandler: StreamHandler?
    var messenger: FlutterBinaryMessenger?
    var queue = OperationQueue()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger();
        let channel = FlutterMethodChannel(name: "icloud_availability", binaryMessenger: messenger)
        let instance = SwiftIcloudAvailabilityPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.messenger = messenger
        
        let eventChannel = FlutterEventChannel(name: "icloud_availability/event", binaryMessenger: registrar.messenger())
        instance.streamHandler = StreamHandler()
        eventChannel.setStreamHandler(instance.streamHandler)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isAvailable":
            isAvailable(call, result)
        case "watchAvailable":
            isAvailable(call, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func isAvailable(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(FileManager.default.ubiquityIdentityToken != nil)
    }
    
    private func watchAvailable(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(nil)
        streamHandler?.onCancelHandler = { [self] in
            removeObservers()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSUbiquityIdentityDidChange, object: nil, queue: queue) {
            [self] (notification) in
            streamHandler?.setEvent(FileManager.default.ubiquityIdentityToken != nil)
        }
    }
    
    private func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSUbiquityIdentityDidChange, object: nil)
    }
}

class StreamHandler: NSObject, FlutterStreamHandler {
    private var _eventSink: FlutterEventSink?
    var onCancelHandler: (() -> Void)?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        DebugHelper.log("on listen")
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        onCancelHandler?()
        _eventSink = nil
        DebugHelper.log("on cancel")
        return nil
    }
    
    func setEvent(_ data: Any) {
        _eventSink?(data)
    }
}

class DebugHelper {
    public static func log(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}

