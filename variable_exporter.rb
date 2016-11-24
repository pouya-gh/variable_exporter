require 'json'
require 'optparse'

inputfile = 'consolecommandsandvars.txt'
outputfile = 'result.json'
needs_help = false

### Options parser
help = %q{here are the valid flags and switches:
	
  -i, --input      Name of the input file from sandbox lagacy (defaults 
                   to "consolecommandsandvars.txt" in current folder).
  -o, --output     Name of the output file (defaults to "result.json" 
                   in current folder).
  -h, --help       You see this help.
}
option_parser = OptionParser.new do |opts|
  opts.on("-i INPUT", "--input INPUT") do |input|
   	inputfile = input
  end

  opts.on("-o OUTPUT", "--output OUTPUT") do |output|
    outputfile = output
  end

  opts.on("-h", "--help") do
    needs_help = true
  end
end
### end 

option_parser.parse!

if needs_help
	puts help
else
	variables = {}
	variable = ""
	current = ""
	file = File.open(inputfile, 'r')
	res_file = File.open(outputfile, 'w')
	file.each_line do |line|
		if line.start_with? "variable:"
			variable = line.gsub('variable:', '').gsub(' ', '').chomp
		end

		if line.start_with? "current:"
			current = line.gsub('current:', '').gsub(' ', '').chomp

			if current == current.to_f.to_s 
				current = current.to_f
			elsif current == current.to_i.to_s
				current = current.to_i
			end

			variables[variable] = current
		end
	end
	res_file.write variables.to_json
end
