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
  option new: :boolean
  option n: :boolean
  def context(*args)
    name = args.shift
    if options[:new] || options[:n]
      create_new_context(name)
    else
      File.open("#{name}.md")
      add_to_context(name, args)
    end
  rescue Errno::ENOENT
    create_new_context(name, args)
  end

  private

  def create_new_context(name, args)
    File.new("#{name}.md", 'w')
    puts "Created context #{name}"
    add_to_context(name, args)
  end

  def add_to_context(name, args)
    File.write("#{name}.md", '* ' + args.join(' ') + '/', mode: 'a')
    puts "Added '#{args.join(' ')}' to context #{name}"
  end
end

ContextCLI.start(ARGV)
