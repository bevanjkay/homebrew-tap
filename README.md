# bevanjkay's Homebrew Tap

This repo contains an assortment of casks for personal use, and a number of casks for use in professional audio-visual production environments.
Includes casks for Blackmagic Design software.

## How do I install these casks?

`brew install bevanjkay/tap/<cask>`

Or `brew tap bevanjkay/tap` and then `brew install <cask>`.

## CI cask check exceptions

After installing and uninstalling a cask, CI diffs a before/after snapshot of installed apps,
kexts, packages and launch jobs, and fails on anything left behind. Some casks legitimately leave
a shared package in place — one that other casks depend on, and that is therefore only removed by
`zap` — which previously had to be silenced with the blunt `ci-skip-install` label.

`.github/cask_check_exceptions.json` declares those expected leftovers instead, so the cask still
gets a real install/uninstall run in CI. Keys are `File.fnmatch?` globs over cask tokens, and
values map a check name to a list of regular expressions:

```json
{
  "bmd-*": {
    "installed_pkgs": ["^com\\.blackmagic-design\\.Example$"],
    "installed_apps": ["^/Applications/Blackmagic Example/"]
  }
}
```

Valid check names are `installed_apps`, `installed_kexts`, `installed_pkgs`, `installed_launchjobs`
and `loaded_launchjobs`. Entries from every matching glob are merged.

Note that `installed_pkgs` and `installed_apps` are coupled: the check subtracts the file list of
newly-added packages from the leftover-app list, so excepting a package usually means also
excepting the apps that package installs.

To find the identifiers for a new exception, run the CI workflow manually against the cask with
`skip_install` unchecked and read them out of the resulting annotation.

This works by applying `.github/patches/homebrew-cask-check.patch` to Homebrew Cask's
`cmd/lib/check.rb` at the start of each CI job. If a Homebrew Cask change ever makes that patch stop
applying, the `Patch Homebrew Cask CI checks` step fails and the patch needs refreshing.
