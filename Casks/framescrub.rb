cask "framescrub" do
  # Both from main's releases: arm64 on Apple Silicon, x86_64 on Intel (macOS 26). FFmpeg is built in.
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.2.0" # arm
    sha256 "f4b8440874738c6865767b15697742bc48ba56ba5bd0f2c926311a1e9ef1f712" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.2.0" # intel
    sha256 "5b43b16d077e8f3418b4e876d13a574a4dfdfc098bbdcafe4db96706c8829881" # intel

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-x86_64.zip"
  end

  name "FrameScrub"
  desc "Frame-accurate video player with instant backward scrubbing and Stash integration"
  homepage "https://github.com/ampire5/FrameScrub"

  conflicts_with cask: "framescrub@edge"
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
