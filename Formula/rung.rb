class Rung < Formula
  desc "Git workflow tool for managing stacked PRs"
  homepage "https://github.com/auswm85/rung"
  url "https://github.com/auswm85/rung/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "f97baa6a3f1ed6fe223abfd55b65f7f8d3f41acfd66fb8fe10ddd47894088da7"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/rung-cli")
  end

  test do
    # Test version output
    assert_match "rung #{version}", shell_output("#{bin}/rung --version")

    # Test that it recognizes a non-rung repo gracefully
    system "git", "init", "test-repo"
    cd "test-repo" do
      output = shell_output("#{bin}/rung status 2>&1", 1)
      assert_match(/not initialized/i, output)
    end
  end
end
