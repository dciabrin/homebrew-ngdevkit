class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202104291717.tar.gz"
  version "0.2+202104291717-1"
  sha256 "9e77ba3acb23ef8f178ecf6a22a4f35e8eda4a8cede0f1a3372e14adf060aa4e"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202104291717-1"
    sha256 cellar: :any_skip_relocation, catalina: "f539ed040fc3ee11e3180c9052b1f1b2a646622856ad365e130ce6ec6f809230"
    sha256 cellar: :any_skip_relocation, mojave:   "13265b30e767bf717ab7b41dbc3ad016899b5cc339163e86a2f463afa4e5e674"
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
