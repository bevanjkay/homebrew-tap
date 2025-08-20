# Homebrew Tap - bevanjkay/tap

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

This repository is a Homebrew tap containing macOS casks (app installers) and custom Homebrew commands for professional audio-visual production environments and personal use. It includes specialized casks for Blackmagic Design software and other professional tools.

**Repository Contents**: 57 casks + 7 custom commands = 64 total Ruby files

## Critical Requirements

**NEVER CANCEL BUILDS OR LONG-RUNNING COMMANDS** - Operations may take up to 30 minutes. Always set timeouts to 45+ minutes for any testing operations.

**macOS REQUIREMENT**: This tap is designed for macOS only. Most functionality requires macOS to fully test and validate. Casks cannot be installed on Linux.

## Working Effectively

### Initial Setup
```bash
# Install Homebrew (macOS/Linux)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Configure environment variables
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_DEVELOPER=1

# Add the tap (for testing)
brew tap bevanjkay/tap
```

### Testing and Validation
```bash
# Check Ruby syntax of all files - takes 1-2 seconds. NEVER CANCEL. Set timeout to 30+ seconds.
find cmd -name "*.rb" -exec ruby -c {} \;
find Casks -name "*.rb" -exec ruby -c {} \;

# Audit a specific cask - takes 1-5 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
# REQUIRES NETWORK CONNECTIVITY
brew audit --cask --strict <cask-name>

# Audit all casks in the tap - takes 10-30 minutes. NEVER CANCEL. Set timeout to 45+ minutes.
# REQUIRES NETWORK CONNECTIVITY
brew audit --cask --tap bevanjkay/tap

# Style check and fix - takes 2-5 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
# REQUIRES NETWORK CONNECTIVITY for gem installation
brew style --fix cmd/open-repo.rb
brew style --fix Casks/ffmpeg-static.rb

# Test cask installation (macOS only) - takes 5-30 minutes. NEVER CANCEL. Set timeout to 45+ minutes.
# REQUIRES NETWORK CONNECTIVITY
brew install --cask bevanjkay/tap/ffmpeg-static
brew uninstall --cask ffmpeg-static

# Test custom commands (requires tap to be installed)
# REQUIRES NETWORK CONNECTIVITY
brew open-repo ffmpeg
brew gui-install <cask-token>
brew font-artifact-updater <font-cask-token>
```

### Build and CI Operations
- **Syntax validation**: 1-2 seconds - Set timeout to 30+ seconds minimum
- **Single cask audit**: 1-5 minutes - Set timeout to 10+ minutes  
- **Full tap audit**: 10-30 minutes - Set timeout to 45+ minutes
- **Cask installation test**: 5-30 minutes - Set timeout to 45+ minutes
- **CI pipeline**: Up to 30 minutes per cask - Set timeout to 45+ minutes

**OFFLINE CAPABILITIES**: Only Ruby syntax validation works without network connectivity. All other operations require internet access.

## Repository Structure

### Key Directories
- `Casks/`: 57+ macOS app installer definitions
- `cmd/`: 6 custom Homebrew commands
- `.github/workflows/`: CI/CD pipelines
- `audit_exceptions/`: Audit rule exceptions
- `cmd/lib/`: Custom download strategies

### Custom Commands
Located in `cmd/` directory:
- `open-repo.rb`: Opens GitHub repository of a formula
- `gui-install.rb`: Installs cask and opens manual installer
- `font-artifact-updater.rb`: Updates font artifacts automatically  
- `disable-deprecated-packages.rb`: Manages deprecated packages
- `ls-no-autobump.rb`: Lists packages without autobump
- `remove-disabled-autobump.rb`: Removes disabled packages

## Manual Validation Requirements

After making changes to casks, ALWAYS perform these validation steps:

### Quick Validation Script
```bash
#!/bin/bash
# Run this script to validate repository health
set -e
echo "=== Homebrew Tap Validation ==="

# Syntax validation (WORKS OFFLINE - 1-2 seconds)
echo "Checking Ruby syntax..."
find cmd -name "*.rb" -exec ruby -c {} \; >/dev/null 2>&1
find Casks -name "*.rb" -exec ruby -c {} \; >/dev/null 2>&1
echo "✓ All Ruby files have valid syntax"

# Count and report
CMD_COUNT=$(find cmd -name "*.rb" | wc -l)
CASK_COUNT=$(find Casks -name "*.rb" | wc -l)
echo "✓ Validated ${CMD_COUNT} command files and ${CASK_COUNT} cask files"

echo "=== Validation Complete ==="
```

### For Regular Casks
```bash
# 1. Audit the cask - NEVER CANCEL, wait 10+ minutes
# REQUIRES NETWORK CONNECTIVITY
brew audit --cask --strict <cask-name>

# 2. Test installation on macOS (if available)
# REQUIRES NETWORK CONNECTIVITY
brew install --cask <cask-name>
# Verify the app launches successfully
open "/Applications/<App Name>.app"
# Test basic functionality
brew uninstall --cask <cask-name>
```

### For Custom Commands  
```bash
# 1. Check syntax
ruby -c cmd/<command-name>.rb

# 2. Test command functionality
brew <command-name> --help
brew <command-name> <test-parameters>
```

### For GitHub Workflows
```bash
# Lint workflow files
brew install actionlint
actionlint .github/workflows/*.yml
```

## Common Tasks and Timing

### Adding a New Cask
1. Create `Casks/<cask-name>.rb` - 5 minutes
2. Test syntax: `ruby -c Casks/<cask-name>.rb` - 5 seconds
3. Audit: `brew audit --cask --strict <cask-name>` - 1-5 minutes, timeout 10+ minutes
4. Test install: `brew install --cask <cask-name>` - 5-30 minutes, timeout 45+ minutes
5. Style fix: `brew style --fix Casks/<cask-name>.rb` - 30 seconds, timeout 2+ minutes

### Updating an Existing Cask
1. Modify version, sha256, and URL - 2 minutes
2. Test: Same validation as new cask - 6-35 minutes total, timeout 45+ minutes

### Testing Custom Commands
1. Syntax check: `ruby -c cmd/<command>.rb` - 5 seconds  
2. Install tap locally for testing - 1 minute
3. Test command: `brew <command> <args>` - 1-5 minutes, timeout 10+ minutes

## CI Pipeline Behavior

The `.github/workflows/ci.yml` pipeline:
- Runs on macOS runners
- Tests each cask individually with 30-minute timeouts
- Performs audit, fetch, install, and uninstall tests
- NEVER CANCEL - Full pipeline can take several hours for all casks

Common timeout settings in CI:
- Fetch operations: 30 minutes
- Audit operations: 30 minutes  
- Install/uninstall: 30 minutes each

## Validation Scenarios

### Essential Test Cases
1. **Cask Installation Flow**: Install → Launch app → Basic functionality → Uninstall
2. **Custom Command Testing**: Help output → Real usage with sample data → Verify results
3. **Audit Compliance**: All casks must pass `brew audit --cask --strict`
4. **Style Compliance**: All Ruby files must pass `brew style`

### Pre-commit Validation
Always run before committing changes:
```bash
# Syntax check all modified files - 1-2 seconds, timeout 30+ seconds
# WORKS OFFLINE
find . -name "*.rb" -newer .git/COMMIT_EDITMSG -exec ruby -c {} \;

# Style check - 1-5 minutes, timeout 10+ minutes  
# REQUIRES NETWORK CONNECTIVITY
brew style --fix <modified-files>

# Audit affected casks - 5-30 minutes, timeout 45+ minutes
# REQUIRES NETWORK CONNECTIVITY
brew audit --cask --strict <modified-casks>
```

## Network Dependencies

This repository requires internet connectivity for:
- Downloading cask artifacts during testing
- Homebrew metadata updates
- GitHub API access for version checking
- SSL certificate verification

If network issues occur, syntax validation and style checking can still be performed offline.

## Known Limitations

- **macOS Only**: Cask installation testing requires macOS
- **Large Downloads**: Some casks download multi-GB applications
- **Manual Installers**: Some casks require manual interaction after download
- **BlackMagic Casks**: Use custom download strategy requiring form submission
- **Network Sensitive**: Many operations fail without internet connectivity

## Emergency Procedures

If builds are taking longer than expected:
1. **DO NOT CANCEL** - Wait minimum 45 minutes for any operation
2. Check GitHub Actions logs for specific failure points
3. Network timeouts are common - retry operations
4. For SSL errors, update certificates or retry later

The repository is designed for reliability over speed. Patient waiting is essential for successful operations.