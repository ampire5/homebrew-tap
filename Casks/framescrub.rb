cask "framescrub" do
  # Both from main's releases: arm64 on Apple Silicon, x86_64 on Intel (macOS 26). FFmpeg is built in.
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.4.1" # arm
    sha256 "b3b0d4d6fc1df856138d264d97cbdd3515ef3e45e62d7b32be20a30565ee4368" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.3.0" # intel
    sha256 "30716e128a18293b5af5a27c0a9923238deaa47bdf313203fb78ccb7d49e3c6f" # intel

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
