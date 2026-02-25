cask "propresenter@bleeding-edge" do
  version "21.3,352518159"
  sha256 "8b4c8d87eebd5c68e2936eb2935f4b1c9ce903cd5701ccfc3a9ac37bb48e4977"

  url "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"
  name "ProPresenter"
  desc "Presentation and production application for live events"
  homepage "https://www.renewedvision.com/propresenter/"

  livecheck do
    url "https://api.renewedvision.com/v1/pro/upgrade?platform=macos&osVersion=#{MacOS.full_version}&appVersion=0&buildNumber=0&includeNotes=0"
    strategy :page_match do
      matched = []
      unmatched = []

      beta = CaskLoader.load("propresenter@beta")

      current_version = (version.csv.first > beta.version.csv.first) ? version : beta.version
      puts current_version
      current_build = current_version.csv.second.to_i
      future_build = current_build.to_i + 5
      (current_build..future_build).each do |build|
        url = "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{current_version.csv.first}_#{build}.zip"

        system_result, _err, _st = Open3.capture3("curl -sLI #{url} | grep -i http/2")

        next unless system_result

        tested_version = "#{current_version.csv.first},#{build}"

        if system_result.include?("200")
          matched << tested_version
        else
          unmatched << tested_version
        end
      end

      if ARGV.include?("-v") || ARGV.include?("--verbose")
        puts "#{Tty.blue}==>#{Tty.reset} b-propresenter-bleeding-edge: #{matched.count} versions found, " \
             "#{unmatched.count} versions not found."
        matched.each { |v| puts "#{Tty.green}==>#{Tty.reset} Version #{v} found." }
        unmatched.each { |v| puts "#{Tty.red}==>#{Tty.reset} Version #{v} not found." }
      end

      matched
    end
  end

  depends_on macos: ">= :ventura"

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
