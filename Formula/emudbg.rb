class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-20200120090612.tar.gz"
  sha256 "20acee9dd56dfd1f43b6032ef9f6793bb47e2db6aa24ced2a58d2b94cc030952"
  version "0.2+202001200758-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "103db6c750455c37f2f5eea219c10877ca330fbb910f7ed538eb2e905f3a0cf0" => :catalina
    sha256 "ab9295be91df8bb806ce09e4ef4f92bd84cadbe12c0fd1f07926a8359e1bb3d6" => :mojave
    sha256 "78f93028603ceddcd6270583e3320adc2757073ba8743bc2a057fc61980897dc" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system $gmake
    system $gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
