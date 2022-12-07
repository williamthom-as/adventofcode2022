# frozen_string_literal: true

# Shitty filesystem knock-off
class Directory

  attr_accessor :name, :parent_directory, :directories, :files

  # @param [String] name
  # @param [Directory] parent_directory
  def initialize(name, parent_directory)
    @name = name
    @parent_directory = parent_directory
    @directories = []
    @files = []
  end

  def add_directory(directory)
    @directories << directory
  end

  def add_file(file, size)
    @files << { file: file, size: size }
  end

  def find_directory(dir_name)
    @directories.find { |d| d.name == dir_name }
  end

  def to_s
    "Directory: #{@name}"
  end

  def local_file_size
    return 0 if @files.size.zero?

    @files.sum { |f| f[:size].to_i }
  end

  def directories_file_size
    return 0 if @directories.size.zero?

    size = 0
    each_directory do |dir|
      size += dir.local_file_size.to_i
    end

    size
  end

  def total_file_size
    local_file_size + directories_file_size
  end

  def each_directory(&block)
    block.call(self)
    @directories.each { |x| x.each_directory(&block) }
  end
end

str = File.read('day7/source.txt')

starting_node = Directory.new('root', nil)
current_node = starting_node

in_dir = false
str.split("\n").each do |cmd|
  if cmd.start_with?('$ cd')
    in_dir = false
    _d, _c, directory = cmd.split(' ')

    if directory == '..'
      current_node = current_node.parent_directory
      next
    end

    found_dir = current_node.find_directory(directory)
    if found_dir
      current_node = found_dir
      next
    end

    dir = Directory.new(directory, current_node)
    current_node.add_directory(dir)
    current_node = dir
    next
  end

  if cmd.start_with?('$ ls')
    in_dir = true
    next
  end

  next unless in_dir

  files = cmd.split(' ')

  if files[0] == 'dir'
    current_node.add_directory(Directory.new(files[1], current_node))
  else
    current_node.add_file(files[1], files[0])
  end
end

arr = []
starting_node.each_directory do |dir|
  count = dir.directories_file_size > dir.local_file_size ? dir.directories_file_size : dir.local_file_size
  # file_size += count # if count <= 100_000 # sol 1
  arr << { name: dir.name, file_size: count }
end

arr.sort_by { |x| x[:file_size] }.each do |ar|
  p "#{ar[:name]} -> #{ar[:file_size]}" if ar[:file_size] >= 3_598_596
end
