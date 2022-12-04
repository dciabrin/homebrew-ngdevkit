class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202212041448.tar.gz"
  version "0.2+202212041448-1"
  sha256 "b81a921a50bbb921f192cc0d7950ba3b292083410e135d6bc24574218082bc75"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202212041448-1"
    sha256 cellar: :any_skip_relocation, monterey: "f4681463f9a7f862d607100aacbb8260a933c909df97363b025959ed9238b601"
    sha256 cellar: :any_skip_relocation, big_sur:  "d1c523018f8a4ab425a81a2af6cb352f87db40f6820a4430dc5a9a1603c540a4"
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
