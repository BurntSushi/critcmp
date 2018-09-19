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


### Motivation

This tool is similar to
[cargo-benchcmp](https://github.com/BurntSushi/cargo-benchcmp),
but it works on data gathered by Criterion.

In particular, Criterion emits loads of useful data, but its facilities for
comparing benchmarks and analyzing benchmarks in the aggregate are exceedingly
limited. Criterion does provide the ability to save benchmark results as a
"baseline," and this is primarily the data with which critcmp works with. In
particular, while Criterion will show changes between a saved baseline and the
current benchmark, there is no way to do further comparative analysis by
looking at benchmark results in different views.
