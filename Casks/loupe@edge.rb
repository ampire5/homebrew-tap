cask "loupe@edge" do
  # The latest builds that passed CI, not releases: main's, in the pre-release `edge`: arm64 on Apple Silicon, x86_64 on
  # Intel (macOS 26). Loupe's edge workflow rewrites the lines marked `# arm` and `# intel` after every build.
  on_arm do
    version "0.2.1-0-ge5491be" # arm
    sha256 "675cd77b29215db352063bf9786957b70fbc82fdc3018af65429f7abb999c227" # arm

    url "https://github.com/ampire5/Loupe/releases/download/edge/Loupe-#{version}-macOS-arm64.zip"
  end
  on_intel do
    version "0.2.1-0-ge5491be" # intel
    sha256 "9f6e4b2114c2b9ad6ea45f6bc218bb4e987b55a0fb9bc84a5629780ad43dc6cd" # intel

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
