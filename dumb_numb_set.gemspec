Gem::Specification.new do |s|
  s.name = %q{dumb_numb_set}
  s.version = "0.1.0"
  s.authors = ["Justin Collins"]
  s.summary = "A compact data structure for mostly consecutive, non-negative integers."
  s.description = <<DESC
Ever needed to compactly store and query a set of mostly consecutive,
non-negative integers? Probably not, but if you do this library may work for
you. It's just about as fast as a Set and a lot smaller for numbers that stay
close together.
DESC
  s.homepage = "https://github.com/presidentbeef/dumb-numb-set"
  s.files = ["lib/dumb_numb_set.rb"]
  s.license = "MIT"
end
