require 'formula'

class Gtest < Formula
  desc "Google Test, Google's C++ test framework"
  homepage "https://github.com/google/googletest"
  url "https://github.com/google/googletest/archive/release-1.8.0.zip"
  sha256 "f3ed3b58511efd272eb074a3a6d6fb79d7c2e6a0e374323d1e6bcbcc1ef141bf"
  version "1.8.0"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <gtest/gtest.h>

      class Foo {
      public:
        int Bar() {
          return 0;
        }
      };

      TEST(FooTest, MethodBarReturns0) {
        Foo f;
        EXPECT_EQ(0, f.Bar());
      }

      int main(int argc, char **argv) {
        ::testing::InitGoogleTest(&argc, argv);
        return RUN_ALL_TESTS();
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-lgtest", "-o", "test"
    system "./test"
  end
end