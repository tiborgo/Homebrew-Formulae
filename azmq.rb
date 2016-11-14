require 'formula'

class Azmq < Formula
  desc "C++ language binding library integrating ZeroMQ with Asio"
  homepage "https://github.com/tiborgo/azmq"
  url "https://github.com/tiborgo/azmq/archive/dc36b2f8f8fc6f107e3e66f6bd62cee3222ee8ee.zip"
  sha256 "3387758a93914a06e69b4e995cda65301ac9c5e6c2314ee5485b99e5b2a9a755"
  version "2016.11.14.4" # <year>.<month>.<day>.<commit number that day>

  depends_on "cmake" => :build
  depends_on "zmq"
  depends_on "asio"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end