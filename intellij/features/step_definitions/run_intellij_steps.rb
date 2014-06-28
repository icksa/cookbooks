# -*- coding: utf-8 -*-

require 'leibniz'
require 'net/ssh'

Given(/^I have provisioned the following infrastructure:$/) do |specification|
  @infrastructure = Leibniz.build(specification)
end

Given(/^I have run Chef$/) do
  @infrastructure.destroy
  @infrastructure.converge
end

When(/^a user executes ijult$/) do
  # This is not quite the same as executing ijult, but it is close.
  ip = @infrastructure['intellij'].ip
  Net::SSH.start(ip, 'vagrant', :password => "vagrant") do |ssh|
    @output = ssh.exec!("which ijult")
  end
end

Then(/^intellij should run$/) do
  expect(@output).to match(/\/usr\/bin\/ijult/)
end
