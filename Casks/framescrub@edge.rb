cask "framescrub@edge" do
  # The latest builds that passed CI, not releases: main's on Apple Silicon (pre-release `edge`), lts/macos26's on
  # Intel (`edge-lts`). FrameScrub's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.1.0-25-g1f5c266" # arm
    sha256 "13811de82df0969525de19e9edda8280e25672a3a86c9ebde2e6dd7c7af1f6c5" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.1.0-lts-9-g21e143f" # intel
    sha256 "8708b2784ecc3ca553a19f3d8d72263eea355fcb6084fa57a090a787f632b77a" # intel

    url "https://github.com/ampire5/FrameScrub/releases/download/edge-lts/FrameScrub-#{version}-macOS-x86_64.zip"
  end

  name "FrameScrub (edge)"
  desc "Frame-accurate video player with instant backward scrubbing and Stash integration (latest build)"
  homepage "https://github.com/ampire5/FrameScrub"

  conflicts_with cask: "framescrub"
  depends_on macos: :tahoe

  app "FrameScrub.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/FrameScrub.app"]
  end

  zap trash: [
    "~/.config/framescrub",
    "~/Library/Application Support/FrameScrub",
    "~/Library/Preferences/local.framescrub.plist",
  ]

  caveats <<~EOS
    FrameScrub is not signed with an Apple Developer ID yet. This cask removes the quarantine flag so macOS opens it.
  EOS
end
