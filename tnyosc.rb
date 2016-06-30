class tnyosc < Formula
  desc ""
  homepage ""
  url "https://github.com/tiborgo/tnyosc/archive/master.zip"
  sha256 "85cc828a96735bdafcf29eb6291ca91bac846579bcef7308536e0c875d6c81d7"

  depends_on "cmake" => :build

  def install
    # system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    # system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end