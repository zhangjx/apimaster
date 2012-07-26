
module Apimaster::Generators
  class AppGenerator < Create
    attr_reader :app_name, :module_name

    def initialize(runtime_args, runtime_options = {})
      super
      #@destination_root = args.shift
      #@app_name     = File.basename(File.expand_path(@destination_root))
      @app_name     = args[0]
      raise 'Undefined app name.' unless @app_name
      @module_name  = camelize(app_name)
      extract_options
    end

    def manifest
      record do |m|
        # Ensure appropriate folder(s) exists
        m.directory ''
        BASEDIRS.each { |path| m.directory(app_name + '/' + path) }
        m.directory "#{app_name}/lib/#{app_name}"

        # config
        templates = {
          "config/boot.rb.erb" => "config/boot.rb",
          "config/patches.rb.erb" => "config/patches.rb",
          "config/initializer.rb.erb" => "config/initializer.rb",
          "config/application.rb.erb" => "config/application.rb",
          "config/settings/mongoid.yml.erb" => "config/settings/mongoid.yml",
          "config/settings/app.yml.erb" => "config/settings/app.yml",
          "config/settings/oauth.yml.erb" => "config/settings/oauth.yml",

          # Create stubs
          "config.ru.erb" => "config.ru",
          "gitignore" => ".gitignore",
          "lib/module.rb.erb" => "lib/#{app_name}.rb",
          "app/tasks/test.rake.erb" => "app/tasks/test.rake",
          "app/tasks/stat.rake.erb" => "app/tasks/stat.rake",
          "app/controllers/index_controller.rb.erb" => "app/controllers/index_controller.rb",
          "app/controllers/befores_controller.rb.erb" => "app/controllers/befores_controller.rb",

          # Test stubs
          "test/test_helper.rb.erb" => "test/test_helper.rb"
        }.each { |k, v| m.template(k, app_name + '/' + v) }

        %w(LICENSE Rakefile README.md Gemfile TODO test.watchr).each do |file|
          m.template file, app_name + '/' + file
        end
      end
    end

    protected
      def banner
        <<-EOS
  Creates a Apimaster scaffold.

  USAGE: apimaster new your_app_name"
  EOS
      end

      def add_options!(opts)
        opts.separator ''
        opts.separator 'Options:'
        # For each option below, place the default
        # at the top of the file next to "default_options"
        # opts.on("-a", "--author=\"Your Name\"", String,
        #         "Some comment about this option",
        #         "Default: none") { |x| options[:author] = x }
        opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
      end

      def extract_options
        # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
        # Templates can access these value via the attr_reader-generated methods, but not the
        # raw instance variable value.
        # @author = options[:author]
      end

      # Installation skeleton.  Intermediate directories are automatically
      # created so don't sweat their absence here.
      BASEDIRS = %w(
        app
        app/controllers
        app/views
        app/models
        app/helpers
        app/tasks
        bin
        config
        config/settings
        config/locales
        doc
        lib
        log
        test
        test/unit
        test/functional
        test/factory
        test/mock
        tmp
        public
      )
  end
end
