require 'sneakers'

Sneakers.configure  :amqp => 'amqp://guest:guest@localhost:5672',
                    :workers => 1,
                    :log => 'sneakers.log',
                    :pid_path => 'sneakers.pid',
                    :timeout_job_after => 5,
                    :prefetch => 1,
                    :threads => 1,
                    :worker => 'MessageWorker',
                    :daemonize => false

Sneakers.logger.level = Logger::INFO

