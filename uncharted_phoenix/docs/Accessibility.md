# Accessibility
We've worked hard to ensure each chart can be accessed by screen readers and keyboards in a meaningful way, and are continuing to improve upon those efforts. Here's what we have in place so far.

## Figure element
Each SVG is wrapped inside a ``` <figure> ``` element. This is because ``` <figure> ``` is an accessible, semantic HTML element.

## Accessible attributes
Each SVG chart has several accessible attributes added to its ``` <figure> ``` wrapper to ensure that screen readers can accurately and efficiently describe each chart.

- ``` role="img" ``` So that screen readers will announce the chart as a visualization
- ``` aria-label ``` So that screen readers will announce what the chart is representing
- ``` alt ``` So that screen readers have a fall back if they don't pick up the ``` aria-label ``` and if the ``` <figure> ``` doesn't render for whatever reason
- ``` tabindex="0" ``` So that the chart is keyboard accessible without disrupting the order of the DOM

## Title element
We've also included a ``` <title> ``` element nested inside each SVG. This ensures that a visible tooltip is available describing what the chart is visualizing.

## Keyboard accessible data tables
The biggest feature included in the charts is a keyboard accessible data table. If a user is navigating the page via keyboard, a data table will appear under each chart when it is in focus. The table is navigable via keyboard. This allows keyboard users to explore the data easily without relying on the visualization, which may not be optimized for color blindness or other visual impairments.

The table visibility is handled through ``` phx-focus ``` and ``` phx-blur ``` events that apply or remove inline CSS styles. We chose this route to keep the library as non-invasive as possible. This approach utilizes LiveView ``` handle_events ``` and allows the library to be free of stylesheets that may interfere with your CSS styles on your site.
