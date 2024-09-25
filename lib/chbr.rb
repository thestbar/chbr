# frozen_string_literal: true

require 'git'
require 'optparse'

# Class that handles the main functionality of the tool. It allows the user to
# checkout branches, delete branches and purge branches. It also allows the
# user to set the path to the repository, the timeout for git commands and
# whether the panel should reopen after an action is performed.
class Chbr
  DEFAULT_TIMEOUT = 5

  attr_accessor :repo_path, :reopen_after_action, :repo

  def self.run
    new.run
  end

  def run
    Git.config.timeout = DEFAULT_TIMEOUT

    @repo_path = Dir.pwd

    @reopen_after_action = true

    parse_options

    another_repo = @repo_path != Dir.pwd
    current_path = Dir.pwd

    go_to_repo(@repo_path) if another_repo

    begin
      @repo = Git.open(@repo_path)
    rescue ArgumentError => e
      puts "Error: #{e.message}"

      return
    end

    open_panel

    go_to_repo(current_path) if another_repo
  end

  def go_to_repo(path)
    Dir.chdir(path)
  end

  def parse_options
    OptionParser.new do |opts|
      opts.banner = 'Usage: chbr [path_to_repository]'

      opts.on('-p PATH', '--path PATH', 'Path to the git repository') do |path|
        @repo_path = path
      end

      opts.on(
        '--disable-reopen',
        'Disable reopening the panel after an action is performed (Defaults to true)'
      ) do
        @reopen_after_action = false
      end

      opts.on(
        't', '--timeout TIMEOUT',
        'Set the timeout for git commands in seconds (Defaults to 5)'
      ) do |timeout|
        Git.config.timeout = timeout.to_i
      end
    end.parse!
  end

  def open_panel
    puts '[ENTER] to checkout branch, [X] to delete branch, [P] to purge branches'

    result = `
      git branch | fzf --bind "enter:accept,X:become(echo {}'%%%delete')+abort,P:accept+become(echo {}'%%%purge')+abort" --height 40% |
      tr -d "*[:space:]|+[:space:]"
    `

    return puts 'No branch selected' if result.empty?

    branch, action = result.split('%%%')

    begin
      case action
      when 'delete'
        puts "Are you sure you want to delete branch \"#{branch}\"? (y/n)"

        deleted = false

        deleted = delete_branch(branch) if gets.chomp == 'y'

        open_panel if @reopen_after_action && deleted
      when 'purge'
        puts "This action will delete all branches on this repository except for \"#{branch}\". Are you sure? (y/n)"

        purge_branches(branch) if gets.chomp == 'y'
      else
        checkout_branch(result)
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end

  def delete_branch(branch)
    if @repo.current_branch == branch
      puts 'Cannot delete checked out branch'

      return false
    end

    repo.branch(branch).delete

    true
  end

  def purge_branches(except)
    checkout_branch(except) if @repo.current_branch != except

    @repo.branches.each do |branch|
      next if branch.name == except

      delete_branch(branch.name)
    end
  end

  def checkout_branch(branch)
    @repo.branch(branch).checkout
  end
end
