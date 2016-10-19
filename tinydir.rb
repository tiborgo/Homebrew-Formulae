require 'formula'

class Tinydir < Formula
  desc "Lightweight, portable and easy to integrate C directory and file reader"
  homepage ""
  url "https://github.com/cxong/tinydir/archive/ae6501d50b4540b7bd81348216ebe7b02696e5b4.zip"
  sha256 "41c8bfcb53e62b9b74371358a7b12f4dfa7be773baf87e275f7d838adc38d15c"
  version "0.20160620.1" # 0.<yyyymmdd>.<commit number that day>

  def install
  	include.install "tinydir.h"
  end
end
