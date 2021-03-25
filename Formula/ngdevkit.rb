class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202103252051.tar.gz"
  version "0.2+202103252051-1"
  sha256 "cb96204ef85055a3ed56664ec723b321ff98d68da1245c7968c24484c966861e"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "d0088168f5b29bbb9759561361d1b1a646f342c45101519426b91db5499dc1e0"
    sha256 cellar: :any_skip_relocation, mojave:   "714dc1992e87d5a515dd6799065522f1cae2260e232b7174ea030d03ada573ca"
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
