cask "framescrub" do
  # Both from main's releases: arm64 on Apple Silicon, x86_64 on Intel (macOS 26). FFmpeg is built in.
  # The release workflows rewrite the lines marked `# arm` and `# intel`.
  on_arm do
    version "0.5.0" # arm
    sha256 "9bb8cf3d2802b6490a8b0396bf7824b5b389ff453cde4898e5046eabc9253f3a" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.5.0" # intel
    sha256 "6a590679f8ea222d9b2e87ca56daf1e9461a35bda84d57055f0c962c09a83cab" # intel

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
