require 'formula'

class Azmq < Formula
  desc "C++ language binding library integrating ZeroMQ with Boost Asio"
  homepage "https://github.com/zeromq/azmq"
  url "https://github.com/zeromq/azmq/archive/c23221bd572ee3034287d69940cfb102296e5d9a.zip"
  sha256 "8ce2518276d75a938ca0d6178dcc44831027d1e9f2209f5bb0bcc3f3eb5644bf"
  version "2016.2.11" # <year>.<month>.<day>

  depends_on "cmake" => :build
  depends_on "zmq"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end