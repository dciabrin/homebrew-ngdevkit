class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202111151127.tar.gz"
  version "0.2+202111151127-1"
  sha256 "58a487863941e9d9274a5029f4aa380355cdc433a7a4e164c2e2accdb5d238d3"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202111151127-1"
    sha256 cellar: :any_skip_relocation, catalina: "5e04a71bf81e0de3007328543ffae3ea3418b50b5442fb0b9e93f74cd988f649"
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
