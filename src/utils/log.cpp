#include "log.hpp"
#include <fstream>
#include <iostream>
// examples/sink_formatter_override.cpp
using std::cout, std::endl, std::string;
void quill_init();

void quill_init() {

  // auto time_str = mylocal_time();
  std::filesystem::create_directory("./log_quill/");
  string filename = "log_quill/quill-.log";

  // Start the backend thread
  quill::BackendOptions backend_options;
  quill::Backend::start(backend_options);

  // Console sink
  std::string console_log_pattern =
      "[%(time)][%(log_level)][%(logger)][%(process_id)][%(thread_name)][%("
      "file_name):%(line_number)]-%(message)";
  std::string console_time_format = "%Y-%m-%d %H:%M:%S.%Qms";
  auto console_sink = quill::Frontend::create_or_get_sink<quill::ConsoleSink>(
      "sink_id_1",
      [console_log_pattern,console_time_format]() // Capture console_log_pattern by value
      {
        quill::ConsoleSinkConfig csc;
        csc.set_override_pattern_formatter_options(
            quill::PatternFormatterOptions{console_log_pattern,console_time_format});
        return csc;
      }());
  console_sink->set_log_level_filter(quill::LogLevel::Debug);

  // File sink
  std::string const file_log_pattern =
      "%(log_level);%(time);%(logger);%(message)";
  std::string const file_time_format = "%Y%m%dT%H:%M:%S.%Qms";
  auto rotating_file_sink =
      quill::Frontend::create_or_get_sink<quill::RotatingFileSink>(
          filename, []() {
            // See RotatingFileSinkConfig for more options
            quill::RotatingFileSinkConfig cfg;
            cfg.set_filename_append_option(
                quill::FilenameAppendOption::StartCustomTimestampFormat,
                "%Y-%m-%d");
            cfg.set_open_mode('a');
            cfg.set_max_backup_files(10);
            cfg.set_rotation_time_daily("18:30");
            cfg.set_rotation_max_file_size(1'000'000'000);
            return cfg;
          }());
  rotating_file_sink->set_log_level_filter(quill::LogLevel::Debug);

  // The Logger is using the file_log_pattern by default
  // To output our custom format to the file we use our own
  // ConsoleSinkWithFormatter that is overwriting the default format

  logger = quill::Frontend::create_or_get_logger(
      "logger", {std::move(console_sink), std::move(rotating_file_sink)},
      quill::PatternFormatterOptions{file_log_pattern, file_time_format});

  logger->set_log_level(quill::LogLevel::Debug);

  LOG_INFO(logger, "This is a log info example {}", sizeof(std::string));
}
