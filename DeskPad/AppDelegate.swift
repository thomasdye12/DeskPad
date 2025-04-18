import Cocoa
import ReSwift

enum AppDelegateAction: Action {
    case didFinishLaunching
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
     var display: [CGVirtualDisplay] = []
    func applicationDidFinishLaunching(_: Notification) {
//        let viewController = ScreenViewController()
//        window = NSWindow(contentViewController: viewController)
//        window.delegate = viewController
//        window.title = "TDS DeskPad"
//        window.makeKeyAndOrderFront(nil)
//        window.titlebarAppearsTransparent = true
//        window.isMovableByWindowBackground = true
//        window.titleVisibility = .hidden
//        window.backgroundColor = .white
//        window.contentMinSize = CGSize(width: 400, height: 300)
//        window.contentMaxSize = CGSize(width: 3840, height: 2160)
//        window.styleMask.insert(.resizable)
//        window.collectionBehavior.insert(.fullScreenNone)

        let mainMenu = NSMenu()
        let mainMenuItem = NSMenuItem()
        let subMenu = NSMenu(title: "MainMenu")
        let quitMenuItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApp.terminate),
            keyEquivalent: "q"
        )
        let NewScreenMenuItem = NSMenuItem(
            title: "New Screen",
            action: #selector(CreateScreen),
            keyEquivalent: "N"
        )
        let removeScreenMenuItem = NSMenuItem(
            title: "Remove Screen",
            action: #selector(RemoveScreen),
            keyEquivalent: "R"
        )

        subMenu.addItem(NewScreenMenuItem)
        subMenu.addItem(removeScreenMenuItem)
        subMenu.addItem(quitMenuItem)
        mainMenuItem.submenu = subMenu
        mainMenu.items = [mainMenuItem]
        NSApplication.shared.mainMenu = mainMenu

        store.dispatch(AppDelegateAction.didFinishLaunching)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        return false
    }
    
    @objc func CreateScreen(){
        let descriptor = CGVirtualDisplayDescriptor()
        descriptor.setDispatchQueue(DispatchQueue.main)
        descriptor.name = "DeskPad Display \(self.display.count)"
        descriptor.maxPixelsWide = 3840
        descriptor.maxPixelsHigh = 2160
        descriptor.sizeInMillimeters = CGSize(width: 1600, height: 1000)
        descriptor.productID = 0x1234
        descriptor.vendorID = 0x3456
        descriptor.serialNum = 0x0001
     
        let display = CGVirtualDisplay(descriptor: descriptor)
        self.display.append(display)
//        store.dispatch(ScreenViewAction.setDisplayID(display.displayID))
        let settings = CGVirtualDisplaySettings()
        settings.hiDPI = 1
        settings.modes = [
            CGVirtualDisplayMode(width: 1728, height: 1117, refreshRate: 60),
            // 16:9
            CGVirtualDisplayMode(width: 3840, height: 2160, refreshRate: 60),
            CGVirtualDisplayMode(width: 2560, height: 1440, refreshRate: 60),
            CGVirtualDisplayMode(width: 1920, height: 1080, refreshRate: 60),
            CGVirtualDisplayMode(width: 1600, height: 900, refreshRate: 60),
            CGVirtualDisplayMode(width: 1366, height: 768, refreshRate: 60),
            CGVirtualDisplayMode(width: 1280, height: 720, refreshRate: 60),
            // 16:10
            CGVirtualDisplayMode(width: 2560, height: 1600, refreshRate: 60),
            CGVirtualDisplayMode(width: 1920, height: 1200, refreshRate: 60),
            CGVirtualDisplayMode(width: 1680, height: 1050, refreshRate: 60),
            CGVirtualDisplayMode(width: 1440, height: 900, refreshRate: 60),
            CGVirtualDisplayMode(width: 1280, height: 800, refreshRate: 60),
        ]
        display.apply(settings)
    }
    
    
    @objc func RemoveScreen(){
        self.display.popLast()
        
    }
}
