cask "loupe@edge" do
  # The latest builds that passed CI, not releases: main's on Apple Silicon (pre-release `edge`), lts/macos26's on
  # Intel (`edge-lts`). Loupe's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.1.0-25-g6b52088" # arm
    sha256 "1f56aa29810596576b7fa92de1de6f269a571cf34383db0fa26280d190f8972b" # arm

    url "https://github.com/ampire5/Loupe/releases/download/edge/Loupe-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.1.0-lts-10-gca04447" # intel
    sha256 "8f3ab62ade05a736a8e9a27fbe3a554ba9536ad608e9833d75d1321fcc88848c" # intel

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
