require 'formula'

class Tnyosc < Formula
  desc ""
  homepage ""
  url "https://github.com/tiborgo/tnyosc/archive/40fafb67fc57c32f4341eff248891c1c4dc5e3fc.zip"
  sha256 "ea2f593fedfa878918e07c45c87afb75f3ea64d411b349af1206a2dd41298dce"
  version "2016.06.30.2" # <year>.<month>.<day>.<commit number that day>

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end