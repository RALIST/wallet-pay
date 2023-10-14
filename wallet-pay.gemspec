# frozen_string_literal: true

require_relative "lib/wallet_pay/version"

Gem::Specification.new do |spec|
  spec.name = "wallet-pay"
  spec.version = WalletPay::VERSION
  spec.authors = ["Alexander Danilov"]
  spec.email = ["23499327+RALIST@users.noreply.github.com"]

  spec.summary = "API wrapper for Wallet Pay"
  spec.description = "API wrapper for Wallet Pay"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]
  spec.add_dependency "faraday", "~> 2.7.1"
end
