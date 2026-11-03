cask "mouseservice" do
  version "0.3.0"
  sha256 "e917e6fab363cabc006661f2159f3c138dbafc29555fdf450fe2ac312497977c"

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
