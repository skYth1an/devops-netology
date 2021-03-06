# encoding: UTF-8

require File.expand_path('../setup', File.dirname(__FILE__))

module TestLogging
module TestAppenders

  class TestFile < Test::Unit::TestCase
    include LoggingTestCase

    NAME = 'logfile'

    def setup
      super
      Logging.init

      FileUtils.mkdir [File.join(@tmpdir, 'dir'), File.join(@tmpdir, 'uw_dir')]
      FileUtils.chmod 0555, File.join(@tmpdir, 'uw_dir')
      FileUtils.touch File.join(@tmpdir, 'uw_file')
      FileUtils.chmod 0444, File.join(@tmpdir, 'uw_file')
    end

    def test_factory_method_validates_input
      assert_raise(ArgumentError) do
        Logging.appenders.file
      end
    end

    def test_class_assert_valid_logfile
      log = File.join(@tmpdir, 'uw_dir', 'file.log')
      assert_raise(ArgumentError) do
        Logging.appenders.file(log).class.assert_valid_logfile(log)
      end

      log = File.join(@tmpdir, 'dir')
      assert_raise(ArgumentError) do
        Logging.appenders.file(log).class.assert_valid_logfile(log)
      end

      log = File.join(@tmpdir, 'uw_file')
      assert_raise(ArgumentError) do
        Logging.appenders.file(log).class.assert_valid_logfile(log)
      end

      log = File.join(@tmpdir, 'file.log')
      assert Logging.appenders.file(log).class.assert_valid_logfile(log)
    end

    def test_initialize
      log = File.join(@tmpdir, 'file.log')
      appender = Logging.appenders.file(NAME, :filename => log)
      assert_equal 'logfile', appender.name
      assert_equal ::File.expand_path(log), appender.filename
      appender << "This will be the first line\n"
      appender << "This will be the second line\n"
      appender.flush
      File.open(log, 'r') do |file|
        assert_equal "This will be the first line\n", file.readline
        assert_equal "This will be the second line\n", file.readline
        assert_raise(EOFError) {file.readline}
      end
      cleanup

      appender = Logging.appenders.file(NAME, :filename => log)
      assert_equal 'logfile', appender.name
      assert_equal ::File.expand_path(log), appender.filename
      appender << "This will be the third line\n"
      appender.flush
      File.open(log, 'r') do |file|
        assert_equal "This will be the first line\n", file.readline
        assert_equal "This will be the second line\n", file.readline
        assert_equal "This will be the third line\n", file.readline
        assert_raise(EOFError) {file.readline}
      end
      cleanup

      appender = Logging.appenders.file(NAME, :filename => log,
                                              :truncate => true)
      assert_equal 'logfile', appender.name
      appender << "The file was truncated\n"
      appender.flush
      File.open(log, 'r') do |file|
        assert_equal "The file was truncated\n", file.readline
        assert_raise(EOFError) {file.readline}
      end
      cleanup
    end

    def test_changing_directories
      log = File.join(@tmpdir, 'file.log')
      appender = Logging.appenders.file(NAME, :filename => log)

      assert_equal 'logfile', appender.name
      assert_equal ::File.expand_path(log), appender.filename

      begin
        pwd = Dir.pwd
        Dir.chdir @tmpdir
        assert_nothing_raised { appender.reopen }
      ensure
        Dir.chdir pwd
      end
    end

    def test_encoding
      log = File.join(@tmpdir, 'file-encoding.log')
      appender = Logging.appenders.file(NAME, :filename => log, :encoding => 'ASCII')

      appender << "A normal line of text\n"
      appender << "??mlaut\n"
      appender.close

      lines = File.readlines(log, :encoding => 'UTF-8')
      assert_equal "A normal line of text\n", lines[0]
      assert_equal "??mlaut\n", lines[1]

      cleanup
    end

    def test_reopening_should_not_truncate_the_file
      log = File.join(@tmpdir, 'truncate.log')
      appender = Logging.appenders.file(NAME, filename: log, truncate: true)

      appender << "This will be the first line\n"
      appender << "This will be the second line\n"
      appender << "This will be the third line\n"
      appender.reopen

      File.open(log, 'r') do |file|
        assert_equal "This will be the first line\n", file.readline
        assert_equal "This will be the second line\n", file.readline
        assert_equal "This will be the third line\n", file.readline
        assert_raise(EOFError) {file.readline}
      end

      cleanup
    end

  private
    def cleanup
      unless Logging.appenders[NAME].nil?
        Logging.appenders[NAME].close false
        Logging.appenders[NAME] = nil
      end
    end
  end  # TestFile

end  # TestAppenders
end  # TestLogging

