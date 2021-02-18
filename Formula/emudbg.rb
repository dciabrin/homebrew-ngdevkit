class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202102180924.tar.gz"
  version "0.2+202102180924-1"
  sha256 "3a7e833f130f924c1a89f7d27c010c4ddbc4bf84bbbc76088b84cfa7fc83f8e9"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "a0e6a6e2d2838667d0e654580f5702c58621be537134d8007268f637478abe71"
    sha256 cellar: :any_skip_relocation, mojave:   "e288a34bdefcdf8d6b8cd8eed3b289a1eb231985d26d5266bafa3121bafce83c"
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
