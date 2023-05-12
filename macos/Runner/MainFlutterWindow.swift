import Cocoa
import FlutterMacOS
import bitsdojo_window_macos // Add this line

class MainFlutterWindow: BitsdojoWindow  {

    override func bitsdojo_window_configure() -> UInt {
//      return BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP
//      需要去掉 否则默认隐藏
        return BDW_CUSTOM_FRAME
    }

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
