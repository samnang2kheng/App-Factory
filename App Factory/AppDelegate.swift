import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet var buildAppButton: NSButton!
    @IBOutlet var scriptDrop: IAScriptDrop!
    @IBOutlet var iconDrop: IAIconDrop!
    
    @IBAction func buildAppClicked(sender : AnyObject) {
        if self.scriptDrop.scriptPath != nil {
            let savePanel = NSSavePanel()
            savePanel.extensionHidden = true
            savePanel.allowsOtherFileTypes = false
            savePanel.nameFieldStringValue = String(self.scriptDrop.scriptPath.URLByDeletingPathExtension!.lastPathComponent!)
            
            savePanel.beginWithCompletionHandler({ (response) -> Void in
                if response == NSFileHandlingPanelOKButton {
                    let converter: ScriptConverter = ScriptConverter(
                        path: scriptDrop.scriptPath,
                        savePath: savePanel.URL,
                        iconPath: self.iconDrop.iconPath
                    )
                    converter.createApp();
                }
            })
        }
        else {
            let alert: NSAlert = NSAlert()
            alert.messageText = "No script selected"
            alert.addButtonWithTitle("OK")
            alert.informativeText = "Please select a script file"
            alert.runModal()
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(theApplication: NSApplication) -> Bool {
        return true;
    }
}

