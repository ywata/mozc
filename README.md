[Mozc - a Japanese Input Method Editor designed for multi-platform](https://github.com/google/mozc)
===================================

Copyright 2010-2018, Google Inc.

Mozc is a Japanese Input Method Editor (IME) designed for multi-platform such as
Android OS, Apple OS X, Chromium OS, GNU/Linux and Microsoft Windows.  This
OpenSource project originates from
[Google Japanese Input](http://www.google.com/intl/ja/ime/).

Build Status
------------

|Android + OS X + Linux + NaCl |Windows |
|:----------------------------:|:------:|
[![Build Status](https://travis-ci.org/ywata/mozc.svg?branch=master)](https://travis-ci.org/ywata/mozc) |[![Build status](https://ci.appveyor.com/api/projects/status/1rvmtp7f80jv7ehf/branch/master?svg=true)](https://ci.appveyor.com/project/ywata/mozc/branch/master) |

What's Mozc?
------------
For historical reasons, the project name *Mozc* has two different meanings:

1. Internal code name of Google Japanese Input that is still commonly used
   inside Google.
2. Project name to release a subset of Google Japanese Input in the form of
   source code under OSS license without any warranty nor user support.

In this repository, *Mozc* means the second definition unless otherwise noted.

Detailed differences between Google Japanese Input and Mozc are described in [About Branding](docs/about_branding.md).

Build Instructions
------------------

* [How to build Mozc in Docker](docs/build_mozc_in_docker.md): Android, NaCl, and Linux desktop builds.
* [How to build Mozc in OS X](docs/build_mozc_in_osx.md): OS X build.
* [How to build Mozc in Windows](docs/build_mozc_in_windows.md): Windows build.

Release Plan
------------

tl;dr. **There is no stable version.**

As described in [About Branding](docs/about_branding.md) page, Google does
not promise any official QA for OSS Mozc project.  Because of this,
Mozc does not have a concept of *Stable Release*.  Instead we change version
number every time when we introduce non-trivial change.  If you are
interested in packaging Mozc source code, or developing your own products
based on Mozc, feel free to pick up any version.  They should be equally
stable (or equally unstable) in terms of no official QA process.

[Release History](docs/release_history.md) page may have additional
information and useful links about recent changes.

License
-------

All Mozc code written by Google is released under
[The BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause).
For thrid party code under [src/third_party](src/third_party) directory,
see each sub directory to find the copyright notice.  Note also that
outside [src/third_party](src/third_party) following directories contain
thrid party code.

### [src/data/dictionary_oss/](src/data/dictionary_oss)

Mixed.
See [src/data/dictionary_oss/README.txt](src/data/dictionary_oss/README.txt)

### [src/data/test/dictionary/](src/data/test/dictionary)

The same to [src/data/dictionary_oss/](src/data/dictionary_oss).
See [src/data/dictionary_oss/README.txt](src/data/dictionary_oss/README.txt)

### [src/data/test/stress_test/](src/data/test/stress_test)

Public Domain.  See the comment in
[src/data/test/stress_test/sentences.txt](src/data/test/stress_test/sentences.txt)

### [src/data/unicode/](src/data/unicode)

UNICODE, INC. LICENSE AGREEMENT.
See each file header for details.


Mozc Update project, not provided by Google
-------------------------------------------

The aurhor is currently working on mozc buildable with gradle.
This is because google's mozc project has no update since around 2018 and
I'd like to make small modification to Japanese input keyboard on Android.

The author has no knowleage about Android, gradle nor gyp etc to build Android mozc application,
the way I have to make application buildable and also make test successfuly run.
Making source code buildable was relatively easy but I struggled to make tests buildable.
Even though most of the tests are buildable, many tests do not finish successufly at the time moment.

While I struggled test buildable,
I decided to make update procedure reproducable for experienced developper
so that someone who has much knowleage about Android etc can improve my effort without trials and error.

Strategies
-----------

I investigated some of forked repository. I found Kurage project(https://github.com/TinyFort/Kurage)
itroduced big change against Mozc. The project already adapted to gradle as a build system.
It contained some improvement to UI of mozc but I did not chooose the project as the origin of fork.
Because the project changed package names etc from org.mozc to net.tinyfort.kurage and I thought
it make my project incompatible to many of the existing forked repositories. Although I did not forked from
Kurage project, I owe some of the results below to Kurage project.

They includes:
- Docker file and scripts in docker/ubuntu18.03/
- Build script in builder/
- Initial gradle related setups.


Other than I used the above, here are my strategy I took:
- Keep original package names as they are.
- Make Android application buildable with gradle (to work on Android Studio)
- Choose Android API 28 as standard API (because my smart phone runs on Android Pie)
- Build step is divided into three steps as in builder/android-debug-build.sh
  - run python build_mozc.py gyp
  - run python build_mozc.py build
  - run ./gradlew assemble
- Test should be also migrated.
- Make migration process reproducable.

Branches
--------

I created the following branches which are relatively independent:
All the following branches are created from latest google's master branch.

- enable-docker
  Update docker to ubuntu18.04. Mostly from Kurage project.
- enable-gradle
  Introduce gradle file
- adjust-gyps
  Update some gyp files
- introduce-builder
  Build script.
  Mostly from Kurage project.
- move-main
  Move source code to gradle layout and make android application buildable.
- move-test
  Move source code to gradle layout.

- revive-tests
  The above branches are merges to a branch created from master.
  Update to tests code and gradle settings are updated directly on this branch.







