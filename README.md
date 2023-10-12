# Consumer Microservice

This microservice is responsible for running background jobs using Sneaker and receiving messages from a Dockerized RabbitMQ using Bunny.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Docker Setup](#docker-setup)
- [Running Background Jobs](#running-background-jobs)

## Overview

The Consumer Microservice is a Ruby application that leverages the Sneaker gem to run background jobs and the Bunny gem to receive messages from a RabbitMQ broker.

## Installation

To get started with the Consumer Microservice, follow these steps:
https://github.com/PrimeRin/rabbitmq-consumer_ms
1. Clone the repository:

   ```bash
   git clone git@github.com:PrimeRin/rabbitmq-consumer_ms.git
   cd consumer_ms
   ```

## Installation

To set up the Consumer Microservice, you'll need to install the required gems 'sneakers' and 'bunny' by adding them to your Gemfile and running `bundle install`.

```ruby
# Add these to your Gemfile
gem 'sneakers'
gem 'bunny'

# Then run
bundle install
```
## Configuration

In your Ruby code, configure Sneakers and Bunny to connect to the RabbitMQ server. Here's an example:

```ruby
# MessageWorker to process background jobs
class MessageWorker
  include Sneakers::Worker
  from_queue 'messages'

  def work(message)
    puts "Received message: #{message}"
    ack! # Acknowledge that the message was received
  end
end

# Configure Sneakers and Bunny
require 'sneakers'

Sneakers.configure(
  :amqp => 'amqp://guest:guest@localhost:5672',
  :workers => 1,
  :log => 'sneakers.log',
  :pid_path => 'sneakers.pid',
  :timeout_job_after => 5,
  :prefetch => 1,
  :threads => 1,
  :worker => 'MessageWorker',
  :daemonize => false
)

Sneakers.logger.level = Logger::INFO
```
## Usage

Your Consumer Microservice is configured to receive messages from RabbitMQ using Bunny and process background jobs with Sneaker. You can integrate this microservice into your application by invoking the appropriate workers and queues.

## Docker Setup

To enable this microservice, you need a Dockerized RabbitMQ instance. You can use the following Docker command to set up RabbitMQ:

```bash
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:management
```
This command will start a RabbitMQ container with the management plugin enabled, allowing you to access the RabbitMQ web management interface at http://localhost:15672.

## Running Background Jobs

To start running background jobs, execute the following Rake task:

```bash
rake sneakers:run
```
This command will initiate the processing of background jobs using Sneakers.
