# ampire5's Homebrew tap

```sh
brew install --cask ampire5/tap/loupe        # Metal image viewer for huge photos
brew install --cask ampire5/tap/framescrub   # frame-accurate video player
```

- [Loupe](https://github.com/ampire5/Loupe) — opens a 300-megapixel photo, fully sharp, in under a second; Stash integration.
- [FrameScrub](https://github.com/ampire5/FrameScrub) — scrubs 4K forward and backward without waiting; Stash integration.

The latest builds that passed CI, not releases (unsigned, for testing; they replace the release casks and back):

```sh
brew install --cask ampire5/tap/loupe@edge
brew install --cask ampire5/tap/framescrub@edge
brew update && brew upgrade --cask loupe@edge framescrub@edge   # every new build
```

Back to the releases: `brew uninstall --cask loupe@edge && brew install --cask ampire5/tap/loupe` (settings stay).

Apple Silicon with macOS 26+, and Intel Macs with macOS 26 (the apps' `lts/macos26` line). The apps are not yet signed with an Apple Developer ID; the casks clear the quarantine flag so
macOS opens them.
