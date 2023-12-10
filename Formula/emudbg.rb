class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/refs/tags/nightly-202305151016.tar.gz"
  version "0.2+202305151016-2"
  sha256 "49a294ac41194559f6a59271fa9a15d457833e2ebc4bb3ed86121d567f89d4e9"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202305151016-2"
    sha256 cellar: :any_skip_relocation, monterey: "14177809a8dfcd9887a18a79337066e8fd2837ed1cc0b99216c54c5348138a60"
    sha256 cellar: :any_skip_relocation, big_sur:  "4f6d59e7c1010ec6ea65cf573e87c37ad0f7096cba52d7e13e7edc68c637d3d4"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
