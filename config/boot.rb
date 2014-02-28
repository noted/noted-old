PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

COMMIT = `git show --pretty=%H`.split[0...1].join(' ')
BRANCH = `git rev-parse --abbrev-ref HEAD`

NOTED_VERSION = '0.1.0b'

if ENV['DEBUG_REQUIRE']
  require 'benchmark'

  def require(file)
    @@first ||= Time.now
    rc = false
    ts = Benchmark.measure do
      rc = super
    end
    if ENV['DEBUG_REQUIRE'].to_f < ts.total
      total = ts.format("%t require #{file}")
      from_start = (Time.now - @@first).to_i
      $stdout.puts "#{total} (#{from_start} second(s) from start)"
    end
    rc
  end
end

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PADRINO_ENV)

if defined?(LogBuddy)
  LogBuddy.init({
    :logger   => logger,
    :disabled => PADRINO_ENV == :production
  })
end

Padrino.after_load do
  %w(mailers mutations).each do |d|
    Padrino.require_dependencies("#{Padrino.root}/app/#{d}/**/*.rb")
  end
end

Padrino.load!
