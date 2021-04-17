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
  option :new => :boolean
  option :n => :boolean
  def context(*args)
    name = args.shift
    if options[:new] || options[:n]
      File.new("#{name}.md", 'w')
      puts "Created context #{name}"
      File.write("#{name}.md", '\n' + args.join(' '), mode: 'a')
      puts "Added #{args.join(' ')} to context #{name}"
    else
      File.open("#{name}.md")
      File.write("#{name}.md", '\n' + args.join(' '), mode: 'a')
      puts "Added #{args.join(' ')} to context #{name}"
    end
  rescue Errno::ENOENT => e
    File.new("#{name}.md", 'w')
    puts "Creating context #{name}"
    File.write("#{name}.md", '\n' + args.join(' '), mode: 'a')
    puts "Added #{args.join(' ')} to context #{name}"
  rescue StandardError => e
    binding.pry
    puts e
    puts 'Something went wrong'
  end
end

ContextCLI.start(ARGV)
