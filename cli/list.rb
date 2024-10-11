require_relative '../lib/blackops.rb'
require_relative '../config.rb'

l = BlackStack::LocalLogger.new('blackops.log')

# Check if a script name is provided
if ARGV[0] == '--help' || ARGV[0] == '--h' || ARGV[0] == '-h'
    puts "This command merges the list of nodes in the configuration file with the nodes configured in Contabo, and show a list of nodes with infrastructure information."
    puts "Usage: ops ssh <optional: pattern filter nodes>"
    exit 1
end
  
x = ARGV.shift # Get pattern

begin
    puts "Pattern: #{x}" if x
    puts "Pattern: (all)" if !x

    # Define the table rows
    rows = []
    rows << ['Name'.bold, 'IP'.bold]
    
    BlackOps.nodes.each { |node|
        rows << [node[:name], node[:ip]]
    }

    # Create the table with a title
    table = Terminal::Table.new :title => "Nodes List", :rows => rows do |t|
        t.style = {
            border_x: '',  # Horizontal border character
            border_y: '',  # Vertical border character
            border_i: ''   # Intersection character
        }
    end
    
    # Display the table in the terminal
    puts table
    
rescue => e
    l.reset
    l.log(e.to_console.red)
end