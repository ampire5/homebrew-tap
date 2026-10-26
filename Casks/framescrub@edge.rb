cask "framescrub@edge" do
  # The latest builds that passed CI, not releases: main's, in the pre-release `edge`: arm64 on Apple Silicon, x86_64 on
  # Intel (macOS 26). FrameScrub's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.1.0-91-gec060c8" # arm
    sha256 "fad95f8feb9dc041b503125eac6b831b580c4ee32b43c661a1e27788b256fc36" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.1.0-91-gec060c8" # intel
    sha256 "6ef557e0f264f94b9930be468c0d658caeb47b6c0d3de71181f3a029a6a5a823" # intel

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
