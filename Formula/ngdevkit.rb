class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/refs/tags/nightly-202506080819.tar.gz"
  version "0.4+202506080819-1"
  sha256 "fd7c4c007614d95ca19ed650a06ee88d7421b74a26b1aa744dcd1f3d4a735257"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.4+202506080819-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "53628710f5d6c6eec3a4f7c8e7e35fe8a6767b5ddfa15eb902cdcb1a0eaa1146"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c08a09472b3f0bc942181249ae6f0991d9aa49f06810970327b545eb923333af"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "m4" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"
  depends_on "python3"

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # Homebrew picks the system's gnu M4, which is too old for autoreconf
    # (it doesn't have option --gnu). Pick homebrew's version instead
    ENV["M4"] = "#{Formula["m4"].opt_bin}/m4"

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
