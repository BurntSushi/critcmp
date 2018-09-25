critcmp
=======
A command line tool to for comparing benchmarks run by Criterion. This supports
comparing benchmarks both across and inside baselines, where a "baseline" is
a collection of benchmark data produced by Criterion for a single run.

[![Linux build status](https://api.travis-ci.org/BurntSushi/critcmp.svg)](https://travis-ci.org/BurntSushi/critcmp)
[![Windows build status](https://ci.appveyor.com/api/projects/status/github/BurntSushi/critcmp?svg=true)](https://ci.appveyor.com/project/BurntSushi/critcmp)
[![](http://meritbadge.herokuapp.com/critcmp)](https://crates.io/crates/critcmp)

Dual-licensed under MIT or the [UNLICENSE](http://unlicense.org).


### Installation

Since this tool is primarily for use with the Criterion benchmark harness for
Rust, you should install it with Cargo:

```
$ cargo install critcmp
```

critcmp's minimum supported Rust version is the current stable release.

**WARNING**: This tool explicitly reads undocumented internal data emitted by
Criterion, which means this tool can break at any point if Criterion's internal
data format changes.

critcmp is known to work with **Criterion 0.2.5**. This project will
track the latest release of Criterion if breaking changes to Criterion's
internal format occur, but will also attempt to keep working on older versions
within reason.


### Example

[![A screenshot of a critcmp example](https://burntsushi.net/stuff/critcmp.png)](https://burntsushi.net/stuff/critcmp.png)


### Usage

critcmp works by slurping up all benchmark data from Criterion's target
directory, in addition to extra data supplied as positional parameters. The
primary unit that critcmp works with is Criterion's baselines. That is, the
simplest way to use critcmp is to save two baselines with Criterion's benchmark
harness and then compare them. For example:

    $ cargo bench -- --save-baseline before
    $ cargo bench -- --save-baseline change
    $ critcmp before change

Filtering can be done with the -f/--filter flag to limit comparisons based on
a regex:

    $ critcmp before change -f 'foo.*bar'

Comparisons with very small differences can also be filtered out. For example,
this hides comparisons with differences of 5% or less

    $ critcmp before change -t 5

Comparisons are not limited to only two baselines. Many can be used:

    $ critcmp before change1 change2

The list of available baselines known to critcmp can be printed:

    $ critcmp --baselines

A baseline can exported to one JSON file for more permanent storage outside
of Criterion's target directory:

    $ critcmp --export before > before.json
    $ critcmp --export change > change.json

Baselines saved this way can be used by simply using their file path instead
of just the name:

    $ critcmp before.json change.json

Benchmarks within the same baseline can be compared as well. Normally,
benchmarks are compared based on their name. That is, given two baselines, the
correspondence between benchmarks is established by their name. Sometimes,
however, you'll want to compare benchmarks that don't have the same name. This
can be done by expressing the matching criteria via a regex. For example, given
benchmarks 'optimized/input1' and 'naive/input1' in the baseline 'benches', the
following will show a comparison between the two benchmarks despite the fact
that they have different names:

    $ critcmp benches -g '\\w+/(input1)'

That is, the matching criteria is determined by the values matched by all of
the capturing groups in the regex. All benchmarks with equivalent capturing
groups will be included in one comparison. There is no limit on the number of
benchmarks that can appear in a single comparison.

Finally, if comparisons grow too large to see in the default column oriented
display, then the results can be flattened into lists:

    $ critcmp before change1 change2 change3 change4 change5 --list


### Motivation

This tool is similar to
[cargo-benchcmp](https://github.com/BurntSushi/cargo-benchcmp),
but it works on data gathered by Criterion.

In particular, Criterion emits loads of useful data, but its facilities for
interactively comparing benchmarks and analyzing benchmarks in the aggregate
are exceedingly limited. Criterion does provide the ability to save benchmark
results as a "baseline," and this is primarily the data with which critcmp
works with. In particular, while Criterion will show changes between a saved
baseline and the current benchmark, there is no way to do further comparative
analysis by looking at benchmark results in different views.
