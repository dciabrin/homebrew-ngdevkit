class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005232041.tar.gz"
  sha256 "2471f7388629d110acc33da31972a4fcd7874d4c604ffc1afc82694621bfccd6"
  version "0.2+202005232041-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "76fd2fc40a25ad7b6c59372d3b5b7e99764265697faed03ea9fe9006ee8fb122" => :catalina
    sha256 "8703d6a8a0cd7707b1f5d929844e5fac7dd67fe64d00bb7721546b59f7797447" => :mojave
    sha256 "fb5ef31606df48811e64f13b90ba12198cdc5cbba4b83d02ce8b7bf525a679aa" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "python3"
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"

  def install
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system $gmake
    system $gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
