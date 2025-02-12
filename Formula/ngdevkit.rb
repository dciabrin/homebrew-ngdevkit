class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/refs/tags/nightly-202501171827.tar.gz"
  version "0.4+202501171827-1"
  sha256 "21289221e051b94064151fa97941789151cbfa69e40f0a1c01fb14c07b07f109"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.4+202501171827-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8418a2e603793d42596dac815ac25aa99454f0703675e13e9c6b674879d82101"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f657be1b80d1a5ec418ad2dd3f44bd007f620952c7a287cc3edfe6111628984"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"
  depends_on "python3"

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
