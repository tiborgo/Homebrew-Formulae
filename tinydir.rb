require 'formula'

class Tinydir < Formula
  desc "Lightweight, portable and easy to integrate C directory and file reader"
  homepage "https://github.com/cxong/tinydir"
  url "https://github.com/cxong/tinydir/archive/ae6501d50b4540b7bd81348216ebe7b02696e5b4.zip"
  sha256 "41c8bfcb53e62b9b74371358a7b12f4dfa7be773baf87e275f7d838adc38d15c"
  version "2016.6.20.1" # <year>.<month>.<day>.<commit number that day>

  def install
  	include.install "tinydir.h"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <stdio.h>
      #include <assert.h>
	  #include <stdlib.h>
	  #include <unistd.h>
	  #include <limits.h>

	  #include <tinydir.h>

	  void make_temp_file(const char *prefix, char *out)
	  {
	  	sprintf(out, "%sXXXXXX", prefix);
	  	close(mkstemp(out));
	  }

	  int main() {
	  	char name[4096];
	  	make_temp_file("temp_file_", name);
	  	tinydir_file file;
	  	int r = tinydir_file_open(&file, name);
	  	assert(r == 0);
	  	remove(name);
	  }
	EOS
	system ENV.cxx, "test.cpp", "-o", "test"
	system "./test"
  end
end
