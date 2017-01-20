# Puppetdiff

This plugin adds the ability to generate catalog diffs for a host in different
Puppet environments, and view those diffs in the Host page *before* changing
the environment for real. This is very useful for both server migrations and
Puppet code refactors.

The diffs are generated via the excellent
[octocatalog-diff](https://github.com/github/octocatalog-diff) tool.

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins

This plugin is currently unpackaged and only available via Git for source installs.

## Usage

Enable this plugin, and the [companion Smart-Proxy
plugin](https://github.com/GregSutcliffe/smart_proxy_puppetdiff) on your
Puppetmaster proxy. Then navigate to a host and use the Puppetdiff button at
the top of the page to generate a diff between the hosts current environment
and the target environment.

## TODO

* Clean up JS assets from the Deface override
* Add tests
* Provide more ways to interact with octocatalog-diff

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2017 The Foreman developers

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
