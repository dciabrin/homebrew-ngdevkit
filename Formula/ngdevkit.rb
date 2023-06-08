class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202306062054.tar.gz"
  version "0.2+202306062054-1"
  sha256 "c7b0454ad40680f61cee19e6c6885114a042d7b3f5fa8ed34a95c58b65673588"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202306062054-1"
    sha256 cellar: :any_skip_relocation, monterey: "742445f5870ba43cd238458e268c1d70b20f6c3955fe85b881081b1212f3ce75"
    sha256 cellar: :any_skip_relocation, big_sur:  "e662fc23d77cf40a2103c69c2b2dece11137d447ab6542ba739c9d5894ee6ddf"
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
