cask "propresenter-bleeding-edge" do
  version "7.16.2,118489611"
  sha256 "bc4e065f63c6f1a5375178e20d72894ca57230767a7d02aef3a0b22620ebb384"

  url "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"
  name "ProPresenter"
  desc "Presentation and production application for live events"
  homepage "https://www.renewedvision.com/propresenter/"

  livecheck do
    url :homepage
    strategy :page_match do
      url = "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"

      matched = []
      unmatched = []

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

            system_result, _err, _st = Open3.capture3("curl -sLI #{url} | grep -i http/2")

            next unless system_result

            tested_version = if patch.zero?
              "7.#{minor},#{build}"
            else
              "7.#{minor}.#{patch},#{build}"
            end

            if system_result.include?("200")
              matched << tested_version
            else
              unmatched << tested_version
            end
          end
        end
      end

      if ARGV.include?("-v") || ARGV.include?("--verbose")
        puts "#{Tty.blue}==>#{Tty.reset} b-propresenter-bleeding-edge: #{matched.count} versions found, " \
             "#{unmatched.count} versions not found."
        matched.each { |version| puts "#{Tty.green}==>#{Tty.reset} Version #{version} found." }
        unmatched.each { |version| puts "#{Tty.red}==>#{Tty.reset} Version #{version} not found." }
      end

      matched
    end
  end

  depends_on macos: ">= :monterey"

  app "ProPresenter.app", target: "ProPresenter (#{version.csv.first}).app"

  zap trash: [
        "/Library/Application Support/RenewedVision",
        "/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "/Users/Shared/Renewed Vision Media",
        "~/Library/Application Support/RenewedVision/ProPresenter#{version.major}",
        "~/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "~/Library/Caches/KSCrashReports/ProPresenter #{version.major}",
        "~/Library/Caches/Sessions/ProPresenter #{version.major}",
        "~/Library/Preferences/com.renewedvision.ProPresenter#{version.major}.plist",
      ],
      rmdir: [
        "~/Library/Application Support/RenewedVision",
        "~/Library/Caches/KSCrashReports",
        "~/Library/Caches/Sessions",
      ]
end
