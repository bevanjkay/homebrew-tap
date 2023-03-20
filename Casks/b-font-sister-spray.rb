cask "b-font-sister-spray" do
  version "2021-08-03"
  sha256 :no_check

  url "https://dl.dafont.com/dl/?f=sister_spray"
  name "Sister Spray"
  desc "Graffiti Font"
  homepage "https://www.dafont.com/sister-spray.font"

  livecheck do
    url :homepage
    regex(/Updated:\s+([^<"]+)/i)
    strategy :page_match do |page, regex|
      match = page.match(regex)[1]
      next if match.blank?

      year = match.split(",").last.tr(" ", "")
      month = Date::MONTHNAMES.index(match.split(",").first.split.first).to_s.rjust(2, "0")
      day = match.split(",").first.split.last

      "#{year}-#{month}-#{day}"
    end
  end

  font "Sister Spray.ttf"
end
