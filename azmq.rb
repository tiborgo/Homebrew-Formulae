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

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <azmq/actor.hpp>
      #include <azmq/util/scope_guard.hpp>

      #include <asio/buffer.hpp>

      #include <array>
      #include <thread>
      #include <iostream>
      #include <assert.h>

      std::array<asio::const_buffer, 2> snd_bufs = {{
          asio::buffer("A"),
          asio::buffer("B")
      }};

      std::string subj(const char* name) {
          return std::string("inproc://") + name;
      }

      int main() {
        asio::error_code ecc;
        size_t btc = 0;

        asio::error_code ecb;
        size_t btb = 0;
        {
          std::array<char, 2> a;
          std::array<char, 2> b;

          std::array<asio::mutable_buffer, 2> rcv_bufs = {{
            asio::buffer(a),
            asio::buffer(b)
          }};

          asio::io_service ios;
          auto s = azmq::actor::spawn(ios, [&](azmq::socket & ss) {
            ss.async_receive(rcv_bufs, [&](asio::error_code const& ec, size_t bytes_transferred) {
              ecb = ec;
              btb = bytes_transferred;
              ios.stop();
            });
            ss.get_io_service().run();
          });

          s.async_send(snd_bufs, [&] (asio::error_code const& ec, size_t bytes_transferred) {
            ecc = ec;
            btc = bytes_transferred;
          });

          asio::io_service::work w(ios);
          ios.run();
        }

        assert(ecc == asio::error_code());
        assert(btc == 4);
        assert(ecb == asio::error_code());
        assert(btb == 4);
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-lzmq", "-o", "test"
    system "./test"
  end
end
