class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202302181249.tar.gz"
  version "0.2+202302181249-1"
  sha256 "299317317aed152e6c75576f02000331f9561ba47f949886b5f6d3d7c44429f4"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202302181249-1"
    sha256 cellar: :any_skip_relocation, monterey: "7294cc4f107511ca4926fc9b7fe3e3eac22fd11434f647301dabeceb94d3e033"
    sha256 cellar: :any_skip_relocation, big_sur:  "27e7d6b769574d3d66e9f0a22dbdffb7f7e905b288551d2af800fa236f53cdae"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
