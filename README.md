This repository contains programs to calculate the solutions to [Advent of Code
2024](https://adventofcode.com/2024/). It may contain spoilers!

Within each daily directory, the solutions are gathered in `solutionNNx.txt`,
with `NN` the corresponding day, and `x` a letter indicating the sub question of
that day, typically `a` or `b`.

## Tools used

For the solution files that end in `.txt`, I typically use a few Linux tools,
such as:

- `awk`
- `paste`
- `sort`

as well as some `bash` constructs (refer to your shell's manual for equivalent
ones):

- `<( cmd )` for referring to the output of `cmd` as a filename ("Process
  substitution")
- `cmdA | cmdB` for sending the output of `cmdA` to the input of `cmdB`
  ("Pipelines")

In essence, each solution `.txt` expects a file `input` (that contains your
AoC-specific input for that day). The solutions (typically a one-liner) should
be run in a shell, such as `bash`. Upon completion, it will print the solution,
or perhaps some intermediate solutions as well.

If a solution file ends in `.go`, the solution should be run as:

```
go run solutionNNx.go
```

It will look for a file called `input` in the current directory and start
processing. It outputs the solution and/or some intermediate steps.
