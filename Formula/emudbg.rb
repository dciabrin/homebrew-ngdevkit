class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202102192029.tar.gz"
  version "0.2+202102192029-1"
  sha256 "18f377ee3f6b4720edbfdca8a00845260f359aa93404dea485aabfdcfb0df4c3"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "fc0df2984be172eefba6410d33ed396e9be3bde5b1964292cb14d554c01a44b4"
    sha256 cellar: :any_skip_relocation, mojave:   "da1655b2ef7fe6d57a368c19739f5d35da8718bbf5b3befbfc9f77b9c35346d9"
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
