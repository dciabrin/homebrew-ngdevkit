class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/refs/tags/nightly-202505251826.tar.gz"
  version "0.4+202505251826-1"
  sha256 "f8ef15367dd82bd31e1874957ea7be191c8e55132d918501eced2ab3f58671d5"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.4+202505251826-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "63e658a6babc0901b20054eceef93a022e3fef6f3b93ee329387d898450487c5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1b2ff17486c192d5062d569beea616efe840f37e54f8cb84207cad758c762a07"
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
