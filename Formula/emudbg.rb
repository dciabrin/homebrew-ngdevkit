class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202103031348.tar.gz"
  version "0.2+202103031348-1"
  sha256 "fcfbbdbad576b8567aaed1c85adb4d1afc038061e9d9bd9646a04b79c2627116"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "a7e4c3c315eb0bb60f005e5a44aa0908cd9af4fd8f69ef182b2cc38da04340d6"
    sha256 cellar: :any_skip_relocation, mojave:   "070dc87edebf65255356dca7764609286e0fa179ea4dc979593622e9deffbc4d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
