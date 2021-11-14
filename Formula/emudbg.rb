class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111140851.tar.gz"
  version "0.2+202111140851-1"
  sha256 "427d92558be569f9db1ab09bfffa52b6a86f6474d5d21c97226603d4f234fe83"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111140851-1"
    sha256 cellar: :any_skip_relocation, catalina: "8924aa9d8a228cb1ac2889ee2c3dfee7316fde20f7852396ccde8cefb1b006fb"
    sha256 cellar: :any_skip_relocation, mojave:   "ec24a14434f91d2d0e81ed883995adfcfcf5a71cb232e547380da85c303ae8f9"
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
