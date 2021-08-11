# dellperc

* ![CI](https://github.com/lsst-it/puppet-dellperc/actions/workflows/ci.yml/badge.svg)

## Table of Contents


1. [Overview](#overview)
1. [Usage - Configuration options and additional functionality](#usage)

## Overview

Provides the `has_dellperc` fact used to determine if a system has a Dell PERC
RAID controller installed.

## Usage

```puppet
if $facts['has_dellperc'] {
  notice("Dude, you're getting a Dell... rebranded LSI RAID controller.")
}
```
