cask "framescrub" do
  version "0.1.0"
  sha256 :no_check # set by the FrameScrub release workflow

  url "https://github.com/ampire5/FrameScrub/releases/download/v#{version}/FrameScrub-v#{version}-macOS-arm64.zip"
  name "FrameScrub"
  desc "Frame-accurate video player with instant backward scrubbing and Stash integration"
  homepage "https://github.com/ampire5/FrameScrub"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"
  depends_on formula: "ffmpeg"

  app "FrameScrub.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/FrameScrub.app"]
  end

  zap trash: [
    "~/.config/framescrub",
    "~/Library/Application Support/FrameScrub",
  ]

  caveats <<~EOS
    FrameScrub is not signed with an Apple Developer ID yet. This cask removes the quarantine flag so macOS opens it.
  EOS
end
