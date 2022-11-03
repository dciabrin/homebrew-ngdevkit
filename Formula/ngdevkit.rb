class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202211031049.tar.gz"
  version "0.2+202211031049-1"
  sha256 "70f2a5289793c552cbb5ea49018cf494303811ab7e89d45765801f2ddc79d47e"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202211031049-1"
    sha256 cellar: :any_skip_relocation, monterey: "dbde48edf5b775ebfff136bf374c137631698112cfcdba6a45b612e6be288896"
    sha256 cellar: :any_skip_relocation, big_sur:  "101af9fdc2b5d684ef9ed43b984af5369c9c2fd8cf58ea8eb900654f59aa6109"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"
  depends_on "python3"

  def install
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
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
