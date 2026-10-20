cask "loupe" do
  version "0.1.0"
  sha256 :no_check # set by the Loupe release workflow

  url "https://github.com/ampire5/Loupe/releases/download/v#{version}/Loupe-v#{version}-macOS-arm64.zip"
  name "Loupe"
  desc "Metal image viewer for huge photos, with Stash integration"
  homepage "https://github.com/ampire5/Loupe"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "Loupe.app"

  # The app is not signed with a Developer ID yet; without this macOS refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Loupe.app"]
  end

  zap trash: [
    "~/.config/loupe",
    "~/Library/Application Support/Loupe",
    "~/Library/Caches/Loupe",
  ]

  caveats <<~EOS
    Loupe is not signed with an Apple Developer ID yet. This cask removes the quarantine flag so macOS opens it.
  EOS
end
