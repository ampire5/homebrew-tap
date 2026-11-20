cask "framescrub@edge" do
  # The latest builds that passed CI, not releases: main's, in the pre-release `edge`: arm64 on Apple Silicon, x86_64 on
  # Intel (macOS 26). FrameScrub's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.6.0-0-ge97e81a" # arm
    sha256 "1f0071c8691d139a115c27bd3e25ce0a43ae8b4b17b3121751732cfcd782712b" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.6.0-0-ge97e81a" # intel
    sha256 "663ead85ca4f2b2af30e423635c53fef0a23dc7370966a185b9db9c11b552ac3" # intel

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-x86_64.zip"
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
