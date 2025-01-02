class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/refs/tags/nightly-202403192028.tar.gz"
  version "0.2+202403192028-3"
  sha256 "56306dd13bebcf001bcf340695b05d225bf077fc9ef99283db8f46eaf019e536"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202403192028-3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6bbd5fbc5c24b3b60ff0ffd863059d045dbae40a5ef4deb6c796e9c50956318c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b01ee2c7b6a7f410a8705da95e42decbac8f29ed2bfe284bc100b62ac220cbfc"
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
