cask "framescrub@edge" do
  # The latest builds that passed CI, not releases: main's, in the pre-release `edge`: arm64 on Apple Silicon, x86_64 on
  # Intel (macOS 26). FrameScrub's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.3.0-0-gd517309" # arm
    sha256 "49087308473e9e4224ce1833ab6ff1d7c050853d804f590d32b5dc66cf8c88f6" # arm

    url "https://github.com/ampire5/FrameScrub/releases/download/edge/FrameScrub-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.3.0-0-gd517309" # intel
    sha256 "8278ae2e17fbcd69676c5c2a42aba597d108f99b8b410d33a9c8314d4b0e5929" # intel

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
