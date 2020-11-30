# Hotlap

Calculates the delta of 2 laptimes

[![Build Status](https://travis-ci.com/pr0grammr/time-ago.svg?branch=master)](https://travis-ci.com/pr0grammr/time-ago)
<a href="https://hexdocs.pm/time_ago/TimeAgo.html#content" target="_blank"><img alt="Hex.pm" src="https://img.shields.io/hexpm/dt/time_ago"></a>
<a href="https://hexdocs.pm/time_ago/TimeAgo.html#content" target="_blank"><img alt="Hex.pm" src="https://img.shields.io/hexpm/v/time_ago"></a>

## Installation

The package can be installed by adding `hotlap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hotlap, "~> 1.0.0"}
  ]
end
```

## Usage

```elixir
# create laptime struct
laptime = %Hotlap.Laptime{minutes: 1, seconds: 22, milliseconds: 455}
# => %Hotlap.Laptime{minutes: 1, seconds: 22, milliseconds: 455}

# create from string
{:ok, laptime} = Hotlap.Laptime.create("01:22.455")
# => %Hotlap.Laptime{minutes: 1, seconds: 22, milliseconds: 455}

# convert to milliseconds
laptime_milliseconds = Hotlap.LaptimeConverter.to_milliseconds(laptime)
# => 82455


# compare two laptimes
{:ok, target_laptime} = Hotlap.Laptime.create("01:22.455")
{:ok, current_laptime} = Hotlap.Laptime.create("01:22.899")
delta = Hotlap.compare(target_laptime, current_laptime)
# => %Hotlap.Delta{minutes: 0, seconds: 0, milliseconds: 455, status: :behind}

# string representation
IO.puts "Target: #{target_laptime}" # => 01:22.455
IO.puts "Current: #{current_laptime}" # => 01:22.899
IO.puts "Delta: #{delta}" # => +0.444
```

## License 

This module is published under the <a href="https://github.com/pr0grammr/time-ago/blob/master/LICENSE">MIT license</a>


