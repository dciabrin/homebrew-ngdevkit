class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111141535.tar.gz"
  version "0.2+202111141535-5"
  sha256 "5ac567efdca679dc46854581d87ab6f9b88fc920adbd1896cdb32c1dd233a443"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111141535-5"
    sha256 cellar: :any_skip_relocation, monterey: "4473b025ccbfc85547b60acffe283fff005037098e2a386e220734daea8dd6f3"
    sha256 cellar: :any_skip_relocation, big_sur:  "87e4547359f896dda88b02ccd09dfba941967d3ed93b225c6319dd6e01d2a06d"
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
