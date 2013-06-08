Gem::Specification.new do |s|                                                   
  s.name = "proper_active_record_uniqueness_validations"                                                                
  s.version = "0.1.0"                                                           
                                                                                
  s.required_ruby_version = ">= 1.9.3"                                       
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sven Riedel"]                                                   
  s.date = %q{2013-06-08}                                                       
  s.description = %q{ActiveRecord uniqueness validations without raceconditions}
  s.add_dependency( 'activerecord', '~> 3.2.13' )
  s.add_dependency( 'pg',           '~> 0.14.1' )
  s.summary = %q{Uses unique indexes on the database level to see and deal with uniqueness constraint violations. No raceconditions and less database calls required to save or update a record.}
  s.email = %q{sr@gimp.org}
  s.homepage = %q{http://github.com/sriedel/proper_active_record_uniqueness_validations}
                                                                                
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.extra_rdoc_files = %W{ README.rdoc }
  s.files = %x{git ls-files}.split
end
