require_relative '../spec_helper'

describe 'intellij::default' do
  download_path = "#{Chef::Config[:file_cache_path]}/ideaIU-13.1.3.tar.gz"
  install_path = "/opt/ideaIU"

  let(:chef_run) do
    runner = ChefSpec::Runner.new do |node|
      node.set['intellij']['version'] = '13.1.3'
      node.set['intellij']['prefix'] = '/opt'
    end
    runner.converge('recipe[intellij::default]')
  end

  before do
    stub_command("test -d /opt/ideaIU").and_return(false)
  end

  it "installs java" do
    expect(chef_run).to include_recipe('java')
  end
  
  it "downloads the intellij tarball" do
    # ::File.stub(:exists?).with("/opt/ideaIU").and_return false
    #allow(File).to recieve(:exist?).and_return(false)
    expect(chef_run).to create_remote_file(download_path)
  end

  it "places all intellij files in the appropriate install location" do
    # expect(chef_run).to create_remote_file(install_path)
    expect(chef_run).to run_execute('untar-and-install')
  end

  it "cleans up after itself" do 
    expect(chef_run).to delete_file(download_path)
  end

  it "it makes intellij available as a command in the default path" do
    expect(chef_run).to render_file('/usr/bin/ijult').with_content("#{install_path}/bin/idea.sh")
  end
end
