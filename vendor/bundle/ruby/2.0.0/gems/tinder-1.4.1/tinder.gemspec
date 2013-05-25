# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tinder}
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brandon Keepers"]
  s.date = %q{2010-10-09}
  s.description = %q{A Ruby API for interfacing with Campfire, the 37Signals chat application.}
  s.email = %q{brandon@opensoul.org}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG.txt",
     "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/tinder.rb",
     "lib/tinder/campfire.rb",
     "lib/tinder/connection.rb",
     "lib/tinder/multipart.rb",
     "lib/tinder/room.rb",
     "site/index.html",
     "site/stylesheets/style.css",
     "spec/fixtures/rooms.json",
     "spec/fixtures/rooms/room80749.json",
     "spec/fixtures/rooms/room80751.json",
     "spec/fixtures/rooms/show.json",
     "spec/fixtures/users/me.json",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/tinder/campfire_spec.rb",
     "spec/tinder/connection_spec.rb",
     "spec/tinder/room_spec.rb",
     "tinder.gemspec"
  ]
  s.homepage = %q{http://github.com/collectiveidea/tinder}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tinder}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby wrapper for the Campfire API}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/tinder/campfire_spec.rb",
     "spec/tinder/connection_spec.rb",
     "spec/tinder/room_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<twitter-stream>, [">= 0"])
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<twitter-stream>, [">= 0"])
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<twitter-stream>, [">= 0"])
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end

