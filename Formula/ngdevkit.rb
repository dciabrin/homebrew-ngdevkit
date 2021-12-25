class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202112251421.tar.gz"
  version "0.2+202112251421-1"
  sha256 "0a33360a6e6621fdbfe29b4886b6912614583abd882d942dcc63c12a35430870"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202112251421-1"
    sha256 cellar: :any_skip_relocation, catalina: "f98f034390bdfe25d33ee8fd049774446dcdf0f68a5334eab790909b3f10038e"
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
