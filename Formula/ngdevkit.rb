class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202305261452.tar.gz"
  version "0.2+202305261452-1"
  sha256 "fb769e26b88f65fe7062234d2a05f22c7d686564f9ffa16e60f6129d3980da83"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202305261452-1"
    sha256 cellar: :any_skip_relocation, monterey: "3d2eed4254e0be2d1437913fa99e39447e67bb13bd21e7b9bf06112169853d54"
    sha256 cellar: :any_skip_relocation, big_sur:  "edb2ba11532dd0de338e6333a22855e0213b3ba95d4001a746b47ae86cb7e610"
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
