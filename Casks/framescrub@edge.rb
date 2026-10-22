cask "framescrub@edge" do
  # The latest builds that passed CI, not releases: main's on Apple Silicon (pre-release `edge`), lts/macos26's on
  # Intel (`edge-lts`). FrameScrub's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0" # arm
    sha256 :no_check # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0" # intel
    sha256 :no_check # intel

    url "https://github.com/ampire5/FrameScrub/releases/download/edge-lts/FrameScrub-#{version}-macOS-x86_64.zip"
  end

  name "FrameScrub (edge)"
  desc "Frame-accurate video player with instant backward scrubbing and Stash integration (latest build)"
  homepage "https://github.com/ampire5/FrameScrub"

  conflicts_with cask: "framescrub"
  depends_on macos: ">= :tahoe"

  app "FrameScrub.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/FrameScrub.app"]
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
