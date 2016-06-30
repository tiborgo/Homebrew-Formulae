require 'formula'

class Tnyosc < Formula
  desc ""
  homepage ""
  url "https://github.com/tiborgo/tnyosc/archive/40fafb67fc57c32f4341eff248891c1c4dc5e3fc.zip"
  sha256 "4c40a05a7d90452074c0578fcfb450f67d4eac129565c36facef0b7be58301d8"
  version "2016.06.30.2" # <year>.<month>.<day>.<commit number that day>

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end