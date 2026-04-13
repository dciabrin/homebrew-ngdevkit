class Ngdevkit < Formula
  include Language::Python::Virtualenv

  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/refs/tags/nightly-202604130816.tar.gz"
  version "0.4+202604130816-1"
  sha256 "6474c31f3526322aa7cd5e5e782a29d7b8c279c8962a9d83f087adc7300e33b8"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.4+202604130816-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cd9d1a59b95094bb2f7d26ab8191bdb132ad6fc76540629a54b7c5ac7d5f92ce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "78ebb9ff0c6930d3f56c53c720c1f22c2488814507c4af9a8cf07d10717f6c55"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "m4" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pillow"
  depends_on "pkg-config"
  depends_on "python@3.14"

  resource "ruamel-yaml" do
    url "https://files.pythonhosted.org/packages/c7/3b/ebda527b56beb90cb7652cb1c7e4f91f48649fbcd8d2eb2fb6e77cd3329b/ruamel_yaml-0.19.1.tar.gz"
    sha256 "53eb66cd27849eff968ebf8f0bf61f46cdac2da1d1f3576dd4ccee9b25c31993"
  end

  def install
    # Some python dependencies are not available as brew packages, so we
    # install them via pip in a dedicated venv, which will land in libexec.
    # The original ngdevkit file wills land in /usr/lib, except the python
    # scripts (and stuff from exec-prefix), which also land in libexec.
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resource("ruamel-yaml")

    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # Homebrew picks the system's gnu M4, which is too old for autoreconf
    # (it doesn't have option --gnu). Pick homebrew's version instead
    ENV["M4"] = "#{Formula["m4"].opt_bin}/m4"

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system gmake
    system gmake, "install"

    # Lastly, let brew generate stubs for all the python scripts in ngdevkit.
    # Those stubs set up PYTHONPATH and run the real scripts automatically.
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.14/site-packages"
    bin.install Dir[libexec/"bin/*.py"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    # no test for the time being
    system "true"
  end
end
