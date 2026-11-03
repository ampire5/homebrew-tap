cask "mouseservice" do
  version "0.2.2"
  sha256 "029ac607cc252e6cdea6c3fd9d57681cf6f1ed70a5dd493107762e253000d880"

  url "https://github.com/ampire5/MouseService/releases/download/v#{version}/MouseService-v#{version}-macOS-universal.zip"
  name "MouseService"
  desc "Mouse settings, gestures and shared Logitech controls"
  homepage "https://github.com/ampire5/MouseService"

  depends_on macos: :tahoe

  app "MouseService.app"

  # No Developer ID signature yet; match the other apps in this tap.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MouseService.app"]
  end

  uninstall launchctl: "local.mouseservice",
            quit:      "local.mouseservice",
            delete:    "~/Library/LaunchAgents/local.mouseservice.plist"

  zap trash: [
    "~/.config/mouseservice",
    "~/Library/Preferences/local.mouseservice.plist",
  ]

  caveats <<~EOS
    Open MouseService once to register its background service and login startup:
      open "#{appdir}/MouseService.app"
    Allow MouseService in System Settings > Privacy & Security > Accessibility.
    After upgrading, open the app again to restart the service. Its ad hoc signature may require granting Accessibility again.
    If a source build exists in ~/Applications, remove that copy before opening this one.
  EOS
end
