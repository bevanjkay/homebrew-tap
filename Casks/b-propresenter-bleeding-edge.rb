cask "b-propresenter-bleeding-edge" do
  version "7.13,118292499"
  sha256 "efd546ef2b61a41f5635da8a4f46370caa8a14b488313576245adac6150109b9"

  url "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"
  name "ProPresenter"
  desc "Presentation and production application for live events"
  homepage "https://www.renewedvision.com/propresenter.php"

  livecheck do
    url :homepage
    strategy :page_match do |_page|
      url = "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"

      matched = []

      current_minor = version.csv.first.minor.to_i
      future_minor = current_minor.to_i + 0
      current_patch = version.csv.first.patch.to_i
      future_patch = current_patch.to_i + 1
      current_build = version.csv.second.to_i
      future_build = current_build.to_i + 5
      (current_minor..future_minor).each do |minor|
        (current_patch..future_patch).each do |patch|
          (current_build..future_build).each do |build|
            url = if patch.zero?
              "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_7.#{minor}_#{build}.zip"
            else
              "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_7.#{minor}.#{patch}_#{build}.zip"
            end

            puts url
            system_result, _err, _st = Open3.capture3("curl -sLI #{url} | grep -i http/2")

            next unless system_result

            tested_version = if patch.zero?
              "7.#{minor},#{build}"
            else
              "7.#{minor}.#{patch},#{build}"
            end

            if system_result.include?("200")
              matched << tested_version
              puts "Version #{tested_version} found."
            else
              puts "Version #{tested_version} not found."

            end
          end
        end
      end

      matched
    end
  end

  conflicts_with cask: [
    "homebrew/cask-versions/propresenter-beta",
    "propresenter",
  ]
  depends_on macos: ">= :mojave"

  app "ProPresenter.app"

  zap trash: [
        "~/Library/Application Support/RenewedVision/ProPresenter#{version.major}",
        "~/Library/Caches/KSCrashReports/ProPresenter #{version.major}",
        "~/Library/Caches/Sessions/ProPresenter #{version.major}",
        "~/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "~/Library/Preferences/com.renewedvision.ProPresenter#{version.major}.plist",
        "/Library/Application Support/RenewedVision",
        "/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "/Users/Shared/Renewed Vision Media",
      ],
      rmdir: [
        "~/Library/Application Support/RenewedVision",
        "~/Library/Caches/KSCrashReports",
        "~/Library/Caches/Sessions",
      ]
end
