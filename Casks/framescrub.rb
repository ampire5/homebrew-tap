cask "framescrub" do
  # Apple Silicon: main's releases. Intel: the lts/macos26 line (macOS 26; FFmpeg built in for FrameScrub).
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.1.0" # arm
    sha256 "92e8c4c8c8258781003e307cc57699b47539701843d8e95c82828793fec14a2b" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-arm64.zip"

    # The Intel build has FFmpeg built in.
    depends_on formula: "ffmpeg"
  end
  on_intel do
    version "0.1.0-lts" # intel
    sha256 "0f881da2f7cab99b151543fe80eb54e2b070bbcbce3b0273f56f32391797de13" # intel

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-x86_64.zip"
  end

  name "FrameScrub"
  desc "Frame-accurate video player with instant backward scrubbing and Stash integration"
  homepage "https://github.com/ampire5/FrameScrub"

  conflicts_with cask: "framescrub@edge"
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
