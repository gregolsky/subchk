 $:.push File.expand_path("../lib", __FILE__)
 require "subchk/version"

 Gem::Specification.new do |s|
   s.name        = "subchk"
   s.version     = VERSION
   s.authors     = ["Grzegorz Lachowski"]
   s.email       = ["gregory.lachowski@gmail.com"]
   s.homepage    = "https://github.com/gregorl/subchk"
   s.summary     = %q{Subtitles watcher}
   s.description = %q{Subtitles watcher}

   s.files         = `git ls-files`.split("\n")
   s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
   s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
   s.require_paths = ["lib"]

 end
