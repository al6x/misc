require 'whois'

extensions = %w(ru com)
base_words = %w(pchela)
prefixes = (0..9).to_a + ('a'..'z').to_a

availiable = []
base_words.each do |w|
  prefixes.each do |prefix|
    extensions.each do |e|
      domains = ["#{prefix}#{w}.#{e}", "#{w}#{prefix}.#{e}"]
      domains = domains.select do |d|
        puts "checking #{d}"
        begin
          Whois.query(d).available?
        rescue
          puts "skipping #{d}"
        end
      end
      puts "availiable: #{domains.inspect}" unless domains.empty?
      availiable.push *domains
    end
  end
end

puts "availiable: #{availiable.inspect}"
