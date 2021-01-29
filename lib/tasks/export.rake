namespace :export do
    desc "Exports data for using in a seeds.rb."
    task :seeds_format => :environment do
        Interest.order(:id).all.each do |country|
        puts "Interest.create(#{country.serializable_hash.
              delete_if {|key, value| ['created_at','updated_at'].
              include?(key)}.to_s.gsub(/[{}]/,'')})"
      end
    end

    task :seeds_format => :environment do
      User.order(:id).all.each do |country|
      puts "User.create(#{country.serializable_hash.
            delete_if {|key, value| ['created_at','updated_at'].
            include?(key)}.to_s.gsub(/[{}]/,'')})"
      end
    end
    
    task :seeds_format => :environment do
      Concept.order(:id).all.each do |country|
      puts "Concept.create(#{country.serializable_hash.
            delete_if {|key, value| ['created_at','updated_at'].
            include?(key)}.to_s.gsub(/[{}]/,'')})"
      end
    end
 
  end

  