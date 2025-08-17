namespace :quality do
  desc "Run RuboCop linter"
  task :lint do
    puts "🧹 Running RuboCop linter..."
    system("bundle exec rubocop")
  end

  desc "Auto-correct RuboCop offenses"
  task :lint_fix do
    puts "🔧 Running RuboCop with auto-correct..."
    system("bundle exec rubocop -A")
  end

  desc "Run all RSpec tests with coverage"
  task :test_coverage do
    puts "🧪 Running RSpec tests with coverage..."
    ENV["COVERAGE"] = "true"
    system("bundle exec rspec")
  end

  desc "Run Cucumber E2E tests"
  task :cucumber do
    puts "🥒 Running Cucumber E2E tests..."
    system("bundle exec cucumber")
  end

  desc "Run all quality checks"
  task all: [ :lint, :test_coverage, :cucumber ] do
    puts "✅ All quality checks completed!"
  end

  desc "Generate and open coverage report"
  task :coverage_report do
    puts "📊 Opening coverage report..."
    if File.exist?("coverage/index.html")
      system("open coverage/index.html")
    else
      puts "❌ Coverage report not found. Run 'rake quality:test_coverage' first."
    end
  end

  desc "Show test statistics"
  task :stats do
    puts "📈 Test Statistics:"
    puts "-" * 50

    # RSpec stats
    rspec_files = Dir.glob("spec/**/*_spec.rb").count
    puts "RSpec test files: #{rspec_files}"

    # Cucumber stats
    cucumber_files = Dir.glob("features/*.feature").count
    cucumber_steps = Dir.glob("features/step_definitions/*.rb").count
    puts "Cucumber feature files: #{cucumber_files}"
    puts "Cucumber step definition files: #{cucumber_steps}"

    # Application files
    controllers = Dir.glob("app/controllers/**/*.rb").count
    models = Dir.glob("app/models/**/*.rb").count
    views = Dir.glob("app/views/**/*.erb").count
    helpers = Dir.glob("app/helpers/**/*.rb").count

    puts "\nApplication files:"
    puts "Controllers: #{controllers}"
    puts "Models: #{models}"
    puts "Views: #{views}"
    puts "Helpers: #{helpers}"
  end
end

desc "Quick quality check (lint + unit tests)"
task quick: [ "quality:lint", "quality:test_coverage" ]

desc "Full quality check (lint + all tests)"
task full: [ "quality:all" ]
