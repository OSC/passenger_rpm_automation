#!/bin/bash
set -e

function header()
{
	echo
	echo "----- $@ -----"
}

function run()
{
	echo "+ $@"
	"$@"
}

export HOME=/root
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

header "Creating users"
run groupadd --gid 2467 app
run adduser --uid 2467 --gid 2467 --password '#' app

header "Installing dependencies"
run yum update -y
run yum install -y --enablerepo centosplus --skip-broken centos-release-scl epel-release
run yum install -y --enablerepo centosplus --skip-broken @buildsys-build \
    curl-devel openssl-devel sqlite-devel zlib-devel libxml2-devel libxslt-devel \
	mock git sudo which rpmdevtools
# Temporary to get access to CentOS8 and EPEL8 configs
run yum update -y --enablerepo epel-testing mock-core-configs
run yum install -y scl-utils-build
run yum install -y rh-ruby25-rubygem-bundler rh-ruby25-ruby-devel

run scl enable rh-ruby25 'BUNDLE_GEMFILE=/pra_build/Gemfile bundle install -j 4'

header "Miscellaneous"
run sed -i 's/Defaults    requiretty//' /etc/sudoers
run cp /pra_build/sudoers.conf /etc/sudoers.d/app
run chmod 440 /etc/sudoers.d/app

run usermod -a -G mock app
run sudo -u app -H rpmdev-setuptree

run mkdir -p /etc/container_environment
run cp /pra_build/site-defaults.cfg /etc/mock/site-defaults.cfg
run cp /pra_build/epel-6-x86_64.cfg /etc/mock/epel-6-x86_64.cfg
run cp /pra_build/epel-7-x86_64.cfg /etc/mock/epel-7-x86_64.cfg
run cp /pra_build/epel-8-x86_64.cfg /etc/mock/epel-8-x86_64.cfg

header "Cleaning up"
run yum clean all
run rm -rf /pra_build
