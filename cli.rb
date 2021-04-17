# frozen_string_literal: true

require 'thor'
require 'pry'

class ContextCLI < Thor
  # store different context (file for now)
  # add different notes to context
  # user can select a contect and then type out a note

  desc 'hello NAME', 'say hello to NAME'
  def hello(name, from = nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end

  desc 'add CONTEXT', 'create a new context'
  option :new
  def context(*args)
    name = args.shift
    if options[:new]
      puts "Creating context #{name}"
      File.new("#{name}.md", 'w')
      File.write("#{name}.md", '\n' + args.join(' '), mode: 'a')
    else
      File.open("#{name}.md")
      puts "Updating context #{name}"
      File.write("#{name}.md", '\n' + args.join(' '), mode: 'a')
    end
  rescue StandardError
    puts 'Something went wrong'
  end
end

ContextCLI.start(ARGV)
