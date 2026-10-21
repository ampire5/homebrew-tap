cask "loupe" do
  # Apple Silicon: main's releases. Intel: the lts/macos26 line (macOS 26).
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.1.0" # arm
    sha256 "5a4fbea982bd3675c4f4570437705aa6b012256858811432db13709ae6dddd0b" # arm

    url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.1.0-lts" # intel
    sha256 :no_check # intel

    url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-x86_64.zip"
  end

  name "Loupe"
  desc "Metal image viewer for huge photos, with Stash integration"
  homepage "https://github.com/ampire5/Loupe"

  depends_on macos: ">= :tahoe"

  app "Loupe.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Loupe.app"]
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
