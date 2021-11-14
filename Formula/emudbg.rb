class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111141535.tar.gz"
  version "0.2+202111141535-1"
  sha256 "5ac567efdca679dc46854581d87ab6f9b88fc920adbd1896cdb32c1dd233a443"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111141535-1"
    sha256 cellar: :any_skip_relocation, catalina: "ae49eddc1c14667a09aea7e7d2851eddaf916b86b353692d8a729f47ed2e6af8"
    sha256 cellar: :any_skip_relocation, mojave:   "c2afb479849c9b17d3536cdbe00cb2d26f7daac99ee9163450dbb0bcbe4ccdd5"
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
