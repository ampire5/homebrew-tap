# ampire5's Homebrew tap

```sh
brew install --cask ampire5/tap/loupe        # Metal image viewer for huge photos
brew install --cask ampire5/tap/framescrub   # frame-accurate video player
```

- [Loupe](https://github.com/ampire5/Loupe) — opens a 300-megapixel photo, fully sharp, in under a second; Stash integration.
- [FrameScrub](https://github.com/ampire5/FrameScrub) — scrubs 4K forward and backward without waiting; Stash integration.

Apple Silicon with macOS 26+, and Intel Macs with macOS 26 (the apps' `lts/macos26` line). The apps are not yet signed with an Apple Developer ID; the casks clear the quarantine flag so
macOS opens them.

## Edge builds

The latest builds that passed CI, not releases: unsigned, for testing. Apple Silicon gets main's builds, Intel the
`lts/macos26` line's. An edge cask replaces the release cask and back; settings and data stay.

```sh
brew uninstall --cask loupe                      # if the release is installed: the two casks conflict
brew install --cask ampire5/tap/loupe@edge
brew install --cask ampire5/tap/framescrub@edge
brew update && brew upgrade --cask loupe@edge framescrub@edge   # every new build
```

`brew list --cask --versions loupe@edge` shows the build you have: `0.1.0-22-g5e5cd47` is 22 commits after 0.1.0, at
commit `5e5cd47`. Back to the releases: `brew uninstall --cask loupe@edge && brew install --cask ampire5/tap/loupe`.

### If something goes wrong

The commands are for Loupe; for FrameScrub use `framescrub@edge`, `~/.config/framescrub` and `FrameScrub.app`.

- **`brew upgrade` finds nothing new.** Homebrew updates the tap only now and then: `brew update` first.
- **`404 Not Found` while downloading.** Only the newest zip is kept, so your copy of the tap points at one that is gone
  (or a build is being published right now, which takes a minute): `brew update`, then install or upgrade again.
- **`SHA256 mismatch`.** The same build was published again with a new zip. `brew update`, delete the stale download,
  try again:

  ```sh
  rm -f "$(brew --cache --cask loupe@edge)"
  brew upgrade --cask loupe@edge
  ```

- **`Cask 'loupe' conflicts with 'loupe@edge'`.** Only one of the two can be installed: uninstall the other first.
- **"Loupe can't be opened" or "is damaged".** The quarantine flag is still on the app (e.g. it came from the zip
  on Releases, not the cask): `xattr -dr com.apple.quarantine /Applications/Loupe.app`.
- **A half-installed or broken app.** `brew reinstall --cask loupe@edge`. If Homebrew insists it is installed while the
  app is gone: `brew uninstall --force --cask loupe@edge`, then install again.
- **The build itself is broken** (crashes, a feature stopped working). Go back to the release (above) and wait for the
  next build; older edge builds are not kept. Please [report it](https://github.com/ampire5/Loupe/issues/new?template=bug_report.yml)
  ([FrameScrub](https://github.com/ampire5/FrameScrub/issues/new?template=bug_report.yml)) with the version from
  `brew list --cask --versions`, your Mac and macOS version.
- **It misbehaves even on the release.** Your settings may be the cause. Move them aside rather than deleting them,
  and the app starts with the defaults: `mv ~/.config/loupe ~/.config/loupe.bak` (quit the app first). Everything,
  including Recent and the thumbnail cache, goes with `brew uninstall --zap --cask loupe@edge` (or `loupe`).
