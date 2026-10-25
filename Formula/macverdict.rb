class Macverdict < Formula
  include Language::Python::Virtualenv

  desc "Tells you why your Mac was slow this week and what to do about it"
  homepage "https://github.com/anirudhjayaraman/macverdict"
  url "https://github.com/anirudhjayaraman/macverdict/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "61915e3d74b0a1c8d6ca8b7dff6509d83a16da302d3ff0c595e3fbf4dfea34d5"
  license "MIT"

  depends_on :macos
  depends_on "python@3.14"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Finish setting up (background recording and alerts) with:
        macverdict setup

      Before `brew uninstall macverdict`, run:
        macverdict uninstall
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macverdict --version")
    ENV["MACVERDICT_HOME"] = testpath
    system bin/"macverdict", "check", "--json", "--interval", "0.1"
  end
end
