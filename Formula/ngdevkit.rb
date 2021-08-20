class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202108192034.tar.gz"
  version "0.2+202108192034-1"
  sha256 "bce5023073883e9ba098e6f9fe7c12572ce6ab3ba6149560e6fd6f70d833a9fd"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202108192034-1"
    sha256 cellar: :any_skip_relocation, catalina: "0406aee087b14aedb7441dae09312e4a56309710e0bef31e9bd48f350bcff30b"
    sha256 cellar: :any_skip_relocation, mojave:   "85b113ac3e47699eca256dee66084bbf303ca88a9a2cbfcb3b24a70de8d378c0"
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
