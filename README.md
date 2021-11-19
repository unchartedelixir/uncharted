# Uncharted
A simple ***Elixir*** charting library with beautiful dynamic charts.
View our [demo](https://unchartedelixir.herokuapp.com/) of all the uncharted possibilities.

Build status: [![CircleCI](https://circleci.com/gh/unchartedelixir/uncharted/tree/master.svg?style=svg)](https://circleci.com/gh/unchartedelixir/uncharted/tree/master)

## Features
- Easily generate pie charts, column charts, bar charts, progress counters, and line charts
- Generates responsive and accessible SVGs as LiveView components
- Provides advanced styling like gradients and rounded corners
- Smooth animations for updating live data to the UI

## Uncharted Phoenix library
Uncharted Phoenix is a Hex package that generates SVGs as live view components. It builds on the
basic chart package Uncharted and adapts Uncharted charts for display as components in LiveView.

***Uncharted Visuals***:
- The Bar Chart
- The Column Chart
- The Doughnut Chart
- The Funnel Chart
- The Horizontal Funnel Chart
- The Line Chart
- The Pie Chart
- The Progress Chart
- The Scatter Plot
- The Stacked Column Chart

### Example Application
The [Uncharted Demo](https://github.com/unchartedelixir/demo) is a working example of each of the Uncharted chart components.

To start the demo Phoenix server:

* Install dependencies with `mix deps.get`
* Install Node.js dependencies with `npm install` inside the assets directory
* Start Phoenix endpoint with `mix phx.server`

Now you can visit `localhost:4000` from your browser.


## Contributing

We appreciate any contribution to Uncharted!

To contribute feedback, please open a GitHub issue.

To contribute a specific feature or bugfix, please open a PR. Before submitting your PR, we ask you to run the Elixir
tests, lint, and formatting tools we use on the project. If you have a contribution to make but don't know how to run
the tools below, go ahead and open it and we will help you. For larger changes, open an issue first so that we can have
a discussion before you put a lot of work into a PR.

To run the tests and formatting tools:

```
$ mix deps.get
$ mix test
$ mix format
$ mix credo --strict
 ```
