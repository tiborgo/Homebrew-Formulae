require 'formula'

class Tnyosc < Formula
  desc "Tiny library for creating and parsing Open Sound Control messages"
  homepage "https://github.com/tiborgo/tnyosc"
  url "https://github.com/tiborgo/tnyosc/archive/40fafb67fc57c32f4341eff248891c1c4dc5e3fc.zip"
  sha256 "ea2f593fedfa878918e07c45c87afb75f3ea64d411b349af1206a2dd41298dce"
  version "2016.6.30.2" # <year>.<month>.<day>.<commit number that day>

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "tnyosc.hpp"
      #include <cstdlib>
      #include <assert.h>
      #include <sstream>
      #include <iomanip>

      std::string get_bytes(const char* bytes, size_t size)
      {
        size_t i;
        std::stringstream ss;
        for (i = 0; i < size; ++i) {
          ss << std::hex << std::setfill('0') << std::setw(2) << (int)bytes[i] << " ";
          if (i % 16 == 15) {
            ss << std::endl;
          } else if (i % 4 == 3) {
            ss << " ";
          }
        }
        if (i % 16 != 0) {
          ss << std::endl;
        }
        ss << std::endl;
        return ss.str();
      }

      int main() 
      {
        tnyosc::Message msg;
        for (int i = 0; i < 2; i++) {
          msg.append(i);
        }
        auto str = get_bytes(msg.data(), msg.size());
        assert(str == "2f 74 6e 79  6f 73 63 00  2c 69 69 00  00 00 00 00 \\n00 00 00 01  \\n\\n");
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-o", "test"
    system "./test"
  end
end