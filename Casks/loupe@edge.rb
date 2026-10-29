cask "loupe@edge" do
  # The latest builds that passed CI, not releases: main's, in the pre-release `edge`: arm64 on Apple Silicon, x86_64 on
  # Intel (macOS 26). Loupe's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.2.0-0-gc4705d4" # arm
    sha256 "f623cc107e2272a85a4437794e4393b0183640fe3d67d3f2f370a7c6cb94c45e" # arm

    url "https://github.com/ampire5/Loupe/releases/download/edge/Loupe-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.2.0-0-gc4705d4" # intel
    sha256 "3553cf8d036c532ede0fd33b5ff1f904e3f752e9e5b99e76678754fd94395b5e" # intel

    url "https://github.com/ampire5/Loupe/releases/download/edge/Loupe-#{version}-macOS-x86_64.zip"
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
