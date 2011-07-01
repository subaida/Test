require File.expand_path(File.dirname(__FILE__) + "/../lib/ap4r/service_handler.rb")

namespace :test do

#  task :asyncs do
#    setup - run - teardown comes here.
#    Names should be considered further.
#  end

  namespace :asyncs do

    desc "Start Rails and AP4R servers to test:asyncs:exec"
    task :arrange do |t|
      ap4r_handler = Ap4r::ServiceHandler.new
      ap4r_handler.start_rails_service
      ap4r_handler.start_ap4r_service
    end

    desc "Start Rails and AP4R servers to test:asyncs:exec"
    task :cleanup do |t|
      ap4r_handler = Ap4r::ServiceHandler.new
      ap4r_handler.stop_ap4r_service
      ap4r_handler.stop_rails_service
    end

    Rake::TestTask.new(:run => "db:test:prepare") do |t|
      t.libs << "test"
      t.pattern = 'test/async/**/*_test.rb'
      t.verbose = true
    end
    Rake::Task['test:asyncs:run'].comment = "Run the unit tests in test/async"

  end

end
