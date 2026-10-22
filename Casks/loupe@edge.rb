cask "loupe@edge" do
  # The latest builds that passed CI, not releases: main's on Apple Silicon (pre-release `edge`), lts/macos26's on
  # Intel (`edge-lts`). Loupe's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.1.0-22-g5e5cd47" # arm
    sha256 "018625030d2802ff1119cf520f70c3e59e095fe9414ba56cbdb456a152e3a07a" # arm

    url "https://github.com/ampire5/Loupe/releases/download/edge/Loupe-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.1.0-lts-8-gf2f5f20" # intel
    sha256 "3f116a0a99eccf225af98f0672a0ddc493c0c8211b77b61001f4ee5f9e336564" # intel

    url "https://github.com/ampire5/Loupe/releases/download/edge-lts/Loupe-#{version}-macOS-x86_64.zip"
  end

  name "Loupe (edge)"
  desc "Metal image viewer for huge photos, with Stash integration (latest build)"
  homepage "https://github.com/ampire5/Loupe"

  conflicts_with cask: "loupe"
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
