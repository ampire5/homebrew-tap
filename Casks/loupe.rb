cask "loupe" do
  # Both from main's releases: arm64 on Apple Silicon, x86_64 on Intel (macOS 26).
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.6.0" # arm
    sha256 "85399c38980ca55aaa807b8855062bc1e75f1c4a236a50ff81f518229c94dab7" # arm

    url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.5.0" # intel
    sha256 "681c7d8c5ee6600d635422fb868b39d0443712e3240bbeafe562dffef4a1c194" # intel

    url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-x86_64.zip"
  end

  name "Loupe"
  desc "Metal image viewer for huge photos, with Stash integration"
  homepage "https://github.com/ampire5/Loupe"

  conflicts_with cask: "loupe@edge"
  depends_on macos: :tahoe

  app "Loupe.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Loupe.app"]
  end

  zap trash: [
    "~/.config/loupe",
    "~/Library/Application Support/Loupe",
    "~/Library/Caches/Loupe",
    "~/Library/Caches/local.loupe",
    "~/Library/Preferences/local.loupe.plist",
  ]

  caveats <<~EOS
    Loupe is not signed with an Apple Developer ID yet. This cask removes the quarantine flag so macOS opens it.
  EOS
end
