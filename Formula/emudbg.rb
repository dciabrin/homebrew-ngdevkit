class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202012062246.tar.gz"
  version "0.2+202012062246-1"
  sha256 "77744361d113a34b94b1ca98c320055ab3a23a512bd43e24ab1197c82630e896"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "57e9ee8f9a59fb25f76fca63e567d460bf019c398dc7a98d3d5a1b97e76169fe"
    sha256                               mojave:   "57085a4b808f727fab15fe3bc9f357e275647d0aebc925cd0d50db5357512c85"
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
