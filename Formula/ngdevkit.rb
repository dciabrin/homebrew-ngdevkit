class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202108211105.tar.gz"
  version "0.2+202108211105-1"
  sha256 "d44cfae75f4a65b78a6dfb6e4db971a6d6b0f6900d6cbd8a9dd2a4d5a69380b4"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202108211105-1"
    sha256 cellar: :any_skip_relocation, catalina: "a48ef3e0f5f6105b0cc3f9fab7b5128a2fcd21d64e3a57d0f915dd506c4d4661"
    sha256 cellar: :any_skip_relocation, mojave:   "ee0e20a2a78f00a5a143ba806e5c8c82b64d7152542e8a8f051ee8a95c305779"
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
