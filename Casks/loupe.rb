cask "loupe" do
  # Both from main's releases: arm64 on Apple Silicon, x86_64 on Intel (macOS 26).
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.2.1" # arm
    sha256 "99c909274b69dad34da14511100c95b08fbd5b13adeeafbe235654f0a43bba5f" # arm

    url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.2.0" # intel
    sha256 "8c981978941ebe1538100f182a48727737ad3e885303c1a74eb8e79183606e43" # intel

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
